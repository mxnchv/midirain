# Gumroad

Ficha de la tienda (en inglés). Precio: pay what you want, mínimo 5 €, sugerido 10 €.
Imágenes (se regeneran con `node tools/promo.js`; todas en Jost):
1. Portada: `promo/cover-a.gif` (1280×720, lluvia a pantalla completa).
2. Segunda imagen de la galería: `promo/cover-b.gif` (el dispositivo). Sale de la preview del navegador;
   cuando haya una grabación de pantalla de Live, mejor esa.
3. Miniatura: `promo/thumbnail.png` (600×600).

Fondos para vídeo (`node tools/promo.js bg`): `promo/bg-1920x1080.mp4` y `promo/bg-1080x1920.mp4`,
12 s a 60 fps, sin rótulo, en bucle sin corte (los 2 últimos segundos se funden con el principio).

---

**Product name**
midirain

**Summary**
A Max for Live MIDI effect where rain plays your notes.

**Description**

Rain falls on invisible columns. Each column is a note. Each drop that hits the ground plays it.

midirain is a MIDI effect for Ableton Live. Put it in front of any instrument and let the rain write the melody: sparse drizzle, dense storms, wind that tilts everything sideways.

**What you can shape**
- **Density, Fall, Wind:** how much it rains, how fast and at what angle.
- **Distance:** far rain gives thin, quiet drops; close rain gives big, loud ones. It sets the velocity range.
- **Scale mode:** the columns are the notes of a scale (11 to choose from) within a range you set.
- **Held mode:** the columns are the notes you hold on your MIDI input. Play a chord and it rains on it.
- **Sync:** quantize the impacts to the grid, from 1/32 to 1/2, with triplets. It works with Live playing or stopped.
- **Length:** the duration of each note.

Every control has its own description in Live's Info View.

**Coming soon: plugin version**
A VST3/AU version for other DAWs is on the way. If you buy the Max for Live device, you get the plugin free when it's out.

**Requirements**
- Ableton Live 12 Suite, or Live 12 Standard with Max for Live
- Mac or Windows

**What you get**
- `midirain.amxd`, a single file. Drop it onto a MIDI track in front of an instrument.
- No license keys, no activation, no DRM.

**Pricing**
Pay what you want, from €5. €10 is the suggested price. If it makes music for you, that's what keeps it going.

**Tip:** midirain sends MIDI to the instrument after it on the same track. To record what it plays, route that track's MIDI into a second track and arm it.
