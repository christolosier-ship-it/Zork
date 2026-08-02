const SETTINGS_KEY = 'zork-pwa-settings-v1';
const SAVE_PREFIX = 'zork-pwa-save-';

export const DEFAULT_SETTINGS = Object.freeze({
  theme: 'archive',
  fontSize: 'medium',
  reducedMotion: false,
  showHints: true,
});

export function loadSettings() {
  try {
    const stored = JSON.parse(localStorage.getItem(SETTINGS_KEY) ?? '{}');
    return { ...DEFAULT_SETTINGS, ...stored };
  } catch {
    return { ...DEFAULT_SETTINGS };
  }
}

export function saveSettings(settings) {
  localStorage.setItem(SETTINGS_KEY, JSON.stringify(settings));
}

export function getSaveKey(gameId) {
  return `${SAVE_PREFIX}${gameId}`;
}

export function getSaveRecord(gameId) {
  try {
    return JSON.parse(localStorage.getItem(getSaveKey(gameId)) ?? 'null');
  } catch {
    return null;
  }
}

export function hasSave(gameId) {
  return Boolean(getSaveRecord(gameId)?.data);
}

export function storeSave(gameId, data) {
  const record = {
    version: 1,
    gameId,
    savedAt: new Date().toISOString(),
    data: uint8ToBase64(data),
  };

  localStorage.setItem(getSaveKey(gameId), JSON.stringify(record));
  return record;
}

export function readSave(gameId) {
  const record = getSaveRecord(gameId);
  return record?.data ? base64ToUint8(record.data) : null;
}

export function deleteSave(gameId) {
  localStorage.removeItem(getSaveKey(gameId));
}

export function formatSaveDate(gameId) {
  const record = getSaveRecord(gameId);
  if (!record?.savedAt) return null;

  return new Intl.DateTimeFormat('fr-FR', {
    dateStyle: 'medium',
    timeStyle: 'short',
  }).format(new Date(record.savedAt));
}

function uint8ToBase64(data) {
  const chunkSize = 0x8000;
  let binary = '';

  for (let index = 0; index < data.length; index += chunkSize) {
    binary += String.fromCharCode(...data.subarray(index, index + chunkSize));
  }

  return btoa(binary);
}

function base64ToUint8(base64) {
  const binary = atob(base64);
  const data = new Uint8Array(binary.length);

  for (let index = 0; index < binary.length; index += 1) {
    data[index] = binary.charCodeAt(index);
  }

  return data;
}
