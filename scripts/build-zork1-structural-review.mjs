import { readFile, writeFile } from 'node:fs/promises';

const source = await readFile('translations/zil/en/zork1/gmain.zil', 'utf8');
const start = source.indexOf('\t\t\t\t\t <TELL "The ">');
const endMarker = '\t\t\t\t\t <TELL "n\'t here." CR>)';
const end = source.indexOf(endMarker, start);
if (start < 0 || end < 0) throw new Error('Bloc dynamique de gmain.zil introuvable.');

const patchesPath = 'translations/structural-overrides.fr.json';
const patches = JSON.parse(await readFile(patchesPath, 'utf8'));
const key = 'zork1/gmain.zil';
patches[key] = [
  {
    source: source.slice(start, end + endMarker.length),
    replacement:
      '\t\t\t\t\t <COND (<EQUAL? ,P-NOT-HERE 1>\n' +
      '\t\t\t\t\t\t<TELL "L\'objet que vous avez mentionné n\'est pas ici." CR>)\n' +
      '\t\t\t\t\t       (<EQUAL? ,P-NOT-HERE .NUM>\n' +
      '\t\t\t\t\t\t<TELL "Les objets que vous avez mentionnés ne sont pas ici." CR>)\n' +
      '\t\t\t\t\t       (T\n' +
      '\t\t\t\t\t\t<TELL "Les autres objets que vous avez mentionnés ne sont pas ici." CR>)>)',
  },
];
patches['zork1/gverbs.zil'] = [
  {
    source: '<TELL "Sitting on the " D .OBJ " is: " CR>',
    replacement: '<TELL "Sur " D .OBJ ", vous voyez :" CR>',
  },
  {
    source: '<TELL "The " D .OBJ " is holding: " CR>',
    replacement: '<TELL D .OBJ " porte :" CR>',
  },
  {
    source: '<TELL "The " D .OBJ " contains:" CR>',
    replacement: '<TELL "Contenu (" D .OBJ ") :" CR>',
  },
];
patches['zork1/1actions.zil'] = [
  {
    source:
      '<COND (<FSET? ,KITCHEN-WINDOW ,OPENBIT>\n' +
      '\t\t       <TELL "open.">)\n' +
      '\t\t      (T <TELL "slightly ajar.">)>',
    replacement:
      '<COND (<FSET? ,KITCHEN-WINDOW ,OPENBIT>\n' +
      '\t\t       <TELL "ouverte.">)\n' +
      '\t\t      (T <TELL "légèrement entrouverte.">)>',
  },
  {
    source:
      '<COND (<FSET? ,KITCHEN-WINDOW ,OPENBIT>\n' +
      '\t\t      <TELL "open." CR>)\n' +
      '\t\t     (T\n' +
      '\t\t      <TELL "slightly ajar." CR>)>',
    replacement:
      '<COND (<FSET? ,KITCHEN-WINDOW ,OPENBIT>\n' +
      '\t\t      <TELL "ouverte." CR>)\n' +
      '\t\t     (T\n' +
      '\t\t      <TELL "légèrement entrouverte." CR>)>',
  },
  {
    source:
      '<COND (<FSET? ,MACHINE ,OPENBIT>\n' +
      '\t\t       <TELL "open.">)\n' +
      '\t\t      (T <TELL "closed.">)>',
    replacement:
      '<COND (<FSET? ,MACHINE ,OPENBIT>\n' +
      '\t\t       <TELL "ouvert.">)\n' +
      '\t\t      (T <TELL "fermé.">)>',
  },
];
await writeFile(patchesPath, `${JSON.stringify(patches, null, 2)}\n`);
console.log('Zork I : assemblage pluriel de gmain.zil reformulé.');
