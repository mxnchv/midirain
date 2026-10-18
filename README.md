# midirain

Dispositivo Max for Live (MIDI Effect) para Ableton Live 12. Cae una lluvia de gotas sobre un suelo dividido en columnas invisibles, y cada columna es una nota MIDI. Cuando una gota toca el suelo, suena la nota de su columna, con una salpicadura y un destello.

Estética de [mxnchv.xyz](https://mxnchv.xyz): negro puro, blanco con transparencia y scanlines.

La lluvia ocupa la izquierda (300 px) y los controles la derecha: knobs en 2×2 y menús en columna. Los knobs son los nativos de Live (`live.dial`) con colores en blanco y gris; el nombre y el valor van como textos aparte, encima y debajo del aro, para dejarles aire (el valor lo formatea el motor como Live: "30 %", "150 ms", "2.00 s"). Los textos usan la fuente de Live.

## Instalación

1. Copia en **la misma carpeta** `midirain.amxd`, `midirain_engine.js` y `midirain_ui.js` (por ejemplo `User Library/Presets/MIDI Effects/Max MIDI Effect/midirain/`).
2. Arrastra `midirain.amxd` a una pista MIDI, delante de un instrumento.
3. Para usarlo en otro ordenador o compartirlo, abre el dispositivo en Max, pulsa **Freeze** y guárdalo. Así los `.js` quedan dentro del `.amxd`.

### Si Live no abre el .amxd

El `.amxd` se genera escribiendo a mano su contenedor binario, y ese formato no está documentado. Si Live no lo carga:

1. En Live, crea un **Max MIDI Effect** vacío y pulsa el botón de editar.
2. En Max, selecciona todo (Cmd/Ctrl+A) y bórralo.
3. Abre `midirain_clipboard.json`, copia todo el texto y pégalo en el patcher (Cmd/Ctrl+V).
4. En el inspector del patcher (Patcher Inspector), activa **Open in Presentation** y pon **Device Width** a 590.
5. Guárdalo como `midirain.amxd` en la misma carpeta que los `.js`.

## Controles

| control | rango | qué hace |
|---|---|---|
| Density | 0–100 % | gotas por segundo, en curva cuadrática (~60/s al 100 %) |
| Fall | 0–100 % | velocidad de caída |
| Wind | -100–100 | inclina la lluvia (10 por defecto); lo que sale por un lado entra por el otro |
| Length | 10–2000 ms | duración de cada nota (exponencial) |
| Mode | Scale / MIDI | **Scale**: las columnas son las notas de la escala dentro del rango. **MIDI**: las columnas son las notas que mantienes pulsadas, de grave a agudo. Sin notas pulsadas, llueve pero no suena |
| Root, Scale | | Major, Minor, Dorian, Phrygian, Lydian, Mixolydian, Harmonic Minor, Major/Minor Pentatonic, Blues, Chromatic |
| Low / High | nota MIDI | rango de las columnas en modo Scale (C3 = 60) |
| Sync | Free, 1/32 … 1/4 | encola los impactos y los dispara en el siguiente pulso del transporte |

Las gotas grandes son más gruesas y rápidas, y suenan más fuerte (velocity 30–127).

Con **Sync** activo, cuantiza tanto con Live en play como en stop. El motor lee de Live el estado del transporte y el tempo (`live.observer`): en play, la rejilla es la del transporte, alineada al compás; parado, es una rejilla propia al tempo del proyecto (sin compás al que alinearse). Como red de seguridad, si pasan más de 400 ms sin pulsos (o 1,5 veces el intervalo de la rejilla, si es mayor), las notas encoladas suenan igualmente.

## Arquitectura

- `midirain_engine.js` corre en `[js midirain_engine.js ---mr]`, movido por un `[metro 10]` que arranca `[live.thisdevice]`. Contiene la simulación, las columnas y la salida de notas. `bang`/`tick`, `grid` y `note` llevan `.immediate = 1`.
- `midirain_ui.js` corre en `[jsui]` y solo dibuja. Calcula la posición de cada gota en el instante de pintar, a partir del último paso del motor, para que el movimiento sea continuo. Lee el estado de un `Global` cuyo nombre es único por instancia (`---` se sustituye por un ID) y repinta al recibir `draw <nombreGlobal>`, unos 60 fps. Las notas no dependen nunca del repintado.
- Valores de los knobs: motor (outlet 3, p. ej. `density 30 %`) → `[route density fall wind dur]` → `[prepend set]` → el texto bajo cada aro.
- Salida: motor → `[unpack 0 0 0]` → `[makenote]` → `[pack 0 0]` → `[midiformat]` → `[midiout]`. Al desactivar el dispositivo, `makenote` recibe `stop` y apaga todo lo que suena.
- Entrada: `[midiin]` → `[midiparse]` → `[prepend note]` → motor. Las notas de entrada no pasan a la salida.
- Sync: el motor configura un `[metro 16n @quantize 16n]` (`interval`, `quantize`, `1`/`0`) que le devuelve `grid` en cada pulso: en valores de nota con el transporte en marcha, en ms (y sin `quantize`) con el transporte parado.
- Transporte: `[live.path]` → `[live.observer @property is_playing]` y `[live.observer @property tempo]` → motor (`playing`, `tempo`).

## Desarrollo

```sh
python3 tools/build_device.py     # regenera midirain.maxpat, midirain.amxd y midirain_clipboard.json
node tests/test_engine.js         # pruebas del motor con stubs de la API de Max
python3 -m http.server            # y abre http://localhost:8000/tools/preview.html
```

`tools/preview.html` ejecuta los dos `.js` tal cual en el navegador, con un canvas que imita mgraphics. Sirve para ver la lluvia sin abrir Live. No tiene audio.
