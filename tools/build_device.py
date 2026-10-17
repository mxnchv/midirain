#!/usr/bin/env python3
"""Genera midirain.maxpat, midirain.amxd y midirain_clipboard.json.

    python3 tools/build_device.py

El patcher se construye como datos (cajas + cables) y se valida antes de escribir:
ids únicos, cables entre outlets/inlets que existen y nombres de parámetro únicos.
"""

import json
import os
import struct
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

DEVICE_W = 400
DEVICE_H = 169

FONT = "Space Mono"

# paleta de mxnchv.xyz: negro y blanco con alfa
BLACK = [0.0, 0.0, 0.0, 1.0]
WHITE = [1.0, 1.0, 1.0, 1.0]


def white(a):
    return [1.0, 1.0, 1.0, a]


AMXD_MIDI = 0x6D6D6D6D                   # 'mmmm'

boxes = []
lines = []
_ids = {}


def box(key, maxclass, rect, inlets, outlets, outlettype=None, text=None, pres=None, **attrs):
    oid = "obj-%d" % (len(boxes) + 1)
    b = {
        "id": oid,
        "maxclass": maxclass,
        "numinlets": inlets,
        "numoutlets": outlets,
        "patching_rect": [float(v) for v in rect],
    }
    if outlets:
        b["outlettype"] = outlettype if outlettype is not None else [""] * outlets
    if text is not None:
        b["text"] = text
    if pres is not None:
        b["presentation"] = 1
        b["presentation_rect"] = [float(v) for v in pres]
    b.update(attrs)
    boxes.append({"box": b})
    _ids[key] = b
    return key


def obj(key, text, rect, inlets, outlets, outlettype=None, **attrs):
    return box(key, "newobj", rect, inlets, outlets, outlettype, text=text, **attrs)


def msg(key, text, rect):
    return box(key, "message", rect, 2, 1, [""], text=text)


def comment(key, text, rect, pres=None, size=9.0, alpha=0.5, **attrs):
    a = {"fontname": FONT, "fontsize": size}
    if pres is not None:
        a["textcolor"] = white(alpha)
    a.update(attrs)
    return box(key, "comment", rect, 1, 0, text=text, pres=pres, **a)


def wire(src, dst, outlet=0, inlet=0):
    lines.append({"patchline": {
        "source": [_ids[src]["id"], outlet],
        "destination": [_ids[dst]["id"], inlet],
    }})


def param(longname, shortname, ptype, **v):
    """saved_attribute_attributes de un objeto live.*
    ptype: 0 float, 1 int, 2 enum.  unitstyle: 0 int, 1 float, 2 ms, 5 %, 8 MIDI."""
    valueof = {
        "parameter_longname": longname,
        "parameter_shortname": shortname,
        "parameter_type": ptype,
    }
    for k, val in v.items():
        valueof["parameter_" + k] = val
    if "initial" in v:
        valueof["parameter_initial_enable"] = 1
    return {"valueof": valueof}


# el live.dial es invisible: lo dibuja midirain_knob.js encima
CLEAR = [0.0, 0.0, 0.0, 0.0]
DIAL_COLORS = {k: CLEAR for k in (
    "activedialcolor", "dialcolor", "activeneedlecolor", "needlecolor",
    "textcolor", "panelcolor", "tricolor", "focusbordercolor")}
TAB_COLORS = {
    "bgcolor": BLACK,
    "activebgcolor": BLACK,
    "bgoncolor": white(0.85),
    "activebgoncolor": WHITE,
    "textcolor": white(0.6),
    "textoncolor": BLACK,
    "bordercolor": white(0.35),
    "focusbordercolor": white(0.6),
}
MENU_COLORS = {
    "bgcolor": BLACK,
    "activebgcolor": BLACK,
    "textcolor": white(0.85),
    "tricolor": white(0.5),
    "bordercolor": white(0.35),
    "focusbordercolor": white(0.6),
}
NUMBOX_COLORS = {
    "activebgcolor": BLACK,
    "textcolor": white(0.85),
    "activeslidercolor": white(0.5),
    "tricolor": white(0.5),
    "bordercolor": white(0.35),
    "focusbordercolor": white(0.6),
}


