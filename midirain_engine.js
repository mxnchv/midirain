// midirain_engine.js
// Motor de midirain: simulación de la lluvia, columnas y salida de notas.
// Corre en [js midirain_engine.js ---mr], movido por un [metro 10].
// ES5 para el motor [js] clásico de Max.
//
// Entrada (inlet 0):
//   bang              tick de simulación (desde [metro 10])
//   grid              pulso de la rejilla del transporte (desde el metro de sync)
//   note p v          nota de la entrada MIDI (modo MIDI)
//   playing 0|1       estado del transporte de Live (live.observer is_playing)
//   tempo bpm         tempo de Live (live.observer tempo)
//   density / fall / wind / distance / dur / mode / tonic / scale / low / high / sync <valor>
// Salida:
//   outlet 0          pitch velocity duración  ->  [unpack 0 0 0] -> [makenote]
//   outlet 1          draw <nombreGlobal>      ->  [jsui midirain_ui.js]
//   outlet 2          control del metro de sync (interval / quantize / 1 / 0):
//                     con Live en play, rejilla del transporte (16n…, alineada al compás);
//                     con Live parado, la misma rejilla en ms al tempo del proyecto
//   outlet 3          texto del valor de cada knob ("density 30 %", "wind 10"…),
//                     que se muestra debajo del live.dial

autowatch = 0;
inlets = 1;
outlets = 4;

var MAX_DROPS = 400;
var MAX_SPLASHES = 160;
var SPLASH_LIFE = 450;      // ms
var FLASH_LIFE = 400;       // ms
var MAX_DT = 0.1;           // s, recorte de delta-time por frame
var DRAW_EVERY = 16;        // ms, ~60 fps de mensajes a la UI
var FALLBACK_MS = 400;      // sin pulsos de rejilla durante esto -> suena ya (mínimo)
var WIND_SLOPE = 0.6;       // desplazamiento x por unidad de caída con viento al 100 %

var NOTE_NAMES = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];

var SCALES = [
    [0, 2, 4, 5, 7, 9, 11],         // Mayor
    [0, 2, 3, 5, 7, 8, 10],         // Menor
    [0, 2, 3, 5, 7, 9, 10],         // Dórica
    [0, 1, 3, 5, 7, 8, 10],         // Frigia
    [0, 2, 4, 6, 7, 9, 11],         // Lidia
    [0, 2, 4, 5, 7, 9, 10],         // Mixolidia
    [0, 2, 3, 5, 7, 8, 11],         // Menor armónica
    [0, 2, 4, 7, 9],                // Pentatónica mayor
    [0, 3, 5, 7, 10],               // Pentatónica menor
    [0, 3, 5, 6, 7, 10],            // Blues
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]  // Cromática
];

// índice del menú Sync -> valor de nota para el metro tempo-relativo
var SYNC_VALUES = [null, "32n", "16n", "8n", "4n"];
var SYNC_LABELS = ["Free", "1/32", "1/16", "1/8", "1/4"];
var SYNC_BEATS = [0, 0.125, 0.25, 0.5, 1];

// ---------------------------------------------------------------------------
// Global compartido con la UI. M4L sustituye "---" por un ID único por instancia;
// fuera de Live no se sustituye, así que añadimos un sufijo aleatorio.

var instanceId = (typeof jsarguments !== "undefined" && jsarguments.length > 1) ? String(jsarguments[1]) : "mr";
if (instanceId.indexOf("---") === 0) {
    instanceId = instanceId.substring(3) + "_" + Math.floor(Math.random() * 1e9);
}
var GNAME = "midirain_" + instanceId;
var shared = new Global(GNAME);

// parámetros
var P = {
    density: 30,    // %
    fall: 40,       // %
    wind: 10,       // -100..100, un poco de inclinación por defecto
    distance: 50,   // %: 50 = reparto de tamaños de siempre; más = lluvia más lejana
    dur: 150,       // ms
    mode: 0,        // 0 Escala, 1 MIDI
    tonic: 0,
    scale: 1,       // Menor
    low: 48,
    high: 72,
    sync: 0         // 0 Libre
};

// estado que lee la UI (las listas se sustituyen enteras, nunca a medias)
var S = {
    drops: [],      // {x, y, vy, s}
    splashes: [],   // {x, t, s, seed}
    cols: [],       // pitches de las columnas, de grave a agudo
    labels: [],     // nombres de nota de cada columna
    flashT: [],     // ms del último destello por columna
    flashV: [],     // velocity del último destello por columna
    mode: 0,
    windN: 0,
    fallN: 0.4,
    rate: 0,
    stepT: 0,       // ms del último paso: la UI extrapola desde aquí
    syncLabel: "Free"
};
shared.state = S;

