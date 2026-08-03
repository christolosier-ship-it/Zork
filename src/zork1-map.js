import { ZMachine } from 'zmachine';
import {
  ZORK1_MAP_SECTIONS,
  ZORK1_ROOM_LABELS,
  ZORK1_SECTION_BY_ROOM,
  resolveZork1RoomKey,
} from './zork1-map-data.js';
import './zork1-map.css';

const SVG_NS = 'http://www.w3.org/2000/svg';
const NODE_WIDTH = 144;
const NODE_HEIGHT = 52;
const MIN_SCALE = 0.72;
const MAX_SCALE = 2.4;
const HAS_BROWSER = typeof window !== 'undefined' && typeof document !== 'undefined';
const ZORK1_SELECTED =
  HAS_BROWSER && new URLSearchParams(window.location.search).get('game') === 'zork1';

let activeMachine = null;
let startRoomObjectId = null;
let currentRoomKey = null;
let activeSectionId = 'surface';
let selectedRoomKey = null;
let transform = { x: 0, y: 0, scale: 1 };
let pointerState = null;
let didDrag = false;

if (HAS_BROWSER) {
  const originalLoad = ZMachine.load;
  ZMachine.load = function loadWithMapTracking(...args) {
    const machine = originalLoad.apply(this, args);
    if (ZORK1_SELECTED) {
      activeMachine = machine;
      startRoomObjectId = findStartRoomObjectId(machine);
      currentRoomKey = null;
      window.setTimeout(syncCurrentRoom, 0);
    }
    return machine;
  };
}

if (ZORK1_SELECTED) installMapInterface();

