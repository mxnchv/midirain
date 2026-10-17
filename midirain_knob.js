// midirain_knob.js
// Knob de midirain en [jsui]: aro gris abierto por abajo, el recorrido en blanco
// y debajo el nombre y el valor. Solo dibuja: va encima de un live.dial transparente
// (con ignoreclick), que es el que recibe el ratón, la automatización y el
// MIDI map, y le manda su valor por la entrada. ES5.
//
// Donde una gota de la lluvia cruza el recorrido blanco o los textos, esa parte
// sale en negativo. Las gotas las publica midirain_ui.js en el Global (segs),
// en coordenadas de la lluvia; por eso el knob necesita saber dónde está.
//
// jsarguments: etiqueta mínimo máximo exponente inicial x y [unidad]
//   x y: posición del knob dentro de la lluvia (presentation_rect)

mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;

inlets = 1;
outlets = 0;

var FONT = "Space Mono";
var A0 = 0.75 * Math.PI;    // abajo a la izquierda
var A1 = 2.25 * Math.PI;    // abajo a la derecha
var GAP = 0.12;             // hueco entre el aro gris y el recorrido blanco
var CY = 22;
var R = 17;
var STROKE = 2.5;

var label = arg(1, "");
var lo = Number(arg(2, 0));
var hi = Number(arg(3, 100));
var expo = Number(arg(4, 1)) || 1;
var value = Number(arg(5, lo));
var ox = Number(arg(6, 0));
var oy = Number(arg(7, 0));
var unit = arg(8, "");

var gname = null;
var G = null;

function arg(i, dflt) {
    return (typeof jsarguments !== "undefined" && jsarguments.length > i) ? jsarguments[i] : dflt;
}

function msg_float(v) {
    value = v;
    mgraphics.redraw();
}

function msg_int(v) {
    msg_float(v);
}

// el motor lo manda a ~60 fps: repintamos para seguir a la lluvia
function draw(name) {
    name = String(name);
    if (name !== gname) {
        gname = name;
        G = new Global(name);
    }
    mgraphics.redraw();
}

function position() {
    var p = (value - lo) / (hi - lo);
    p = p < 0 ? 0 : (p > 1 ? 1 : p);
    return Math.pow(p, 1 / expo);   // inversa de parameter_exponent
}

function format() {
    var v = Math.round(value);
    if (unit === "ms" && value >= 1000) return (value / 1000).toFixed(2) + " s";
    if (unit) return v + " " + unit;
    return (v > 0 && lo < 0) ? "+" + v : String(v);
}

function size() {
    var sz = mgraphics.size;
    if (sz && sz.length >= 2) return [sz[0], sz[1]];
    return [box.rect[2] - box.rect[0], box.rect[3] - box.rect[1]];
}

// arc() une con una línea el punto actual (p. ej. el final de un texto) con el
// inicio del arco: empezamos siempre en el inicio
function arcFrom(cx, cy, r, from, to) {
    mgraphics.move_to(cx + Math.cos(from) * r, cy + Math.sin(from) * r);
    mgraphics.arc(cx, cy, r, from, to);
}

function centered(str, cx, y, asPath) {
    var w = mgraphics.text_measure(str)[0];
    mgraphics.move_to(cx - w / 2, y);
    if (asPath) {
        mgraphics.text_path(str);
    } else {
        mgraphics.show_text(str);
    }
}

// trozos de gota que caen dentro del knob, en sus coordenadas
function hitSegments(W, H) {
    var segs = G ? G.segs : null;
    var out = [];
    var i, g;
    if (!segs) return out;
    for (i = 0; i < segs.length; i++) {
        g = segs[i];
        if (Math.max(g.x1, g.x2) < ox || Math.min(g.x1, g.x2) > ox + W) continue;
        if (Math.max(g.y1, g.y2) < oy || Math.min(g.y1, g.y2) > oy + H) continue;
        out.push(g);
    }
    return out;
}

function paint() {
    var sz = size();
    var W = sz[0];
    var cx = W / 2;
    var a = A0 + position() * (A1 - A0);
    var from = (lo < 0) ? 1.5 * Math.PI : A0;   // bipolar: desde arriba
    var v0 = Math.min(a, from);
    var v1 = Math.max(a, from, v0 + 0.01);     // en bipolar centrado, un punto arriba
    var txt = format();
    var hit, i, g;

    mgraphics.set_line_cap("round");
    mgraphics.set_line_width(STROKE);

    // aro gris, solo donde no hay recorrido blanco
    mgraphics.set_source_rgba(1, 1, 1, 0.28);
    if (v0 - GAP > A0) {
        arcFrom(cx, CY, R, A0, v0 - GAP);
        mgraphics.stroke();
    }
    if (v1 + GAP < A1) {
        arcFrom(cx, CY, R, v1 + GAP, A1);
        mgraphics.stroke();
    }

    // recorrido hasta el valor
    mgraphics.set_source_rgba(1, 1, 1, 1);
    arcFrom(cx, CY, R, v0, v1);
    mgraphics.stroke();

    mgraphics.select_font_face(FONT);
    mgraphics.set_font_size(8);
    mgraphics.set_source_rgba(1, 1, 1, 0.5);
    centered(label, cx, 54, false);

    mgraphics.set_font_size(9);
    mgraphics.set_source_rgba(1, 1, 1, 1);
    centered(txt, cx, 66, false);

    // negativo: recortamos a la forma del recorrido y de los textos y pintamos
    // en negro los trozos de gota que los cruzan
    hit = hitSegments(W, sz[1]);
    if (!hit.length) return;
    try {
        mgraphics.save();
        mgraphics.move_to(cx + Math.cos(v0) * (R + STROKE / 2), CY + Math.sin(v0) * (R + STROKE / 2));
        mgraphics.arc(cx, CY, R + STROKE / 2, v0, v1);
        mgraphics.arc_negative(cx, CY, R - STROKE / 2, v1, v0);
        mgraphics.close_path();
        mgraphics.set_font_size(8);
        centered(label, cx, 54, true);
        mgraphics.set_font_size(9);
        centered(txt, cx, 66, true);
        mgraphics.clip();
        mgraphics.set_source_rgba(0, 0, 0, 1);
        for (i = 0; i < hit.length; i++) {
            g = hit[i];
            mgraphics.set_line_width(g.w);
            mgraphics.move_to(g.x1 - ox, g.y1 - oy);
            mgraphics.line_to(g.x2 - ox, g.y2 - oy);
            mgraphics.stroke();
        }
        mgraphics.restore();
    } catch (e) {
        mgraphics.restore();
    }
}
