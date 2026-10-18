// Pruebas del motor en Node con stubs de la API de Max (outlet, Global, jsarguments).
// Uso: node tests/test_engine.js

"use strict";

var fs = require("fs");
var path = require("path");
var vm = require("vm");
var assert = require("assert");

var SRC = fs.readFileSync(path.join(__dirname, "..", "midirain_engine.js"), "utf8");

// carga una instancia nueva del motor con reloj y aleatoriedad controlados
function load(opts) {
    opts = opts || {};
    var globals = {};
    var out = [];
    var clock = { t: 1000000 };
    var rand = opts.random || Math.random;
    function FakeDate() {}
    FakeDate.now = function () { return clock.t; };
    var math = Object.create(Math);
    math.random = rand;

    var ctx = {
        jsarguments: ["midirain_engine.js", opts.arg || "1234mr"],
        outlet: function () { out.push(Array.prototype.slice.call(arguments)); },
        Global: function (name) {
            if (!globals[name]) globals[name] = {};
            return globals[name];
        },
        post: function () {},
        Date: FakeDate,
        Math: math
    };
    vm.createContext(ctx);
    vm.runInContext(SRC, ctx, { filename: "midirain_engine.js" });
    return {
        ctx: ctx,
        out: out,
        clock: clock,
        globals: globals,
        state: function () { return globals["midirain_" + (opts.arg || "1234mr")].state; },
        advance: function (ms) { clock.t += ms; }
    };
}

// mensajes de un outlet concreto, sin el índice
function outOf(out, n) {
    return out.filter(function (m) { return m[0] === n; }).map(function (m) { return m.slice(1); });
}
function notesOf(out) { return outOf(out, 0); }

var tests = [];
function test(name, fn) { tests.push({ name: name, fn: fn }); }

// ---------------------------------------------------------------------------

test("columnas por defecto: Do menor de 48 a 72", function () {
    var e = load();
    assert.deepStrictEqual(Array.from(e.state().cols),
        [48, 50, 51, 53, 55, 56, 58, 60, 62, 63, 65, 67, 68, 70, 72]);
    assert.strictEqual(e.state().labels[0], "C2");
    assert.strictEqual(e.state().labels[7], "C3");     // C3 = 60
});

test("cada escala respeta tónica y rango", function () {
    var e = load();
    var c = e.ctx;
    c.tonic(2); c.scale(0); c.low(60); c.high(72);     // Re mayor
    assert.deepStrictEqual(Array.from(e.state().cols), [61, 62, 64, 66, 67, 69, 71]);
    c.scale(8);                                         // Pentatónica menor de Re
    assert.deepStrictEqual(Array.from(e.state().cols), [60, 62, 65, 67, 69, 72]);
    c.scale(10);                                        // Cromática
    assert.strictEqual(e.state().cols.length, 13);
    c.scale(9); c.tonic(0); c.low(48); c.high(59);      // Blues de Do
    assert.deepStrictEqual(Array.from(e.state().cols), [48, 51, 53, 54, 55, 58]);
});

test("rango invertido se corrige y rango vacío da cero columnas", function () {
    var e = load();
    e.ctx.low(72); e.ctx.high(48);
    assert.strictEqual(e.state().cols[0], 48);
    assert.strictEqual(e.state().cols[e.state().cols.length - 1], 72);
    e.ctx.scale(0); e.ctx.tonic(0); e.ctx.low(61); e.ctx.high(61);  // C#: no está en Do mayor
    assert.strictEqual(e.state().cols.length, 0);
});

test("modo MIDI: columnas = notas pulsadas, ordenadas, sin notas no suena", function () {
    var e = load({ random: function () { return 0.5; } });
    var c = e.ctx;
    c.mode(1);
    assert.strictEqual(e.state().cols.length, 0);
    c.density(100);
    for (var i = 0; i < 100; i++) { e.advance(10); c.bang(); }
    assert.ok(e.state().splashes.length > 0, "la lluvia sigue cayendo");
    assert.strictEqual(notesOf(e.out).length, 0, "pero no suena");

    c.note(67, 100); c.note(60, 90); c.note(64, 80); c.note(60, 70);
    assert.deepStrictEqual(Array.from(e.state().cols), [60, 64, 67]);
    c.note(64, 0);
    assert.deepStrictEqual(Array.from(e.state().cols), [60, 67]);
    for (i = 0; i < 100; i++) { e.advance(10); c.bang(); }
    var n = notesOf(e.out);
    assert.ok(n.length > 0);
    n.forEach(function (m) { assert.ok(m[0] === 60 || m[0] === 67); });

    c.mode(0);
    assert.strictEqual(e.state().cols.length, 15, "vuelve a la escala");
});