var held = {};          // notas pulsadas en la entrada MIDI
var queue = [];         // notas encoladas en modo sync: {p, v}
var spawnAcc = 0;
var lastTick = 0;
var lastDraw = 0;
var lastGrid = 0;          // último pulso de rejilla, o el momento en que empezamos a esperarlo
var transportOn = -1;      // -1 desconocido, 0 parado, 1 en marcha
var bpm = 120;

function now() {
    return Date.now();
}

function clamp(v, lo, hi) {
    return v < lo ? lo : (v > hi ? hi : v);
}

function noteName(n) {
    return NOTE_NAMES[n % 12] + (Math.floor(n / 12) - 2);   // convención de Live: C3 = 60
}

// ---------------------------------------------------------------------------
// columnas

function scaleColumns(tonic, scaleIdx, lo, hi) {
    var steps = SCALES[clamp(scaleIdx, 0, SCALES.length - 1)];
    var out = [];
    var n, pc, i;
    if (lo > hi) {
        n = lo; lo = hi; hi = n;
    }
    lo = clamp(lo, 0, 127);
    hi = clamp(hi, 0, 127);
    for (n = lo; n <= hi; n++) {
        pc = ((n - tonic) % 12 + 12) % 12;
        for (i = 0; i < steps.length; i++) {
            if (steps[i] === pc) {
                out.push(n);
                break;
            }
        }
    }
    return out;
}

function heldColumns() {
    var out = [];
    var k;
    for (k in held) {
        if (held.hasOwnProperty(k)) out.push(Number(k));
    }
    out.sort(function (a, b) { return a - b; });
    return out;
}

function rebuildColumns() {
    var cols = (P.mode === 1) ? heldColumns() : scaleColumns(P.tonic, P.scale, P.low, P.high);
    var labels = [];
    var flashT = [];
    var flashV = [];
    var i, j;
    for (i = 0; i < cols.length; i++) {
        labels.push(noteName(cols[i]));
        flashT.push(0);
        flashV.push(0);
        // conserva el destello de una nota que sigue estando
        for (j = 0; j < S.cols.length; j++) {
            if (S.cols[j] === cols[i]) {
                flashT[i] = S.flashT[j];
                flashV[i] = S.flashV[j];
                break;
            }
        }
    }
    S.cols = cols;
    S.labels = labels;
    S.flashT = flashT;
    S.flashV = flashV;
    S.mode = P.mode;
}

// ---------------------------------------------------------------------------
// simulación

function baseSpeed() {
    // alturas por segundo
    return 0.25 + 2.25 * (P.fall / 100);
}

function spawnRate() {
    var d = P.density / 100;
    return 60 * d * d;
}

// Exponente del reparto de tamaños: s = random^exp. Con exp > 1 abundan las
// gotas pequeñas (lejanas, suaves). Distance al 50 % da 1.7, el reparto de
// siempre; al 100 %, 6.8 (casi todo llovizna); al 0 %, 0.425 (casi todo goterones).
function sizeExponent() {
    return 1.7 * Math.pow(4, (P.distance - 50) / 50);
}

function spawnDrop() {
    var s = Math.pow(Math.random(), sizeExponent());
    return {
        x: Math.random(),
        y: -Math.random() * 0.08,
        vy: baseSpeed() * (0.75 + 0.6 * s),
        s: s
    };
}

function step(dt, t) {
    var windN = P.wind / 100;
    var old = S.drops;
    var drops = [];
    var i, d, x;

    for (i = 0; i < old.length; i++) {
        d = old[i];
        d.y += d.vy * dt;
        x = d.x + windN * WIND_SLOPE * d.vy * dt;
        d.x = x - Math.floor(x);    // lo que sale por un lado entra por el otro
        if (d.y >= 1) {
            impact(d.x, d.s, t);
        } else {
            drops.push(d);
        }
    }

    spawnAcc += spawnRate() * dt;
    while (spawnAcc >= 1) {
        spawnAcc -= 1;
        if (drops.length < MAX_DROPS) drops.push(spawnDrop());
    }

    S.drops = drops;
    S.stepT = t;
    S.windN = windN;
    S.fallN = P.fall / 100;
    S.rate = spawnRate();

    if (S.splashes.length) {
        var sp = [];
        for (i = 0; i < S.splashes.length; i++) {
            if (t - S.splashes[i].t < SPLASH_LIFE) sp.push(S.splashes[i]);
        }
        S.splashes = sp;
    }
}

function impact(x, s, t) {
    var n = S.cols.length;
    var c, v;
    if (S.splashes.length < MAX_SPLASHES) {
        S.splashes.push({ x: x, t: t, s: s, seed: Math.random() * 1000 });
    }
    if (!n) return;     // modo MIDI sin notas: llueve pero no suena
    c = Math.min(n - 1, Math.floor(x * n));
    v = clamp(Math.round(30 + 97 * s), 1, 127);
    if (P.sync === 0) {
        play(S.cols[c], v, t);
    } else {
        enqueue(S.cols[c], v);
    }
}

