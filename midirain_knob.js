// midirain_knob.js
// Knob de midirain en [jsui]: aro gris abierto por abajo, el recorrido en blanco
// y debajo el nombre y el valor. Solo dibuja: va encima de un live.dial transparente
// (con ignoreclick) y lo tapa con su fondo negro; el dial es el que recibe el ratón, la automatización y el
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
var GAP = 0.12;             // hueco entre el aro gris y el recorrido blanco
var CY = 22;
var R = 17;
var STROKE = 2.5;

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
    var cx = W / 2;
    var a = A0 + position() * (A1 - A0);
    var from = (lo < 0) ? 1.5 * Math.PI : A0;   // bipolar: desde arriba
    var v0 = Math.min(a, from);
    var v1 = Math.max(a, from, v0 + 0.01);     // en bipolar centrado, un punto arriba

    // fondo negro opaco: tapa por completo el live.dial que hay debajo
    mgraphics.set_source_rgba(0, 0, 0, 1);
    mgraphics.rectangle(0, 0, W, sz[1]);
    mgraphics.fill();

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
    centered(label, cx, 54);

    mgraphics.set_font_size(9);
    mgraphics.set_source_rgba(1, 1, 1, 1);
    centered(format(), cx, 66);
}
