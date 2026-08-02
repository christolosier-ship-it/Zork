import { WebIOAdapter } from 'zmachine/web';
import { readSave, storeSave } from './storage.js';

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
    return result;
  }

  showStatusLine(location, scoreOrHours, turnsOrMinutes, isTime) {
    super.showStatusLine(location, scoreOrHours, turnsOrMinutes, isTime);
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