function installMapInterface() {
  const actionList = document.querySelector('.dossier-actions');
  if (!actionList || document.querySelector('#zork-map-dialog')) return;

  const mapButton = document.createElement('button');
  mapButton.type = 'button';
  mapButton.className = 'zork-map-button';
  mapButton.setAttribute('aria-haspopup', 'dialog');
  mapButton.setAttribute('aria-controls', 'zork-map-dialog');
  mapButton.innerHTML = `
    <svg viewBox="0 0 24 24" aria-hidden="true">
      <path d="m4 5 5-2 6 2 5-2v16l-5 2-6-2-5 2V5Z" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linejoin="round" />
      <path d="M9 3v16m6-14v16" fill="none" stroke="currentColor" stroke-width="1.4" />
    </svg>
    Carte
  `;
  const restartButton = actionList.querySelector('[data-action="restart"]');
  actionList.insertBefore(mapButton, restartButton ?? null);

  const dialog = document.createElement('dialog');
  dialog.className = 'app-dialog zork-map-dialog';
  dialog.id = 'zork-map-dialog';
  dialog.innerHTML = `
    <div class="dialog-header zork-map-header">
      <div>
        <p class="kicker"><span></span> Atlas de l’aventurier</p>
        <h2>Carte de Zork I</h2>
      </div>
      <button class="icon-button" type="button" data-close-dialog aria-label="Fermer la carte">
        <svg viewBox="0 0 24 24" aria-hidden="true">
          <path d="m6 6 12 12M18 6 6 18" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" />
        </svg>
      </button>
    </div>
    <div class="zork-map-body">
      <div class="zork-map-tabs" role="tablist" aria-label="Zones de la carte"></div>
      <div class="zork-map-toolbar">
        <div class="zork-map-location" aria-live="polite">
          <span class="zork-map-location-dot" aria-hidden="true"></span>
          <span>Position en cours :</span>
          <strong id="zork-map-current-location">Localisation…</strong>
        </div>
        <div class="zork-map-controls" aria-label="Contrôles de la carte">
          <button type="button" data-map-control="zoom-out" aria-label="Dézoomer" title="Dézoomer">−</button>
          <button type="button" data-map-control="zoom-in" aria-label="Zoomer" title="Zoomer">+</button>
          <button type="button" data-map-control="center">Me recentrer</button>
          <button type="button" data-map-control="reset">Vue entière</button>
        </div>
      </div>
      <div class="zork-map-layout">
        <div class="zork-map-viewport" aria-label="Carte interactive de Zork I">
          <svg id="zork-map-svg" role="img" aria-labelledby="zork-map-svg-title zork-map-svg-desc">
            <title id="zork-map-svg-title">Carte interactive de Zork I</title>
            <desc id="zork-map-svg-desc">Les salles sont reliées par leurs directions. Le gros point rouge indique votre emplacement actuel.</desc>
            <defs>
              <marker id="zork-map-arrow" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
                <path d="M 0 0 L 10 5 L 0 10 z"></path>
              </marker>
            </defs>
            <g id="zork-map-layer"></g>
          </svg>
          <div class="zork-map-drag-hint">Glissez pour déplacer · pincez ou utilisez + / − pour zoomer</div>
        </div>
        <aside class="zork-map-details" aria-live="polite">
          <p class="kicker"><span></span> Lieu sélectionné</p>
          <h3 id="zork-map-place-title">Choisissez une salle</h3>
          <p id="zork-map-place-state">Touchez un lieu pour consulter ses sorties.</p>
          <div id="zork-map-exits"></div>
          <p class="zork-map-legend">
            <span><i class="legend-current"></i> Vous êtes ici</span>
            <span><i class="legend-secret"></i> Passage conditionnel</span>
            <span><i class="legend-one-way"></i> Sens unique</span>
          </p>
        </aside>
      </div>
      <p class="zork-map-spoiler">La carte révèle la géographie générale du jeu, mais pas la solution des énigmes ni l’emplacement des objets.</p>
    </div>
  `;
  document.body.append(dialog);

  const tabs = dialog.querySelector('.zork-map-tabs');
  for (const section of ZORK1_MAP_SECTIONS) {
    const tab = document.createElement('button');
    tab.type = 'button';
    tab.role = 'tab';
    tab.dataset.mapSection = section.id;
    tab.textContent = section.shortLabel;
    tabs.append(tab);
  }

  mapButton.addEventListener('click', () => {
    syncCurrentRoom();
    const currentSection = currentRoomKey ? ZORK1_SECTION_BY_ROOM[currentRoomKey] : null;
    switchSection(currentSection ?? activeSectionId, { centerCurrent: true });
    dialog.showModal();
  });

  dialog.addEventListener('click', (event) => {
    if (event.target === dialog) dialog.close();
  });

  tabs.addEventListener('click', (event) => {
    const tab = event.target.closest('[data-map-section]');
    if (tab) switchSection(tab.dataset.mapSection);
  });

  dialog.querySelector('.zork-map-controls').addEventListener('click', (event) => {
    const button = event.target.closest('[data-map-control]');
    if (!button) return;
    if (button.dataset.mapControl === 'zoom-in') zoomMap(1.2);
    if (button.dataset.mapControl === 'zoom-out') zoomMap(1 / 1.2);
    if (button.dataset.mapControl === 'center') centerOnCurrentRoom();
    if (button.dataset.mapControl === 'reset') resetMapView();
  });

  const svg = dialog.querySelector('#zork-map-svg');
  svg.addEventListener('pointerdown', beginPan);
  svg.addEventListener('pointermove', continuePan);
  svg.addEventListener('pointerup', endPan);
  svg.addEventListener('pointercancel', endPan);
  svg.addEventListener('wheel', handleWheel, { passive: false });

  const statusLine = document.querySelector('#status-line');
  if (statusLine) {
    new MutationObserver(syncCurrentRoom).observe(statusLine, {
      childList: true,
      subtree: true,
      characterData: true,
    });
  }

  window.setInterval(syncCurrentRoom, 350);
  switchSection(activeSectionId);
}

function findStartRoomObjectId(machine) {
  for (let objectId = 1; objectId <= 255; objectId += 1) {
    try {
      const name = normalizeLocationName(machine.getObjectName(objectId));
      if (name.includes('ouest de la maison')) return objectId;
    } catch {
      // Les numéros hors de la table d’objets sont simplement ignorés.
    }
  }
  return null;
}