KNOB_W, KNOB_H = 60, 72
_knobs = []
PANEL = []                 # nombres de script de todo lo que va en el panel de controles


def panel(key):
    """Marca una caja como parte del panel: oculta al cargar, con nombre de script."""
    b = _ids[key]
    b["varname"] = b.get("varname", key)
    b["hidden"] = 1
    PANEL.append(b["varname"])
    return key


def dial(key, varname, longname, label, x, y, mmin, mmax, initial, unitstyle, exponent=None, unit=None):
    """live.dial transparente (ratón, automatización, MIDI map) con un jsui encima
    que lo dibuja (midirain_knob.js, ignoreclick)."""
    v = dict(mmin=float(mmin), mmax=float(mmax), initial=[float(initial)], unitstyle=unitstyle)
    if exponent:
        v["exponent"] = float(exponent)
    pres = [x, y, KNOB_W, KNOB_H]
    i = len(_knobs)
    box(key, "live.dial", [20 + i * 64, 30, KNOB_W, KNOB_H], 1, 2, ["", "float"], pres=pres,
        parameter_enable=1, varname=varname, showname=0, shownumber=0,
        saved_attribute_attributes=param(longname, longname, 0, **v), **DIAL_COLORS)
    args = [label, mmin, mmax, exponent or 1, initial] + ([unit] if unit else [])
    kkey = "knob_" + key
    box(kkey, "jsui", [820 + i * 64, 30, KNOB_W, KNOB_H], 1, 0, pres=pres,
        filename="midirain_knob.js", jsarguments=args, ignoreclick=1, parameter_enable=0)
    panel(key)
    panel(kkey)
    _knobs.append(key)
    wire(key, kkey)
    return key


def menu(key, varname, longname, items, initial, rect, pres):
    v = dict(enum=items, mmax=float(len(items) - 1), initial=[float(initial)])
    return box(key, "live.menu", rect, 1, 3, ["", "", "float"], pres=pres,
               parameter_enable=1, varname=varname,
               saved_attribute_attributes=param(longname, longname, 2, **v), **MENU_COLORS)


def tab(key, varname, longname, items, initial, rect, pres):
    v = dict(enum=items, mmax=float(len(items) - 1), initial=[float(initial)])
    return box(key, "live.tab", rect, 1, 3, ["", "", "float"], pres=pres,
               parameter_enable=1, varname=varname, num_lines_patching=1, num_lines_presentation=1,
               saved_attribute_attributes=param(longname, longname, 2, **v), **TAB_COLORS)


def numbox(key, varname, longname, initial, rect, pres):
    v = dict(mmin=0.0, mmax=127.0, initial=[float(initial)], unitstyle=8)
    return box(key, "live.numbox", rect, 1, 2, ["", "float"], pres=pres,
               parameter_enable=1, varname=varname,
               saved_attribute_attributes=param(longname, longname, 1, **v), **NUMBOX_COLORS)


# ---------------------------------------------------------------------------
# presentación: fondo y lluvia a todo el ancho

box("bg", "panel", [700, 10, 60, 30], 1, 0, pres=[0, 0, DEVICE_W, DEVICE_H],
    background=1, bgcolor=BLACK, border=0, rounded=0, ignoreclick=1)

box("ui", "jsui", [460, 480, 400, 169], 1, 1, [""], pres=[0, 0, DEVICE_W, DEVICE_H],
    filename="midirain_ui.js", parameter_enable=0)

# ---------------------------------------------------------------------------
# panel de controles: encima de la lluvia, oculto hasta pulsar "controls +"

CONTROLS = []              # (clave del control, selector del motor)


