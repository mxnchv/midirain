// midirain_ui.js
// Visualización de midirain en [jsui] con mgraphics. Solo dibuja: lee el estado
// que el motor publica en un Global y repinta cuando recibe "draw <nombreGlobal>".
// Ninguna nota depende de este archivo. ES5.
//
// Estética de mxnchv.xyz: negro puro, blanco con transparencia, Space Mono,
// líneas de 1 px, minúsculas y scanlines.

mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;

inlets = 1;
outlets = 1;

var FLOOR_H = 18;
var FONT = "Space Mono";
var FLASH_LIFE = 400;
var SPLASH_LIFE = 450;

var gname = null;
var G = null;

function draw(name) {
    name = String(name);
    if (name !== gname) {
        gname = name;
        G = new Global(name);
    }
    mgraphics.redraw();
}

function bang() {
    mgraphics.redraw();
}

function rnd(seed, i) {
    var v = Math.sin(seed * 12.9898 + i * 78.233) * 43758.5453;
    return v - Math.floor(v);
}

function size() {
    var sz = mgraphics.size;
    if (sz && sz.length >= 2) return [sz[0], sz[1]];
    return [box.rect[2] - box.rect[0], box.rect[3] - box.rect[1]];
}

// texto con espaciado entre letras, como el logo de la web (letter-spacing 0.2em)
function spaced(str, x, y, track) {
    var i, ch, w;
    for (i = 0; i < str.length; i++) {
        ch = str.charAt(i);
        mgraphics.move_to(x, y);
        mgraphics.show_text(ch);
        w = mgraphics.text_measure(ch)[0];
        x += w + track;
    }
}

function paint() {
    var sz = size();
    var W = sz[0];
    var H = sz[1];
    var RH = H - FLOOR_H;
    var t = Date.now();
    var S = G ? G.state : null;

    // fondo
    mgraphics.set_source_rgba(0, 0, 0, 1);
    mgraphics.rectangle(0, 0, W, H);
    mgraphics.fill();

    if (S) {
        drawFlashGlow(S, W, RH, t);
        drawDrops(S, W, RH);
        drawSplashes(S, W, RH, t);
        drawFloor(S, W, H, RH, t);
        drawHeader(S, W);
    } else {
        drawFloor({ cols: [], labels: [], flashT: [], flashV: [], mode: 0 }, W, H, RH, t);
    }

    // scanlines
    mgraphics.set_source_rgba(0, 0, 0, 0.14);
    for (var y = 3; y < H; y += 4) mgraphics.rectangle(0, y, W, 1);
    mgraphics.fill();
}

function drawDrops(S, W, RH) {
    var drops = S.drops;
    var tilt = S.windN * 0.6;
    var buckets = [[], [], [], []];
    var i, d, b;
    if (!drops) return;
    for (i = 0; i < drops.length; i++) {
        d = drops[i];
        if (!d) continue;
        b = Math.min(3, Math.floor(d.s * 4));
        buckets[b].push(d);
    }
    // dirección del trazo en píxeles: (tilt * W, RH) normalizado
    var dx = tilt * W;
    var dy = RH;
    var len = Math.sqrt(dx * dx + dy * dy) || 1;
    dx /= len;
    dy /= len;

    mgraphics.set_line_cap("round");
    for (b = 0; b < 4; b++) {
        if (!buckets[b].length) continue;
        var s = (b + 0.5) / 4;
        var L = 4 + 10 * s + 8 * S.fallN;
        mgraphics.set_line_width(0.6 + 1.4 * s);
        mgraphics.set_source_rgba(1, 1, 1, 0.22 + 0.6 * s);
        for (i = 0; i < buckets[b].length; i++) {
            d = buckets[b][i];
            var x = d.x * W;
            var y = d.y * RH;
            mgraphics.move_to(x - dx * L, y - dy * L);
            mgraphics.line_to(x, y);
        }
        mgraphics.stroke();
    }
}

function drawSplashes(S, W, RH, t) {
    var sp = S.splashes;
    var i, j, p, age, k, x, r, n, a, v, ts, px, py;
    if (!sp) return;
    for (i = 0; i < sp.length; i++) {
        p = sp[i];
        if (!p) continue;
        age = t - p.t;
        if (age < 0 || age >= SPLASH_LIFE) continue;
        k = age / SPLASH_LIFE;
        x = p.x * W;

        // arco: media elipse que se abre hacia arriba
        r = 3 + (8 + 14 * p.s) * Math.sqrt(k);
        mgraphics.save();
        mgraphics.translate(x, RH);
        mgraphics.scale(1, 0.4);
        mgraphics.move_to(-r, 0);
        mgraphics.arc(0, 0, r, Math.PI, 2 * Math.PI);
        mgraphics.restore();
        mgraphics.set_line_width(1);
        mgraphics.set_source_rgba(1, 1, 1, 0.55 * (1 - k));
        mgraphics.stroke();

        // gotitas en parábola
        n = 2 + Math.round(p.s * 4);
        ts = age / 1000;
        mgraphics.set_source_rgba(1, 1, 1, 0.8 * (1 - k));
        for (j = 0; j < n; j++) {
            a = Math.PI * (0.18 + 0.64 * (j + 0.5) / n) + (rnd(p.seed, j) - 0.5) * 0.35;
            v = (28 + 50 * p.s) * (0.7 + 0.6 * rnd(p.seed, j + 9));
            px = x + Math.cos(a) * v * ts + S.windN * 14 * ts;
            py = RH - Math.sin(a) * v * ts + 0.5 * 420 * ts * ts;
            if (py > RH) continue;
            mgraphics.ellipse(px - 0.9, py - 0.9, 1.8, 1.8);
            mgraphics.fill();
        }
    }
}

