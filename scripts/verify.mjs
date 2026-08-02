import { access, readFile, stat } from 'node:fs/promises';
import { GAMES } from '../src/catalog.js';

const requiredFiles = [
  'index.html',
  'public/manifest.webmanifest',
  'public/sw.js',
  'public/icons/icon-192.png',
  'public/icons/icon-512.png',
  'public/icons/maskable-512.png',
  ...GAMES.map((game) => `public/games/${game.id}.z3`),
];

for (const path of requiredFiles) {
  await access(path);
}

const manifest = JSON.parse(await readFile('public/manifest.webmanifest', 'utf8'));
if (manifest.display !== 'standalone' || manifest.icons?.length < 3) {
  throw new Error('Le manifeste PWA est incomplet.');
}

for (const game of GAMES) {
  const path = `public/games/${game.id}.z3`;
  const data = await readFile(path);
  const metadata = await stat(path);

  if (data[0] !== 3) {
    throw new Error(`${path} n’est pas un fichier Z-Machine v3.`);
  }

  if (metadata.size < 50_000) {
    throw new Error(`${path} semble tronqué.`);
  }
}

console.log(`✓ PWA vérifiée : ${GAMES.length} volumes Z-Machine v3 prêts.`);