test("impacto: columna según x, velocity según tamaño, duración del dial", function () {
    var e = load();
    var c = e.ctx;
    c.dur(250);
    var S = e.state();
    S.drops = [{ x: 0.01, y: 0.999, vy: 1, s: 0 }, { x: 0.999, y: 0.999, vy: 1, s: 1 }];
    c.density(0);
    e.advance(10); c.bang(); e.advance(10); c.bang();
    var n = notesOf(e.out);
    assert.deepStrictEqual(n[0], [48, 30, 250]);
    assert.deepStrictEqual(n[1], [72, 127, 250]);
    assert.ok(e.state().flashT[0] > 0 && e.state().flashT[14] > 0);
});

test("viento: las gotas que salen por un lado entran por el otro", function () {
    var e = load();
    var c = e.ctx;
    c.density(0); c.wind(100);
    e.state().drops = [{ x: 0.99, y: 0, vy: 0.5, s: 0.5 }];
    e.advance(10); c.bang();
    for (var i = 0; i < 5; i++) { e.advance(20); c.bang(); }
    var d = e.state().drops[0];
    assert.ok(d.x >= 0 && d.x < 0.5, "x envuelto: " + d.x);
    c.wind(-100);
    e.state().drops = [{ x: 0.001, y: 0, vy: 0.5, s: 0.5 }];
    e.advance(20); c.bang();
    assert.ok(e.state().drops[0].x > 0.9);
});

test("densidad cuadrática: ~60 gotas/s al 100 %, ~15 al 50 %, tope de 400", function () {
    var e = load();
    var c = e.ctx;
    c.fall(0);              // caen despacio: nadie llega al suelo en 1 s
    c.density(50);
    e.advance(10); c.bang();
    for (var i = 0; i < 100; i++) { e.advance(10); c.bang(); }
    var n = e.state().drops.length;
    assert.ok(n >= 14 && n <= 16, "50 %: " + n);
    c.density(100);
    for (i = 0; i < 100; i++) { e.advance(10); c.bang(); }
    var m = e.state().drops.length - n;
    assert.ok(m >= 55 && m <= 65, "100 %: " + m);
    for (i = 0; i < 1000; i++) { e.advance(10); c.bang(); }
    assert.ok(e.state().drops.length <= 400);
});

test("delta-time recortado a 100 ms", function () {
    var e = load();
    var c = e.ctx;
    c.density(0);
    e.advance(10); c.bang();
    e.state().drops = [{ x: 0.5, y: 0, vy: 1, s: 0 }];
    e.advance(5000); c.bang();
    assert.ok(Math.abs(e.state().drops[0].y - 0.1) < 1e-9);
});

test("sync: los impactos se encolan y suenan en el pulso de la rejilla", function () {
    var e = load();
    var c = e.ctx;
    c.density(0);
    c.playing(1);
    c.sync(2);
    var ctl = outOf(e.out, 2).slice(-3);
    assert.deepStrictEqual(ctl, [["interval", "16n"], ["quantize", "16n"], [1]]);
    c.grid();                                   // hay transporte
    e.advance(10); c.bang();
    e.state().drops = [
        { x: 0.01, y: 0.999, vy: 1, s: 0.2 },
        { x: 0.02, y: 0.999, vy: 1, s: 0.9 },   // misma columna: se funden, gana la fuerte
        { x: 0.99, y: 0.999, vy: 1, s: 0.5 }
    ];
    e.advance(10); c.bang();
    assert.strictEqual(notesOf(e.out).length, 0, "nada antes del pulso");
    e.advance(100); c.grid();
    var n = notesOf(e.out);
    assert.strictEqual(n.length, 2);
    assert.strictEqual(n[0][0], 48);
    assert.strictEqual(n[0][1], Math.round(30 + 97 * 0.9));
    assert.strictEqual(n[1][0], 72);
});

test("sync: sin pulsos durante más de 400 ms, suena inmediatamente", function () {
    var e = load();
    var c = e.ctx;
    c.density(0);
    c.sync(3);
    c.grid();
    e.advance(10); c.bang();
    e.state().drops = [{ x: 0.5, y: 0.999, vy: 1, s: 0.5 }];
    e.advance(10); c.bang();
    assert.strictEqual(notesOf(e.out).length, 0);
    for (var i = 0; i < 38; i++) { e.advance(10); c.bang(); }   // ~400 ms desde el pulso
    assert.strictEqual(notesOf(e.out).length, 0, "aún dentro de la ventana");
    for (i = 0; i < 3; i++) { e.advance(10); c.bang(); }
    assert.strictEqual(notesOf(e.out).length, 1, "fallback");
    // con el transporte parado, los siguientes impactos suenan en el mismo tick
    e.state().drops = [{ x: 0.1, y: 0.999, vy: 1, s: 0.5 }];
    e.advance(10); c.bang();
    assert.strictEqual(notesOf(e.out).length, 2);
});

