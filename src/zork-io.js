import { WebIOAdapter } from 'zmachine/web';
import { translateFrenchCommand } from './french-commands.js';
import { readSave, storeSave } from './storage.js';
import './zork1-map.js';

export class ZorkIOAdapter extends WebIOAdapter {
  constructor({ gameId, onCommand, onReady, onSave, onRestore, onStatus, ...config }) {
    super(config);
    this.gameId = gameId;
    this.inputElement = config.inputElement;
    this.onCommand = onCommand;
    this.onReady = onReady;
    this.onSave = onSave;
    this.onRestore = onRestore;
    this.onStatus = onStatus;
  }

  async readLine(maxLength, timeout) {
    this.onReady?.(true);
    this.inputElement.focus();
    this.inputElement.maxLength = maxLength;

    // Zork v3 dessine déjà son propre prompt. Le WebIOAdapter générique en
    // ajoute un second ; on conserve ici sa gestion asynchrone sans ce doublon.
    const result = await new Promise((resolve) => {
      this.lineResolve = resolve;

      if (timeout && timeout > 0) {
        const timeoutMs = timeout * 100;
        window.setTimeout(() => {
          if (this.lineResolve === resolve) {
            const text = this.inputElement.value;
            this.inputElement.value = '';
            this.lineResolve = undefined;
            resolve({ text, terminator: 0 });
          }
        }, timeoutMs);
      }
    });

    this.onReady?.(false);
    this.onCommand?.(result.text);
    return { ...result, text: translateFrenchCommand(result.text, this.gameId) };
  }

  showStatusLine(location, scoreOrHours, turnsOrMinutes, isTime) {
    if (!this.status) return;
    const rightSide = isTime
      ? `Heure : ${scoreOrHours}:${turnsOrMinutes.toString().padStart(2, '0')}`
      : `Score : ${scoreOrHours}  Coups : ${turnsOrMinutes}`;
    this.status.innerHTML = `
      <span class="location">${this.escapeHtml(location)}</span>
      <span class="score">${rightSide}</span>
    `;
    this.onStatus?.({ location, scoreOrHours, turnsOrMinutes, isTime });
  }

  async save(data) {
    try {
      const record = storeSave(this.gameId, data);
      this.onSave?.(record);
      return true;
    } catch {
      this.onSave?.(null);
      return false;
    }
  }

  async restore() {
    try {
      const data = readSave(this.gameId);
      this.onRestore?.(Boolean(data));
      return data;
    } catch {
      this.onRestore?.(false);
      return null;
    }
  }
}
