import { readFile } from 'node:fs/promises';
// The package's source ESM build uses extensionless internal imports, which Node
// does not resolve. Its published browser bundle is self-contained and exposes
// the same public API, so the smoke test exercises the exact code shipped to Vite.
import { TestIOAdapter, ZMachine } from '../node_modules/zmachine/dist/zmachine.esm.min.js';
import { GAMES } from '../src/catalog.js';

for (const game of GAMES) {
  const story = await readFile(`public/games/${game.id}.z3`);
  const io = new TestIOAdapter();
  io.initialize(3);

  for (const command of ['look', 'inventory', 'score', 'quit', 'yes', 'y']) {
    io.queueLineInput(command);
  }
  io.queueCharInput('y'.charCodeAt(0));

  const machine = ZMachine.load(story, io);
  await machine.run();

  const output = io.getLowerOutput();
  if (machine.version !== 3 || output.length < 300 || !/ZORK/i.test(output)) {
    throw new Error(`${game.title} ne produit pas une session Z-Machine valide.`);
  }

  if (!io.hasQuit) {
    throw new Error(`${game.title} n’a pas terminé correctement le scénario de test.`);
  }

  console.log(`✓ ${game.title} : ${output.length} caractères interprétés.`);
}
