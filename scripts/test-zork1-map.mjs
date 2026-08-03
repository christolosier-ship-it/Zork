import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import {
  ZORK1_MAP_SECTIONS,
  ZORK1_ROOM_LABELS,
  ZORK1_ROOM_ORDER,
  ZORK1_SECTION_BY_ROOM,
  resolveZork1RoomKey,
} from '../src/zork1-map-data.js';

const source = await readFile('translations/zil/fr/zork1/1dungeon.zil', 'utf8');
const sourceRoomOrder = [...source.matchAll(/<ROOM\s+([^\s>]+)/g)].map((match) => match[1]);

assert.deepEqual(
  ZORK1_ROOM_ORDER,
  sourceRoomOrder,
  'L’ordre des salles de la carte doit suivre exactement la table d’objets Z-Machine.',
);
assert.equal(ZORK1_ROOM_ORDER.length, 110, 'Zork I doit exposer 110 salles cartographiées.');
assert.equal(new Set(ZORK1_ROOM_ORDER).size, ZORK1_ROOM_ORDER.length, 'Chaque salle doit être unique.');

const mappedRooms = ZORK1_MAP_SECTIONS.flatMap((section) => section.nodes.map((node) => node.id));
assert.deepEqual(
  [...mappedRooms].sort(),
  [...ZORK1_ROOM_ORDER].sort(),
  'Toutes les salles doivent apparaître une fois et une seule sur les cartes.',
);
assert.equal(Object.keys(ZORK1_ROOM_LABELS).length, 110);
assert.equal(Object.keys(ZORK1_SECTION_BY_ROOM).length, 110);

for (const section of ZORK1_MAP_SECTIONS) {
  assert.ok(section.width > 0 && section.height > 0, `${section.id} : dimensions invalides.`);
  const ids = new Set([
    ...section.nodes.map((node) => node.id),
    ...section.portals.map((node) => node.id),
  ]);
  assert.equal(ids.size, section.nodes.length + section.portals.length, `${section.id} : nœud dupliqué.`);

  for (const node of [...section.nodes, ...section.portals]) {
    assert.ok(Number.isFinite(node.x) && Number.isFinite(node.y), `${node.id} : coordonnées invalides.`);
    assert.ok(node.label, `${node.id} : libellé absent.`);
  }

  for (const route of section.edges) {
    assert.ok(ids.has(route.from), `${section.id} : départ inconnu ${route.from}.`);
    assert.ok(ids.has(route.to), `${section.id} : arrivée inconnue ${route.to}.`);
    assert.ok(route.fromExit, `${section.id} : direction absente pour ${route.from}.`);
  }
}

const startObjectId = 120;
for (let index = 0; index < ZORK1_ROOM_ORDER.length; index += 1) {
  assert.equal(resolveZork1RoomKey(startObjectId, startObjectId + index), ZORK1_ROOM_ORDER[index]);
}
assert.equal(resolveZork1RoomKey(startObjectId, startObjectId - 1), null);
assert.equal(resolveZork1RoomKey(startObjectId, startObjectId + 110), null);
assert.equal(resolveZork1RoomKey(null, startObjectId), null);

console.log('✓ Carte Zork I : 110 salles, topologie et résolution Z-Machine validées.');
