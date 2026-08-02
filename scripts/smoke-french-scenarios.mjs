import { readFile } from 'node:fs/promises';
import { TestIOAdapter, ZMachine } from '../node_modules/zmachine/dist/zmachine.esm.min.js';
import { translateFrenchCommand } from '../src/french-commands.js';

const SCENARIOS = {
  zork1: {
    commands: [
      'observer',
      'ouvrir la boîte aux lettres',
      'prendre le dépliant',
      'lire le dépliant',
      'inventaire',
      'score',
      'quitter',
      'oui',
    ],
    expected: [/Grand Empire Souterrain/i, /boîte aux lettres/i, /dépliant/i],
  },
  zork2: {
    commands: [
      'prendre la lanterne',
      'prendre l’épée',
      'allumer la lanterne',
      'sud',
      'observer',
      'inventaire',
      'quitter',
      'oui',
    ],
    expected: [/Magicien de Frobozz/i, /tumulus/i, /lanterne/i],
  },
  zork3: {
    commands: [
      'prendre la lanterne',
      'allumer la lanterne',
      'sud',
      'observer',
      'inventaire',
      'quitter',
      'oui',
    ],
    expected: [/Maître du Donjon/i, /Escalier sans fin/i, /lanterne/i],
  },
};

for (const [gameId, scenario] of Object.entries(SCENARIOS)) {
  const story = await readFile(`public/games/${gameId}.z3`);
  const io = new TestIOAdapter();
  io.initialize(3);
  for (const command of scenario.commands) {
    io.queueLineInput(translateFrenchCommand(command));
  }
  io.queueCharInput('y'.charCodeAt(0));

  const machine = ZMachine.load(story, io);
  await machine.run();
  const output = io.getLowerOutput();

  for (const expected of scenario.expected) {
    if (!expected.test(output)) {
      throw new Error(`${gameId} : sortie attendue absente (${expected}).`);
    }
  }
  if (/Je ne connais pas le mot|d'une manière que je ne comprends pas/i.test(output)) {
    throw new Error(`${gameId} : une commande française du scénario n'est pas comprise.`);
  }
  if (!io.hasQuit) throw new Error(`${gameId} : le scénario français ne se termine pas.`);

  console.log(`✓ ${gameId.toUpperCase()} : ${scenario.commands.length} commandes françaises jouées.`);
}