test("sync lento: con el tempo de Live, espera el pulso aunque tarde más de 400 ms", function () {
    var e = load();
    var c = e.ctx;
    c.density(0);
    c.tempo(60);
    c.playing(1);
    c.sync(4);                                  // 1/4 a 60 bpm = 1000 ms
    c.grid();                                   // primer pulso: aún no hay intervalo medido
    e.advance(10); c.bang();
    e.state().drops = [{ x: 0.5, y: 0.999, vy: 1, s: 0.5 }];
    e.advance(10); c.bang();
    for (var i = 0; i < 97; i++) { e.advance(10); c.bang(); }   // 990 ms tras el pulso
    assert.strictEqual(notesOf(e.out).length, 0, "no se adelanta al pulso");
    e.advance(10); c.grid();
    assert.strictEqual(notesOf(e.out).length, 1);
});

test("sync: al activarlo con el transporte en marcha, espera el primer pulso", function () {
    var e = load();
    var c = e.ctx;
    c.density(0);
    c.tempo(60);
    c.playing(1);
    e.advance(10); c.bang();
    c.sync(3);                                  // 1/8 a 60 bpm = 500 ms, aún sin pulsos
    e.state().drops = [{ x: 0.5, y: 0.999, vy: 1, s: 0.5 }];
    for (var i = 0; i < 45; i++) { e.advance(10); c.bang(); }
    assert.strictEqual(notesOf(e.out).length, 0);
    c.grid();
    assert.strictEqual(notesOf(e.out).length, 1);
});

test("sync con Live parado: rejilla propia en ms al tempo, y sigue cuantizando", function () {
    var e = load();
    var c = e.ctx;
    c.density(0);
    c.tempo(120);
    c.playing(1);
    c.sync(2);                                  // 1/16 a 120 bpm = 125 ms
    c.playing(0);
    assert.deepStrictEqual(outOf(e.out, 2).slice(-3), [["quantize", 0], ["interval", 125], [1]],
        "parado: metro en ms, que corre sin transporte");
    c.grid();
    e.advance(10); c.bang();
    e.state().drops = [{ x: 0.5, y: 0.999, vy: 1, s: 0.5 }];
    for (var i = 0; i < 10; i++) { e.advance(10); c.bang(); }
    assert.strictEqual(notesOf(e.out).length, 0, "parado también espera al pulso");
    c.grid();
    assert.strictEqual(notesOf(e.out).length, 1);

    c.tempo(60);                                // la rejilla en ms sigue al tempo
    assert.deepStrictEqual(outOf(e.out, 2).slice(-3), [["quantize", 0], ["interval", 250], [1]]);
    c.playing(1);                               // en play vuelve a la rejilla del transporte
    assert.deepStrictEqual(outOf(e.out, 2).slice(-3), [["interval", "16n"], ["quantize", "16n"], [1]]);
});

test("volver a Libre para el metro y vacía la cola", function () {
    var e = load();
    var c = e.ctx;
    c.density(0);
    c.sync(1); c.grid();
    e.advance(10); c.bang();
    e.state().drops = [{ x: 0.5, y: 0.999, vy: 1, s: 0.5 }];
    e.advance(10); c.bang();
    assert.strictEqual(notesOf(e.out).length, 0);
    c.sync(0);
    assert.deepStrictEqual(outOf(e.out, 2).slice(-1), [[0]], "metro parado");
    assert.strictEqual(notesOf(e.out).length, 1);
});

test("la UI recibe draw <nombreGlobal> a ~60 fps y el nombre es único por instancia", function () {
    var e = load({ arg: "777mr" });
    e.ctx.density(0);
    for (var i = 0; i < 100; i++) { e.advance(10); e.ctx.bang(); }
    var draws = outOf(e.out, 1);
    assert.ok(draws.length >= 50 && draws.length <= 64, "draws: " + draws.length);
    assert.deepStrictEqual(draws[0], ["draw", "midirain_777mr"]);
    var f = load({ arg: "---mr" });
    assert.ok(Object.keys(f.globals)[0] !== "midirain_---mr");
});

test("viento por defecto en 10 y marca de tiempo del paso para que la UI extrapole", function () {
    var e = load();
    var c = e.ctx;
    c.density(0);
    e.advance(10); c.bang();
    e.state().drops = [{ x: 0.5, y: 0, vy: 1, s: 0.5 }];
    e.advance(100); c.bang();
    assert.ok(Math.abs(e.state().drops[0].x - (0.5 + 0.1 * 0.6 * 0.1)) < 1e-9);
    assert.strictEqual(e.state().stepT, e.clock.t);
    assert.strictEqual(e.state().windN, 0.1);
});

test("tick y grid marcados como immediate", function () {
    var e = load();
    assert.strictEqual(e.ctx.bang.immediate, 1);
    assert.strictEqual(e.ctx.tick.immediate, 1);
    assert.strictEqual(e.ctx.grid.immediate, 1);
});

// ---------------------------------------------------------------------------

var failed = 0;
tests.forEach(function (t) {
    try {
        t.fn();
        console.log("ok   " + t.name);
    } catch (err) {
        failed++;
        console.log("FAIL " + t.name + "\n     " + err.message);
    }
});
console.log("\n" + (tests.length - failed) + "/" + tests.length + " pruebas");
process.exit(failed ? 1 : 0);
