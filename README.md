# midirain

Dispositivo Max for Live (MIDI Effect) para Ableton Live 12. Cae una lluvia de gotas sobre un suelo dividido en columnas, y cada columna es una nota MIDI. Cuando una gota toca el suelo, suena la nota de su columna, con una salpicadura y un destello.

Estética de [mxnchv.xyz](https://mxnchv.xyz): negro puro, blanco con transparencia, Space Mono, líneas de 1 px y scanlines.

## Instalación

1. Copia en **la misma carpeta** `midirain.amxd`, `midirain_engine.js` y `midirain_ui.js` (por ejemplo `User Library/Presets/MIDI Effects/Max MIDI Effect/midirain/`).
2. Arrastra `midirain.amxd` a una pista MIDI, delante de un instrumento.
3. Para usarlo en otro ordenador o compartirlo, abre el dispositivo en Max, pulsa **Freeze** y guárdalo. Así los `.js` quedan dentro del `.amxd`.
4. Opcional: instala la fuente [Space Mono](https://fonts.google.com/specimen/Space+Mono). Si no la tienes, Max usa una fuente por defecto.

### Si Live no abre el .amxd

El `.amxd` se genera escribiendo a mano su contenedor binario, y ese formato no está documentado. Si Live no lo carga:

1. En Live, crea un **Max MIDI Effect** vacío y pulsa el botón de editar.
2. En Max, selecciona todo (Cmd/Ctrl+A) y bórralo.
3. Abre `midirain_clipboard.json`, copia todo el texto y pégalo en el patcher (Cmd/Ctrl+V).
4. En el inspector del patcher (Patcher Inspector), activa **Open in Presentation** y pon **Device Width** a 600.
5. Guárdalo como `midirain.amxd` en la misma carpeta que los `.js`.

## Controles

| control | rango | qué hace |
|---|---|---|
| densidad | 0–100 % | gotas por segundo, en curva cuadrática (~60/s al 100 %) |
| caída | 0–100 % | velocidad de caída |
| viento | -100–100 | inclina la lluvia; lo que sale por un lado entra por el otro |
| duración | 10–2000 ms | duración de cada nota (exponencial) |
| modo | escala / midi | **escala**: las columnas son las notas de la escala dentro del rango. **midi**: las columnas son las notas que mantienes pulsadas, de grave a agudo. Sin notas pulsadas, llueve pero no suena |
| tónica, escala | | mayor, menor, dórica, frigia, lidia, mixolidia, menor armónica, pentatónicas, blues, cromática |
| grave / aguda | nota MIDI | rango de las columnas en modo escala (C3 = 60) |
| sync | libre, 1/32 … 1/4 | encola los impactos y los dispara en el siguiente pulso del transporte |

Las gotas grandes son más gruesas y rápidas, y suenan más fuerte (velocity 30–127).

Con **sync** activo y el transporte parado no llegan pulsos de la rejilla. Si pasa más de 400 ms sin pulsos (o 1,5 veces el intervalo de la rejilla, si es mayor), las notas encoladas suenan al momento.

## Arquitectura

- `midirain_engine.js` corre en `[js midirain_engine.js ---mr]`, movido por un `[metro 10]` que arranca `[live.thisdevice]`. Contiene la simulación, las columnas y la salida de notas. `bang`/`tick`, `grid` y `note` llevan `.immediate = 1`.
- `midirain_ui.js` corre en `[jsui]` y solo dibuja. Lee el estado de un `Global` cuyo nombre es único por instancia (`---` se sustituye por un ID) y repinta al recibir `draw <nombreGlobal>`, unos 30 fps. Las notas no dependen nunca del repintado.
- Salida: motor → `[unpack 0 0 0]` → `[makenote]` → `[pack 0 0]` → `[midiformat]` → `[midiout]`. Al desactivar el dispositivo, `makenote` recibe `stop` y apaga todo lo que suena.
- Entrada: `[midiin]` → `[midiparse]` → `[prepend note]` → motor. Las notas de entrada no pasan a la salida.
- Sync: el motor configura un `[metro 16n @quantize 16n]` tempo-relativo (`interval`, `quantize`, `1`/`0`) que le devuelve `grid` en cada pulso.

## Desarrollo

```sh
python3 tools/build_device.py     # regenera midirain.maxpat, midirain.amxd y midirain_clipboard.json
node tests/test_engine.js         # pruebas del motor con stubs de la API de Max
python3 -m http.server            # y abre http://localhost:8000/tools/preview.html
```

`tools/preview.html` ejecuta los dos `.js` tal cual en el navegador, con un canvas que imita mgraphics. Sirve para ver la lluvia sin abrir Live. No tiene audio.
