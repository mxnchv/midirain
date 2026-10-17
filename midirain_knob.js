// midirain_knob.js
// Knob de midirain en [jsui], al estilo de mxnchv.xyz: aro de 1 px y un punto
// blanco que lo recorre. Solo dibuja: va encima de un live.dial transparente
// (con ignoreclick), que es el que recibe el ratón, la automatización y el
// MIDI map, y le manda su valor por la entrada. ES5.
//
// jsarguments: etiqueta mínimo máximo exponente inicial [unidad]

mgraphics.init();
mgraphics.relative_coords = 0;
mgraphics.autofill = 0;

inlets = 1;
outlets = 0;

var FONT = "Space Mono";
var A0 = 0.75 * Math.PI;    // abajo a la izquierda
var A1 = 2.25 * Math.PI;    // abajo a la derecha

var label = arg(1, "");
var lo = Number(arg(2, 0));
var hi = Number(arg(3, 100));
var expo = Number(arg(4, 1)) || 1;
var value = Number(arg(5, lo));
var unit = arg(6, "");

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

function centered(str, cx, y) {
    var w = mgraphics.text_measure(str)[0];
    mgraphics.move_to(cx - w / 2, y);
    mgraphics.show_text(str);
}

function paint() {
    var sz = size();
    var W = sz[0];
    var H = sz[1];
    var cx = W / 2;
    var cy = 25;
    var r = 11;
    var p = position();
    var a = A0 + p * (A1 - A0);
    var from = (lo < 0) ? 1.5 * Math.PI : A0;   // bipolar: desde arriba

    mgraphics.set_source_rgba(0, 0, 0, 1);
    mgraphics.rectangle(0, 0, W, H);
    mgraphics.fill();

    mgraphics.select_font_face(FONT);
    mgraphics.set_font_size(9);
    mgraphics.set_source_rgba(1, 1, 1, 0.5);
    centered(label, cx, 9);

    // aro
    mgraphics.set_line_width(1);
    mgraphics.set_source_rgba(1, 1, 1, 0.16);
    arcFrom(cx, cy, r, A0, A1);
    mgraphics.stroke();

    // recorrido hasta el valor
    if (Math.abs(a - from) > 0.001) {
        mgraphics.set_source_rgba(1, 1, 1, 0.7);
        if (a > from) {
            arcFrom(cx, cy, r, from, a);
        } else {
            arcFrom(cx, cy, r, a, from);
        }
        mgraphics.stroke();
    }

    // punto
    mgraphics.set_source_rgba(1, 1, 1, 1);
    mgraphics.ellipse(cx + Math.cos(a) * r - 2.5, cy + Math.sin(a) * r - 2.5, 5, 5);
    mgraphics.fill();

    mgraphics.set_font_size(8);
    mgraphics.set_source_rgba(1, 1, 1, 0.8);
    centered(format(), cx, 48);
}