function flashAmount(S, c, t) {
    var age = t - (S.flashT[c] || 0);
    if (age < 0 || age >= FLASH_LIFE) return 0;
    return (1 - age / FLASH_LIFE) * (0.55 + 0.45 * (S.flashV[c] || 0) / 127);
}

function drawFlashGlow(S, W, RH, t) {
    var n = S.cols ? S.cols.length : 0;
    var cw, c, a, pat;
    if (!n) return;
    cw = W / n;
    for (c = 0; c < n; c++) {
        a = flashAmount(S, c, t);
        if (a <= 0) continue;
        pat = mgraphics.pattern_create_linear(0, RH, 0, RH - 44);
        pat.add_color_stop_rgba(0, 1, 1, 1, 0.2 * a);
        pat.add_color_stop_rgba(1, 1, 1, 1, 0);
        mgraphics.set_source(pat);
        mgraphics.rectangle(c * cw, RH - 44, cw, 44);
        mgraphics.fill();
    }
}

function drawFloor(S, W, H, RH, t) {
    var n = S.cols ? S.cols.length : 0;
    var cw, c, a, label, tw, x;

    mgraphics.set_source_rgba(1, 1, 1, 0.04);
    mgraphics.rectangle(0, RH, W, FLOOR_H);
    mgraphics.fill();

    mgraphics.select_font_face(FONT);
    mgraphics.set_font_size(8);

    if (!n) {
        var msg = (S.mode === 1) ? "toca notas" : "sin notas en el rango";
        var pulse = 0.45 + 0.2 * Math.sin(t / 420);
        tw = mgraphics.text_measure(msg)[0];
        mgraphics.set_source_rgba(1, 1, 1, pulse);
        mgraphics.move_to((W - tw) / 2, H - 6);
        mgraphics.show_text(msg);
    } else {
        cw = W / n;
        for (c = 0; c < n; c++) {
            a = flashAmount(S, c, t);
            if (a > 0) {
                mgraphics.set_source_rgba(1, 1, 1, 0.9 * a);
                mgraphics.rectangle(c * cw, RH, cw, FLOOR_H);
                mgraphics.fill();
            }
        }
        // separadores
        if (cw >= 3) {
            mgraphics.set_line_width(1);
            mgraphics.set_source_rgba(1, 1, 1, 0.16);
            for (c = 1; c < n; c++) {
                x = Math.round(c * cw) + 0.5;
                mgraphics.move_to(x, RH);
                mgraphics.line_to(x, H);
            }
            mgraphics.stroke();
        }
        // nombres de nota, si caben
        for (c = 0; c < n; c++) {
            label = S.labels[c];
            if (!label) continue;
            tw = mgraphics.text_measure(label)[0];
            if (tw + 3 > cw) continue;
            a = flashAmount(S, c, t);
            if (a > 0.45) {
                mgraphics.set_source_rgba(0, 0, 0, 0.9);
            } else {
                mgraphics.set_source_rgba(1, 1, 1, (S.cols[c] % 12 === 0) ? 0.8 : 0.45);
            }
            mgraphics.move_to(c * cw + (cw - tw) / 2, H - 6);
            mgraphics.show_text(label);
        }
    }

    // línea del suelo
    mgraphics.set_line_width(1);
    mgraphics.set_source_rgba(1, 1, 1, 0.35);
    mgraphics.move_to(0, RH + 0.5);
    mgraphics.line_to(W, RH + 0.5);
    mgraphics.stroke();
}

function drawHeader(S, W) {
    mgraphics.select_font_face(FONT);
    mgraphics.set_font_size(8);
    mgraphics.set_source_rgba(1, 1, 1, 0.85);
    spaced("midirain", 8, 13, 1.6);

    var info = S.syncLabel || "";
    var tw = mgraphics.text_measure(info)[0];
    mgraphics.set_source_rgba(1, 1, 1, 0.35);
    mgraphics.move_to(W - tw - 8, 13);
    mgraphics.show_text(info);
}