function enqueue(p, v) {
    var i;
    // varias gotas en la misma nota y el mismo pulso: una sola nota, la más fuerte
    for (i = 0; i < queue.length; i++) {
        if (queue[i].p === p) {
            if (v > queue[i].v) queue[i].v = v;
            return;
        }
    }
    queue.push({ p: p, v: v });
}

function play(p, v, t) {
    var i;
    outlet(0, p, v, P.dur);
    for (i = 0; i < S.cols.length; i++) {
        if (S.cols[i] === p) {
            S.flashT[i] = t;
            S.flashV[i] = v;
            break;
        }
    }
}

function flush() {
    var q = queue;
    var t = now();
    var i;
    queue = [];
    for (i = 0; i < q.length; i++) play(q[i].p, q[i].v, t);
}

function gridInterval() {
    return SYNC_BEATS[P.sync] * 60000 / bpm;
}

function fallbackWindow() {
    // con rejillas lentas (1/4 a poco tempo) el hueco normal entre pulsos supera 400 ms
    return Math.max(FALLBACK_MS, gridInterval() * 1.5);
}

// ---------------------------------------------------------------------------
// mensajes

function bang() {
    tick();
}
bang.immediate = 1;

function tick() {
    var t = now();
    var dt = lastTick ? (t - lastTick) / 1000 : 0;
    lastTick = t;
    dt = clamp(dt, 0, MAX_DT);

    step(dt, t);

    // red de seguridad: si los pulsos dejan de llegar, suena inmediatamente
    if (P.sync !== 0 && queue.length && t - lastGrid > fallbackWindow()) {
        flush();
    }

    if (t - lastDraw >= DRAW_EVERY) {
        lastDraw = t;
        outlet(1, "draw", GNAME);
    }
}
tick.immediate = 1;

function grid() {
    lastGrid = now();
    flush();
}
grid.immediate = 1;

function playing(v) {
    transportOn = Number(v) ? 1 : 0;
    lastGrid = now();       // espera el primer pulso de la rejilla nueva, como mucho una ventana
    applyGrid();
}
playing.immediate = 1;

function tempo(v) {
    if (!(Number(v) > 0)) return;
    bpm = Number(v);
    if (P.sync !== 0 && transportOn !== 1) applyGrid();     // la rejilla en ms sigue al tempo
}

// Configura el metro de la rejilla. Con el transporte en marcha usa valores de
// nota (solo corre en play y va alineado al compás); parado, el mismo intervalo
// en ms, que corre siempre: así se cuantiza también con Live en stop.
function applyGrid() {
    if (P.sync === 0) {
        outlet(2, 0);
        return;
    }
    if (transportOn === 1) {
        outlet(2, "interval", SYNC_VALUES[P.sync]);
        outlet(2, "quantize", SYNC_VALUES[P.sync]);
    } else {
        outlet(2, "quantize", 0);
        outlet(2, "interval", gridInterval());
    }
    outlet(2, 1);
}

function note(p, v) {
    p = Math.floor(p);
    if (p < 0 || p > 127) return;
    if (v > 0) {
        held[p] = 1;
    } else {
        delete held[p];
    }
    if (P.mode === 1) rebuildColumns();
}
note.immediate = 1;

function density(v) {
    P.density = clamp(Number(v), 0, 100);
    outlet(3, "density", Math.round(P.density), "%");
}

function fall(v) {
    P.fall = clamp(Number(v), 0, 100);
    outlet(3, "fall", Math.round(P.fall), "%");
}

function wind(v) {
    P.wind = clamp(Number(v), -100, 100);
    outlet(3, "wind", Math.round(P.wind));
}

function distance(v) {
    P.distance = clamp(Number(v), 0, 100);
    outlet(3, "distance", Math.round(P.distance), "%");
}

// Length es una casilla numérica (live.numbox), que ya muestra su propio valor
function dur(v) {
    P.dur = clamp(Number(v), 10, 2000);
}

function mode(v) {
    P.mode = Number(v) ? 1 : 0;
    rebuildColumns();
}

function tonic(v) {
    P.tonic = clamp(Math.floor(v), 0, 11);
    rebuildColumns();
}

function scale(v) {
    P.scale = clamp(Math.floor(v), 0, SCALES.length - 1);
    rebuildColumns();
}

function low(v) {
    P.low = clamp(Math.floor(v), 0, 127);
    rebuildColumns();
}

function high(v) {
    P.high = clamp(Math.floor(v), 0, 127);
    rebuildColumns();
}

function sync(v) {
    var i = clamp(Math.floor(v), 0, SYNC_VALUES.length - 1);
    P.sync = i;
    S.syncLabel = SYNC_LABELS[i];
    lastGrid = now();
    applyGrid();
    if (i === 0) flush();
}

function notifydeleted() {
    shared.state = null;
}

rebuildColumns();