function normalizeLocationName(value) {
  return String(value ?? '')
    .normalize('NFD')
    .replace(/\p{M}/gu, '')
    .toLowerCase()
    .replace(/[’']/g, ' ')
    .replace(/[^a-z0-9\s]/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();
}

function syncCurrentRoom() {
  if (!activeMachine) return;

  try {
    startRoomObjectId ??= findStartRoomObjectId(activeMachine);
    const currentObjectId = activeMachine.variables.load(16);
    const nextRoomKey = resolveZork1RoomKey(startRoomObjectId, currentObjectId);
    if (!nextRoomKey || !ZORK1_ROOM_LABELS[nextRoomKey]) return;

    const changed = nextRoomKey !== currentRoomKey;
    currentRoomKey = nextRoomKey;
    updateCurrentLocationText();

    const dialog = document.querySelector('#zork-map-dialog');
    if (!dialog?.open) return;

    const nextSection = ZORK1_SECTION_BY_ROOM[nextRoomKey];
    if (changed && nextSection && nextSection !== activeSectionId) {
      switchSection(nextSection, { centerCurrent: true });
    } else if (changed) {
      renderSection();
      centerOnCurrentRoom();
    }
  } catch {
    // La machine peut être entre deux cycles d’interprétation.
  }
}

function updateCurrentLocationText() {
  const location = document.querySelector('#zork-map-current-location');
  if (!location) return;
  location.textContent = currentRoomKey
    ? ZORK1_ROOM_LABELS[currentRoomKey]
    : 'Position non disponible';
}

function switchSection(sectionId, { centerCurrent = false } = {}) {
  const section = getSection(sectionId);
  if (!section) return;
  activeSectionId = section.id;
  selectedRoomKey = null;
  transform = { x: 0, y: 0, scale: 1 };

  for (const tab of document.querySelectorAll('[data-map-section]')) {
    const selected = tab.dataset.mapSection === section.id;
    tab.setAttribute('aria-selected', String(selected));
    tab.classList.toggle('is-active', selected);
  }

  renderSection();
  if (centerCurrent && ZORK1_SECTION_BY_ROOM[currentRoomKey] === section.id) {
    centerOnCurrentRoom();
  } else {
    resetMapView();
  }
}

function renderSection() {
  const section = getSection(activeSectionId);
  const svg = document.querySelector('#zork-map-svg');
  const layer = document.querySelector('#zork-map-layer');
  if (!section || !svg || !layer) return;

  svg.setAttribute('viewBox', `0 0 ${section.width} ${section.height}`);
  layer.replaceChildren();
  const allNodes = [...section.nodes, ...section.portals];
  const nodesById = new Map(allNodes.map((node) => [node.id, node]));

  const edgeGroup = createSvg('g', { class: 'zork-map-edges' });
  for (const route of section.edges) {
    const from = nodesById.get(route.from);
    const to = nodesById.get(route.to);
    if (!from || !to) continue;
    edgeGroup.append(renderEdge(route, from, to));
  }
  layer.append(edgeGroup);

  const nodeGroup = createSvg('g', { class: 'zork-map-nodes' });
  for (const node of allNodes) nodeGroup.append(renderNode(node, section));
  layer.append(nodeGroup);

  applyTransform();
  updateCurrentLocationText();
  updateDetails(selectedRoomKey ?? currentRoomKey);
}

function renderEdge(route, from, to) {
  const group = createSvg('g', {
    class: [
      'zork-map-edge',
      route.conditional ? 'is-conditional' : '',
      route.oneWay ? 'is-one-way' : '',
      route.portal ? 'is-portal' : '',
    ].filter(Boolean).join(' '),
  });

  let labelX;
  let labelY;
  if (from.id === to.id) {
    const path = createSvg('path', {
      d: `M ${from.x + 45} ${from.y - 18} C ${from.x + 105} ${from.y - 85}, ${from.x - 95} ${from.y - 85}, ${from.x - 45} ${from.y - 18}`,
    });
    path.setAttribute('marker-end', 'url(#zork-map-arrow)');
    group.append(path);
    labelX = from.x;
    labelY = from.y - 72;
  } else {
    const line = createSvg('line', {
      x1: from.x,
      y1: from.y,
      x2: to.x,
      y2: to.y,
    });
    if (route.oneWay) line.setAttribute('marker-end', 'url(#zork-map-arrow)');
    group.append(line);
    labelX = (from.x + to.x) / 2;
    labelY = (from.y + to.y) / 2;
  }

  const label = route.toExit ? `${route.fromExit} · ${route.toExit}` : route.fromExit;
  if (label) group.append(renderEdgeLabel(label, labelX, labelY));
  return group;
}

function renderEdgeLabel(label, x, y) {
  const width = Math.min(150, Math.max(30, label.length * 6.2 + 14));
  const group = createSvg('g', { class: 'zork-map-edge-label' });
  group.append(createSvg('rect', {
    x: x - width / 2,
    y: y - 10,
    width,
    height: 20,
    rx: 8,
  }));
  const text = createSvg('text', { x, y: y + 3, 'text-anchor': 'middle' });
  text.textContent = label;
  group.append(text);
  return group;
}

function renderNode(node) {
  const group = createSvg('g', {
    class: [
      'zork-map-node',
      node.portal ? 'is-portal' : '',
      node.conditional ? 'is-conditional' : '',
      node.id === currentRoomKey ? 'is-current' : '',
      node.id === selectedRoomKey ? 'is-selected' : '',
    ].filter(Boolean).join(' '),
    transform: `translate(${node.x} ${node.y})`,
  });

  group.setAttribute('role', 'button');
  group.setAttribute('tabindex', '0');
  group.setAttribute('aria-label', node.portal ? `${node.label}, changer de zone` : node.label);
  group.append(createSvg('rect', {
    x: -NODE_WIDTH / 2,
    y: -NODE_HEIGHT / 2,
    width: NODE_WIDTH,
    height: NODE_HEIGHT,
    rx: 12,
  }));

  const lines = wrapLabel(node.label);
  const text = createSvg('text', {
    x: 0,
    y: lines.length === 1 ? 4 : -4,
    'text-anchor': 'middle',
  });
  lines.forEach((line, index) => {
    const tspan = createSvg('tspan', {
      x: 0,
      dy: index === 0 ? 0 : 15,
    });
    tspan.textContent = line;
    text.append(tspan);
  });
  group.append(text);

  if (node.portal) {
    const arrow = createSvg('text', {
      class: 'zork-map-portal-arrow',
      x: NODE_WIDTH / 2 - 13,
      y: 5,
      'text-anchor': 'middle',
    });
    arrow.textContent = '↗';
    group.append(arrow);
  }

  if (node.id === currentRoomKey) {
    const marker = createSvg('g', {
      class: 'zork-map-player-marker',
      transform: `translate(${NODE_WIDTH / 2 - 8} ${-NODE_HEIGHT / 2 + 5})`,
      'aria-label': 'Vous êtes ici',
    });
    marker.append(createSvg('circle', { class: 'zork-map-player-halo', r: 19 }));
    marker.append(createSvg('circle', { class: 'zork-map-player-dot', r: 10 }));
    group.append(marker);
  }

  const activate = (event) => {
    if (didDrag) return;
    event.stopPropagation();
    if (node.portal) {
      switchSection(node.section);
      return;
    }
    selectedRoomKey = node.id;
    renderSection();
  };
  group.addEventListener('click', activate);
  group.addEventListener('keydown', (event) => {
    if (event.key === 'Enter' || event.key === ' ') {
      event.preventDefault();
      activate(event);
    }
  });

  if (!node.portal && node.id === currentRoomKey && !selectedRoomKey) {
    selectedRoomKey = node.id;
  }
  return group;
}

function updateDetails(roomKey) {
  const title = document.querySelector('#zork-map-place-title');
  const state = document.querySelector('#zork-map-place-state');
  const exits = document.querySelector('#zork-map-exits');
  if (!title || !state || !exits) return;

  const section = getSection(activeSectionId);
  const node = section?.nodes.find((candidate) => candidate.id === roomKey);
  if (!node) {
    title.textContent = 'Choisissez une salle';
    state.textContent = 'Touchez un lieu pour consulter ses sorties.';
    exits.replaceChildren();
    return;
  }

  title.textContent = node.label;
  state.textContent = node.id === currentRoomKey
    ? 'Vous vous trouvez actuellement ici.'
    : 'Lieu indiqué sur la carte.';

  const routes = section.edges.flatMap((route) => {
    if (route.from === node.id) {
      return [{
        direction: route.fromExit,
        target: route.to,
        conditional: route.conditional,
        oneWay: route.oneWay,
      }];
    }
    if (route.to === node.id && route.toExit) {
      return [{
        direction: route.toExit,
        target: route.from,
        conditional: route.conditional,
        oneWay: false,
      }];
    }
    return [];
  });

  exits.replaceChildren();
  if (!routes.length) {
    const empty = document.createElement('p');
    empty.className = 'zork-map-no-exits';
    empty.textContent = 'Aucune sortie cartographiée.';
    exits.append(empty);
    return;
  }

  const list = document.createElement('ul');
  list.className = 'zork-map-exit-list';
  const allNodes = new Map(
    [...section.nodes, ...section.portals].map((candidate) => [candidate.id, candidate]),
  );
  for (const route of routes) {
    const item = document.createElement('li');
    const direction = document.createElement('strong');
    direction.textContent = route.direction;
    const destination = document.createElement('span');
    destination.textContent = allNodes.get(route.target)?.label ?? 'Passage inconnu';
    item.append(direction, destination);
    if (route.conditional) {
      const badge = document.createElement('small');
      badge.textContent = 'conditionnel';
      item.append(badge);
    } else if (route.oneWay) {
      const badge = document.createElement('small');
      badge.textContent = 'sens unique';
      item.append(badge);
    }
    list.append(item);
  }
  exits.append(list);
}

function wrapLabel(label) {
  if (label.length <= 22) return [label];
  const words = label.split(' ');
  let first = '';
  let second = '';
  for (const word of words) {
    if (!second && `${first} ${word}`.trim().length <= 20) first = `${first} ${word}`.trim();
    else second = `${second} ${word}`.trim();
  }
  return [first, second].filter(Boolean);
}

function createSvg(tagName, attributes = {}) {
  const element = document.createElementNS(SVG_NS, tagName);
  for (const [name, value] of Object.entries(attributes)) {
    element.setAttribute(name, String(value));
  }
  return element;
}

function getSection(sectionId) {
  return ZORK1_MAP_SECTIONS.find((section) => section.id === sectionId) ?? null;
}

function resetMapView() {
  transform = { x: 0, y: 0, scale: 1 };
  applyTransform();
}

function centerOnCurrentRoom() {
  const section = getSection(activeSectionId);
  const node = section?.nodes.find((candidate) => candidate.id === currentRoomKey);
  if (!section || !node) {
    resetMapView();
    return;
  }

  const scale = Math.max(1.12, transform.scale);
  transform = {
    scale,
    x: section.width / 2 - node.x * scale,
    y: section.height / 2 - node.y * scale,
  };
  applyTransform();
}

function zoomMap(factor, focalPoint = null) {
  const section = getSection(activeSectionId);
  if (!section) return;
  const oldScale = transform.scale;
  const nextScale = Math.min(MAX_SCALE, Math.max(MIN_SCALE, oldScale * factor));
  if (nextScale === oldScale) return;

  const focal = focalPoint ?? { x: section.width / 2, y: section.height / 2 };
  const mapX = (focal.x - transform.x) / oldScale;
  const mapY = (focal.y - transform.y) / oldScale;
  transform = {
    scale: nextScale,
    x: focal.x - mapX * nextScale,
    y: focal.y - mapY * nextScale,
  };
  applyTransform();
}

function applyTransform() {
  const layer = document.querySelector('#zork-map-layer');
  if (!layer) return;
  layer.setAttribute(
    'transform',
    `translate(${transform.x} ${transform.y}) scale(${transform.scale})`,
  );
}

function beginPan(event) {
  if (event.button !== 0) return;
  pointerState = { id: event.pointerId, x: event.clientX, y: event.clientY };
  didDrag = false;
  event.currentTarget.setPointerCapture(event.pointerId);
  event.currentTarget.classList.add('is-dragging');
}

function continuePan(event) {
  if (!pointerState || pointerState.id !== event.pointerId) return;
  const section = getSection(activeSectionId);
  const svg = event.currentTarget;
  const rect = svg.getBoundingClientRect();
  if (!section || !rect.width || !rect.height) return;

  const deltaX = event.clientX - pointerState.x;
  const deltaY = event.clientY - pointerState.y;
  if (Math.abs(deltaX) + Math.abs(deltaY) > 3) didDrag = true;
  transform.x += deltaX * (section.width / rect.width);
  transform.y += deltaY * (section.height / rect.height);
  pointerState = { id: event.pointerId, x: event.clientX, y: event.clientY };
  applyTransform();
}

function endPan(event) {
  if (!pointerState || pointerState.id !== event.pointerId) return;
  pointerState = null;
  event.currentTarget.classList.remove('is-dragging');
  window.setTimeout(() => {
    didDrag = false;
  }, 0);
}

function handleWheel(event) {
  event.preventDefault();
  const section = getSection(activeSectionId);
  const rect = event.currentTarget.getBoundingClientRect();
  if (!section || !rect.width || !rect.height) return;
  const focalPoint = {
    x: (event.clientX - rect.left) * (section.width / rect.width),
    y: (event.clientY - rect.top) * (section.height / rect.height),
  };
  zoomMap(event.deltaY < 0 ? 1.12 : 1 / 1.12, focalPoint);
}
