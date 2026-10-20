# midirain plugin: decisiones

Lo acordado para la versión plugin. El código vivirá en un repo aparte, `midirain-plugin`.

## Qué es

- Instrumento con sonidos propios y salida MIDI: suena solo y, con MIDI out, manda las notas a otras pistas.
- Mismo motor que el M4L (`midirain_engine.js`), pasado a C++: Density, Fall, Wind, Distance, Length, Sync, Mode (Scale / Held), Root, Scale, rango de notas.
- Gratis para quien compró el M4L.

## Formatos y plataformas

- Mac y Windows desde el principio.
- VST3, AU instrumento, AU MIDI FX (para sacar MIDI en Logic, como plugin aparte dentro del mismo paquete), CLAP y app independiente.
- JUCE. Compilación automática en GitHub para los dos sistemas.
- Mac: firma y notarización con Apple Developer (99 $/año), que se paga justo antes de lanzar.
- Pruebas: Mac con Ableton, Reaper, FL Studio y Logic. Windows: falta alguien que lo pruebe.
- Ableton: se engancha una pista MIDI nueva a la pista del plugin para recoger sus notas (como con APSIS).

## Sonidos

Los synths de la web (sxvnds vol. 1): 01, 02, 03, 04 y 06, en `mxnchv.xyz/media/synths/`.

## Diseño

Mockup aprobado: `docs/plugin-mockup.png`. Estética de APSIS:

- Negro, Jost. Tres niveles de gris: blanco (activo y valores), gris medio (etiquetas), tenue (inactivo).
- Cabecera: «m i d i r a i n» en minúscula, espaciado y fino; Sound (texto + flecha); Vol (línea fina con punto); botón redondeado «MIDI out» con un punto que brilla con cada nota; «mxnchv» tenue a la derecha.
- Lluvia panorámica en el centro.
- Barra inferior con dos secciones, títulos en mayúsculas pequeñas y espaciadas:
  - RAIN: knobs finos (aro abierto abajo, nombre y valor debajo): Density, Fall, Wind, Distance.
  - NOTES: Scale / Held como pestañas de texto subrayadas; Length como valor que se arrastra; Sync, Root y Scale como texto + flecha; Range como línea con dos puntos («C2 – C4»).
- Sin cajas.
- Desplegables como los de APSIS:
  - panel negro con borde gris fino y esquinas redondeadas;
  - la opción bajo el ratón, con un contorno redondeado;
  - la elegida, con un punto «·» bien visible a la derecha;
  - todas las opciones en una lista, sin submenús.
