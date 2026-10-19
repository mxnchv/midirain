// Genera las imágenes de Gumroad a partir de tools/preview.html (la lluvia real del motor).
//   python3 -m http.server 8000 &   node tools/promo.js
// Escribe en promo/: cover-a.{gif,mp4} (lluvia a sangre), cover-b.{gif,mp4} (el dispositivo)
// y thumbnail.png. Con `node tools/promo.js bg`: fondos en bucle para vídeo, bg-1920x1080.mp4 y
// bg-1080x1920.mp4 (60 fps, sin rótulo). El reloj del navegador lo avanza Playwright: 30 fps exactos, sin tirones.
var path = require('path');
var fs = require('fs');
var cp = require('child_process');
var { chromium } = require(process.env.PLAYWRIGHT_PATH || 'playwright');

var BASE = 'http://localhost:8000/tools/preview.html';
var OUT = path.join(__dirname, '..', 'promo');
var FPS = 30;
var BG_FPS = 60, BG_LOOP = 12, BG_FADE = 2;   // segundos
var DENSITY = 'density=55';

// rótulo encima de la escena, en Jost (la tipografía del plugin)
function overlay(opts) {
    var link = document.createElement('link');
    link.rel = 'stylesheet';
    link.href = 'https://fonts.googleapis.com/css2?family=Jost:wght@300;400&display=swap';
    document.head.appendChild(link);
    var css = document.createElement('style');
    css.textContent =
        '.promo { position: fixed; left: 0; right: 0; top: ' + opts.top + 'px; text-align: center; pointer-events: none;' +
        ' font-family: "Jost", sans-serif; color: #fff; }' +
        '.promo b { display: block; font-weight: 400; font-size: ' + opts.size + 'px; letter-spacing: 0.02em; }' +
        '.promo i { display: block; font-style: normal; font-weight: 300; font-size: ' + opts.sub + 'px; opacity: 0.55; letter-spacing: 0.12em; margin-top: 2px; }' +
        (opts.device ? 'body { background: #000; } .log { display: none; } .device { outline: 0; margin-top: ' + opts.device + 'px; }' : '');
    document.head.appendChild(css);
    var d = document.createElement('div');
    d.className = 'promo';
    d.innerHTML = '<b>midirain</b>' + (opts.caption ? '<i>' + opts.caption + '</i>' : '');
    document.body.appendChild(d);
    return Promise.all([document.fonts.load('400 ' + opts.size + 'px "Jost"'), document.fonts.load('300 ' + (opts.sub || 8) + 'px "Jost"')]);
}

async function frames(browser, name, o) {
    var fps = o.fps || FPS;
    var dir = path.join(OUT, 'frames-' + name);
    fs.rmSync(dir, { recursive: true, force: true });
    fs.mkdirSync(dir, { recursive: true });
    var page = await browser.newPage({ viewport: o.viewport, deviceScaleFactor: o.dpr });
    await page.clock.install();
    await page.goto(BASE + '?' + o.query);
    await page.waitForFunction(function () { return window.midirain; });
    if (o.overlay) await page.evaluate(overlay, o.overlay);
    await page.clock.runFor(4000);   // que la lluvia ya esté cayendo en el primer fotograma
    var n = Math.round(o.seconds * fps);
    for (var i = 0; i < n; i++) {
        await page.clock.runFor(1000 / fps);
        await page.screenshot({ path: path.join(dir, String(i).padStart(4, '0') + '.png') });
    }
    await page.close();
    return path.join(dir, '%04d.png');
}

function ff(args) { cp.execFileSync('ffmpeg', ['-y', '-loglevel', 'error'].concat(args), { stdio: 'inherit' }); }

function encode(seq, name) {
    ff(['-framerate', String(FPS), '-i', seq, '-c:v', 'libx264', '-pix_fmt', 'yuv420p', '-crf', '16',
        path.join(OUT, name + '.mp4')]);
    ff(['-framerate', String(FPS), '-i', seq, '-vf',
        'fps=20,split[a][b];[a]palettegen=max_colors=64[p];[b][p]paletteuse=dither=none',
        path.join(OUT, name + '.gif')]);
}

// bucle sin corte: se graban BG_LOOP + BG_FADE segundos y el final se funde sobre el principio,
// así el último fotograma enlaza con el primero
function loop(seq, name) {
    var L = BG_LOOP, F = BG_FADE;
    ff(['-framerate', String(BG_FPS), '-i', seq, '-filter_complex',
        '[0]split=3[x][y][z];' +
        '[x]trim=0:' + F + ',setpts=PTS-STARTPTS[head];' +
        '[y]trim=' + L + ':' + (L + F) + ',setpts=PTS-STARTPTS[tail];' +
        '[z]trim=' + F + ':' + L + ',setpts=PTS-STARTPTS[mid];' +
        "[head][tail]blend=all_expr='A*(T/" + F + ")+B*(1-T/" + F + ")'[seam];" +
        '[seam][mid]concat=n=2:v=1[v]',
        '-map', '[v]', '-c:v', 'libx264', '-pix_fmt', 'yuv420p', '-crf', '14', '-movflags', '+faststart',
        path.join(OUT, name + '.mp4')]);
}

async function backgrounds(browser) {
    // 4x, como en las portadas: las gotas tienen el grosor del dispositivo
    var sizes = [[480, 270, 'bg-1920x1080'], [270, 480, 'bg-1080x1920']];
    for (var i = 0; i < sizes.length; i++) {
        var w = sizes[i][0], h = sizes[i][1], name = sizes[i][2];
        loop(await frames(browser, name, {
            query: 'rain=' + w + 'x' + h + '&dpr=4&' + DENSITY, viewport: { width: w, height: h }, dpr: 4,
            fps: BG_FPS, seconds: BG_LOOP + BG_FADE
        }), name);
        fs.rmSync(path.join(OUT, 'frames-' + name), { recursive: true, force: true });
    }
}

(async function () {
    var browser = await chromium.launch();
    if (process.argv[2] === 'bg') { await backgrounds(browser); await browser.close(); return; }
    // A: lluvia a sangre. 320x180 a 4x → 1280x720, con las gotas del grosor que tienen en el dispositivo
    encode(await frames(browser, 'cover-a', {
        query: 'rain=320x180&dpr=4&' + DENSITY, viewport: { width: 320, height: 180 }, dpr: 4, seconds: 6,
        overlay: { top: 34, size: 18, sub: 5, caption: 'a max for live midi effect' }
    }), 'cover-a');
    // B: el dispositivo tal cual, a 2x, centrado
    encode(await frames(browser, 'cover-b', {
        // sin tocar Density: los knobs de la preview tienen que mostrar los valores con los que llueve
        query: '', viewport: { width: 640, height: 360 }, dpr: 2, seconds: 6,
        overlay: { top: 76, size: 28, sub: 8, caption: 'a max for live midi effect', device: 84 }
    }), 'cover-b');
    // miniatura cuadrada 600x600
    var thumb = await frames(browser, 'thumb', {
        query: 'rain=200x200&dpr=3&' + DENSITY, viewport: { width: 200, height: 200 }, dpr: 3, seconds: 1,
        overlay: { top: 70, size: 22, sub: 0, caption: '' }
    });
    fs.copyFileSync(thumb.replace('%04d', '0029'), path.join(OUT, 'thumbnail.png'));
    await browser.close();
    ['cover-a', 'cover-b', 'thumb'].forEach(function (n) {
        fs.rmSync(path.join(OUT, 'frames-' + n), { recursive: true, force: true });
    });
})().catch(function (e) { console.error(e); process.exit(1); });
