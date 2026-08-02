import { spawn } from 'node:child_process';
import { rm } from 'node:fs/promises';
import path from 'node:path';
import process from 'node:process';
import { fileURLToPath } from 'node:url';

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const ZILF = process.env.ZILF_BIN ?? 'zilf';
const ALL_GAMES = ['zork1', 'zork2', 'zork3'];
const requestedGames = process.argv.slice(2);
const GAMES = requestedGames.length ? requestedGames : ALL_GAMES;
for (const game of GAMES) {
  if (!ALL_GAMES.includes(game)) throw new Error(`Volume inconnu : ${game}`);
}

function run(command, args, cwd) {
  return new Promise((resolve, reject) => {
    const child = spawn(command, args, { cwd, stdio: 'inherit' });
    child.once('error', reject);
    child.once('exit', (code) => {
      if (code === 0) resolve();
      else reject(new Error(`${command} a quitté avec le code ${code}`));
    });
  });
}

for (const game of GAMES) {
  const sourceDirectory = path.join(ROOT, 'translations', 'zil', 'fr', game);
  const output = path.join(ROOT, 'public', 'games', `${game}.z3`);
  console.log(`Compilation de ${game.toUpperCase()}…`);
  await run(ZILF, ['build', `${game}.zil`, output], sourceDirectory);
  await Promise.all(
    [`${game}.zap`, `${game}_data.zap`, `${game}_freq.zap`, `${game}_str.zap`].map((name) =>
      rm(path.join(sourceDirectory, name), { force: true }),
    ),
  );
}

console.log(`✓ ${GAMES.length} programme(s) Z-Machine français compilé(s).`);