def label(key, text, x, y):
    comment(key, text, [0, 0, 60, 18], pres=[x - 4, y - 11, 60, 14], size=8.0)
    _ids[key]["patching_rect"] = [700.0 + 70 * (len(PANEL) % 4), 120.0 + 24 * (len(PANEL) // 4), 60.0, 18.0]
    panel(key)


dial("density", "density", "Density", "Density", 14, 26, 0, 100, 30, 5, unit="%")
CONTROLS.append(("density", "density"))

dial("fall", "fall", "Fall", "Fall", 84, 26, 0, 100, 40, 5, unit="%")
CONTROLS.append(("fall", "fall"))

dial("wind", "wind", "Wind", "Wind", 154, 26, -100, 100, 10, 0)
CONTROLS.append(("wind", "wind"))

dial("dur", "dur", "Length", "Length", 224, 26, 10, 2000, 150, 2, exponent=3, unit="ms")
CONTROLS.append(("dur", "dur"))

label("l_mode", "Mode", 300, 40)
tab("mode", "mode", "Mode", ["Scale", "MIDI"], 0, [260, 30, 76, 14], [300, 44, 76, 14])
panel("mode")
CONTROLS.append(("mode", "mode"))

label("l_sync", "Sync", 300, 72)
menu("sync", "sync", "Sync", ["Free", "1/32", "1/16", "1/8", "1/4"], 0,
     [340, 30, 76, 15], [300, 76, 76, 15])
panel("sync")
CONTROLS.append(("sync", "sync"))

label("l_tonic", "Root", 14, 124)
menu("tonic", "tonic", "Root",
     ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"], 0,
     [420, 30, 54, 15], [14, 128, 54, 15])
panel("tonic")
CONTROLS.append(("tonic", "tonic"))

label("l_scale", "Scale", 76, 124)
menu("scale", "scale", "Scale",
     ["Major", "Minor", "Dorian", "Phrygian", "Lydian", "Mixolydian", "Harmonic Minor",
      "Major Pentatonic", "Minor Pentatonic", "Blues", "Chromatic"], 1,
     [480, 30, 130, 15], [76, 128, 130, 15])
panel("scale")
CONTROLS.append(("scale", "scale"))

label("l_low", "Low", 214, 124)
numbox("low", "low", "Low", 48, [620, 30, 54, 15], [214, 128, 54, 15])
panel("low")
CONTROLS.append(("low", "low"))

label("l_high", "High", 276, 124)
numbox("high", "high", "High", 72, [680, 30, 54, 15], [276, 128, 54, 15])
panel("high")
CONTROLS.append(("high", "high"))

# ---------------------------------------------------------------------------
# lógica

comment("c_params", "parámetros -> motor", [20, 100, 160, 18])
for i, (ctl, selector) in enumerate(CONTROLS):
    key = "p_" + ctl
    obj(key, "prepend " + selector, [20 + (i % 5) * 92, 130 + (i // 5) * 26, 88, 22], 1, 1)
    wire(ctl, key)

comment("c_init", "al cargar: refresca parámetros y arranca el tick", [20, 200, 300, 18])
obj("thisdevice", "live.thisdevice", [20, 220, 100, 22], 1, 3, ["bang", "int", "int"])
obj("init", "t 1 b", [20, 250, 50, 22], 1, 2, ["int", "bang"])
wire("thisdevice", "init")
for ctl, _ in CONTROLS:
    wire("init", ctl, outlet=1)

obj("tick", "metro 10", [20, 290, 60, 22], 2, 1, ["bang"])
wire("init", "tick", outlet=0)

# panel de controles: la lluvia (jsui) manda "panel 1|0" al pulsar "controls +" / "close ×".
# Al cargar, siempre cerrado.
comment("c_panel", "panel de controles: mostrar / ocultar", [460, 400, 240, 18])
obj("route_panel", "route panel", [460, 650, 80, 22], 2, 2)
obj("sel_panel", "sel 1", [460, 680, 50, 22], 2, 2, ["bang", ""])
# al mostrar, cada control se trae además al frente (en el orden de PANEL: el knob
# queda por encima de su live.dial), para que la lluvia nunca los tape
msg("show", ", ".join("script show %s, script bringtofront %s" % (n, n) for n in PANEL), [460, 710, 300, 22])
msg("hide", ", ".join("script hide " + n for n in PANEL), [460, 740, 300, 22])
obj("thispatcher", "thispatcher", [460, 780, 80, 22], 1, 2, ["", ""])
wire("ui", "route_panel")
wire("route_panel", "sel_panel")
wire("sel_panel", "show", outlet=0)
wire("sel_panel", "hide", outlet=1)
wire("show", "thispatcher")
wire("hide", "thispatcher")
wire("init", "hide", outlet=1)

comment("c_sync", "rejilla del transporte (el motor la configura)", [200, 260, 280, 18])
obj("gridmetro", "metro 16n @quantize 16n", [200, 290, 150, 22], 2, 1, ["bang"])

# estado del transporte y tempo de Live: el motor sabe cuándo no van a llegar pulsos
# y cuánto esperar a cada uno, sin adivinarlo por tiempos
comment("c_transport", "transporte de Live", [380, 260, 120, 18])
msg("lompath", "path live_set", [380, 290, 80, 22])
obj("lompathobj", "live.path", [380, 320, 70, 22], 1, 3, ["", "", ""])
obj("obs_playing", "live.observer @property is_playing", [380, 350, 190, 22], 2, 2, ["", ""])
obj("obs_tempo", "live.observer @property tempo", [580, 350, 170, 22], 2, 2, ["", ""])
obj("p_playing", "prepend playing", [380, 380, 100, 22], 1, 1)
obj("p_tempo", "prepend tempo", [580, 380, 90, 22], 1, 1)
wire("thisdevice", "lompath")
wire("lompath", "lompathobj")
wire("lompathobj", "obs_playing", 0, 1)
wire("lompathobj", "obs_tempo", 0, 1)
wire("obs_playing", "p_playing")
wire("obs_tempo", "p_tempo")
msg("gridmsg", "grid", [200, 320, 40, 22])
wire("gridmetro", "gridmsg")

comment("c_in", "entrada MIDI: solo notas, no pasan a la salida", [500, 200, 280, 18])
obj("midiin", "midiin", [500, 220, 50, 22], 1, 1, ["int"])
obj("midiparse", "midiparse", [500, 250, 100, 22], 1, 8, ["", "", "", "int", "int", "", "int", ""])
obj("p_note", "prepend note", [500, 280, 80, 22], 1, 1)
wire("midiin", "midiparse")
wire("midiparse", "p_note", outlet=0)

obj("engine", "js midirain_engine.js ---mr", [20, 420, 420, 22], 1, 3)
wire("tick", "engine")
wire("gridmsg", "engine")
wire("p_note", "engine")
wire("p_playing", "engine")
wire("p_tempo", "engine")
for ctl, _ in CONTROLS:
    wire("p_" + ctl, "engine")
wire("engine", "ui", outlet=1)
wire("engine", "gridmetro", outlet=2)

comment("c_out", "salida: makenote siempre manda el note-off", [20, 470, 280, 18])
obj("unpack", "unpack 0 0 0", [20, 490, 120, 22], 1, 3, ["int", "int", "int"])
obj("makenote", "makenote 100 150", [20, 530, 120, 22], 3, 2, ["float", "float"])
obj("pack", "pack 0 0", [20, 570, 80, 22], 2, 1)
obj("midiformat", "midiformat", [20, 610, 100, 22], 7, 1, ["int"])
obj("midiout", "midiout", [20, 650, 60, 22], 1, 0)
wire("engine", "unpack", outlet=0)
wire("unpack", "makenote", 0, 0)
wire("unpack", "makenote", 1, 1)
wire("unpack", "makenote", 2, 2)
wire("makenote", "pack", 0, 0)
wire("makenote", "pack", 1, 1)
wire("pack", "midiformat")
wire("midiformat", "midiout")

# dispositivo desactivado: note-off inmediato de todo lo que suena
obj("off", "sel 0", [200, 490, 50, 22], 2, 2, ["bang", ""])
msg("stop", "stop", [200, 520, 40, 22])
wire("thisdevice", "off", outlet=1)
wire("off", "stop")
wire("stop", "makenote")

# ---------------------------------------------------------------------------


def validate():
    seen = set()
    for b in boxes:
        oid = b["box"]["id"]
        assert oid not in seen, oid
        seen.add(oid)
    by_id = {b["box"]["id"]: b["box"] for b in boxes}
    for ln in lines:
        (s, o), (d, i) = ln["patchline"]["source"], ln["patchline"]["destination"]
        assert s in by_id and d in by_id, ln
        assert 0 <= o < by_id[s]["numoutlets"], ("outlet", by_id[s].get("text", by_id[s]["maxclass"]), o)
        assert 0 <= i < by_id[d]["numinlets"], ("inlet", by_id[d].get("text", by_id[d]["maxclass"]), i)
    names = [b["box"]["saved_attribute_attributes"]["valueof"]["parameter_longname"]
             for b in boxes if b["box"].get("parameter_enable")]
    assert len(names) == len(set(names)), names
    for b in boxes:
        pr = b["box"].get("presentation_rect")
        if pr:
            assert pr[0] + pr[2] <= DEVICE_W and pr[1] + pr[3] <= DEVICE_H, (b["box"]["id"], pr)


APPVERSION = {"major": 8, "minor": 6, "revision": 5, "architecture": "x64", "modernui": 1}


def patcher():
    return {"patcher": {
        "fileversion": 1,
        "appversion": APPVERSION,
        "classnamespace": "box",
        "rect": [80.0, 100.0, 840.0, 660.0],
        "bglocked": 0,
        "openinpresentation": 1,
        "default_fontsize": 10.0,
        "default_fontface": 0,
        "default_fontname": "Arial Bold",
        "gridonopen": 1,
        "gridsize": [8.0, 8.0],
        "gridsnaponopen": 1,
        "objectsnaponopen": 1,
        "statusbarvisible": 2,
        "toolbarvisible": 1,
        "lefttoolbarpinned": 0,
        "toptoolbarpinned": 0,
        "righttoolbarpinned": 0,
        "bottomtoolbarpinned": 0,
        "toolbars_unpinned_last_save": 0,
        "tallnewobj": 0,
        "boxanimatetime": 500,
        "enablehscroll": 1,
        "enablevscroll": 1,
        "devicewidth": float(DEVICE_W),
        "description": "lluvia de gotas que dispara notas MIDI",
        "digest": "",
        "tags": "",
        "style": "",
        "subpatcher_template": "",
        "assistshowspatchername": 0,
        "amxdtype": AMXD_MIDI,
        "boxes": boxes,
        "lines": lines,
        "dependency_cache": [
            {"name": "midirain_engine.js", "bootpath": ".", "patcherrelativepath": ".", "type": "TEXT", "implicit": 1},
            {"name": "midirain_ui.js", "bootpath": ".", "patcherrelativepath": ".", "type": "TEXT", "implicit": 1},
        ],
        "latency": 0,
        "is_mpe": 0,
        "minimum_live_version": "",
        "minimum_max_version": "",
        "platform_compatibility": 0,
        "autosave": 0,
    }}


def amxd(json_bytes):
    """Contenedor .amxd: 'ampf' + tipo + bloque 'meta' + bloque 'ptch' con el JSON.
    Longitudes en little-endian. Formato no documentado oficialmente."""
    data = json_bytes + b"\n\x00"
    out = b"ampf" + struct.pack("<I", 4) + b"mmmm"
    out += b"meta" + struct.pack("<I", 4) + b"\x00\x00\x00\x00"
    out += b"ptch" + struct.pack("<I", len(data)) + data
    return out


def main():
    validate()
    p = patcher()
    text = json.dumps(p, indent="\t", ensure_ascii=False)
    with open(os.path.join(ROOT, "midirain.maxpat"), "w", encoding="utf-8") as f:
        f.write(text + "\n")
    with open(os.path.join(ROOT, "midirain.amxd"), "wb") as f:
        f.write(amxd(text.encode("utf-8")))
    clip = {"boxes": boxes, "lines": lines, "appversion": APPVERSION, "classnamespace": "box"}
    with open(os.path.join(ROOT, "midirain_clipboard.json"), "w", encoding="utf-8") as f:
        f.write(json.dumps(clip, indent="\t", ensure_ascii=False) + "\n")
    print("%d cajas, %d cables -> midirain.maxpat, midirain.amxd, midirain_clipboard.json"
          % (len(boxes), len(lines)))


if __name__ == "__main__":
    sys.exit(main())
