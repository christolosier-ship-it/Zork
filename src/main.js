import { ZMachine } from 'zmachine';
import { DIRECTIONS, GAMES, QUICK_COMMANDS, getGame } from './catalog.js';
import {
  deleteSave,
  formatSaveDate,
  hasSave,
  loadSettings,
  saveSettings,
} from './storage.js';
import { ZorkIOAdapter } from './zork-io.js';
import './style.css';

class ZorkApp {
  constructor() {
    this.settings = loadSettings();
    this.currentGame = null;
    this.machine = null;
    this.io = null;
    this.readyForCommand = false;
    this.commandHistory = [];
    this.historyIndex = 0;
    this.commandCount = 0;
    this.installPrompt = null;
    this.confirmResolver = null;
    this.toastTimer = null;
    this.didAutoResume = false;

    this.elements = {
      library: document.querySelector('#library-view'),
      player: document.querySelector('#player-view'),
      gameGrid: document.querySelector('#game-grid'),
      gameSwitch: document.querySelector('#game-switch'),
      volumeSwitcher: document.querySelector('#volume-switcher'),
      dossier: document.querySelector('#game-dossier'),
      dossierNumber: document.querySelector('#dossier-number'),
      dossierTitle: document.querySelector('#dossier-title'),
      dossierSubtitle: document.querySelector('#dossier-subtitle'),
      dossierDescription: document.querySelector('#dossier-description'),
      editionNote: document.querySelector('#edition-note'),
      saveStatus: document.querySelector('#save-status'),
      restoreButton: document.querySelector('#restore-button'),
      output: document.querySelector('#game-output'),
      input: document.querySelector('#command-input'),
      commandForm: document.querySelector('#command-form'),
      status: document.querySelector('#status-line'),
      engineVersion: document.querySelector('#engine-version'),
      terminalState: document.querySelector('#terminal-state-label'),
      quickCommands: document.querySelector('#quick-commands'),
      compass: document.querySelector('#compass'),
      playAssist: document.querySelector('#play-assist'),
      fieldGuide: document.querySelector('.field-guide'),
      networkStatus: document.querySelector('#network-status'),
      settingsDialog: document.querySelector('#settings-dialog'),
      settingsForm: document.querySelector('#settings-form'),
      saveManagement: document.querySelector('#save-management-list'),
      aboutDialog: document.querySelector('#about-dialog'),
      installDialog: document.querySelector('#install-dialog'),
      confirmDialog: document.querySelector('#confirm-dialog'),
      confirmTitle: document.querySelector('#confirm-title'),
      confirmMessage: document.querySelector('#confirm-message'),
      toast: document.querySelector('#toast'),
    };
  }

  init() {
    this.applySettings();
    this.renderLibrary();
    this.renderPlayerControls();
    this.populateGameSwitcher();
    this.renderSaveManagement();
    this.bindEvents();
    this.setupInstallPrompt();
    this.updateNetworkStatus();
    this.registerServiceWorker();

    const params = new URLSearchParams(window.location.search);
    const selectedGame = getGame(params.get('game'));
    this.shouldAutoResume = params.get('resume') === '1';

    if (selectedGame) {
      this.openPlayer(selectedGame);
    } else {
      this.openLibrary();
    }

    requestAnimationFrame(() => document.body.classList.add('is-ready'));
  }

  bindEvents() {
    document.addEventListener('click', (event) => {
      const closeButton = event.target.closest('[data-close-dialog]');
      if (closeButton) {
        closeButton.closest('dialog')?.close();
        return;
      }

      const confirmButton = event.target.closest('[data-confirm]');
      if (confirmButton) {
        const accepted = confirmButton.dataset.confirm === 'accept';
        this.resolveConfirmation(accepted);
        return;
      }

      const deleteButton = event.target.closest('[data-delete-save]');
      if (deleteButton) {
        void this.requestDeleteSave(deleteButton.dataset.deleteSave);
        return;
      }

      const resumeButton = event.target.closest('[data-resume]');
      if (resumeButton) {
        this.navigateToGame(resumeButton.dataset.resume, true);
        return;
      }

      const gameButton = event.target.closest('[data-game]');
      if (gameButton) {
        this.navigateToGame(gameButton.dataset.game, false);
        return;
      }

      const commandButton = event.target.closest('[data-command]');
      if (commandButton) {
        this.submitCommand(commandButton.dataset.command);
        return;
      }

      const actionButton = event.target.closest('[data-action]');
      if (actionButton) {
        void this.handleAction(actionButton.dataset.action);
      }
    });

    this.elements.commandForm.addEventListener('submit', (event) => {
      event.preventDefault();
      const command = this.elements.input.value.trim();
      if (command) this.dispatchInput();
    });

    this.elements.input.addEventListener('keydown', (event) => {
      if (event.key === 'ArrowUp') {
        event.preventDefault();
        this.recallCommand(-1);
      }

      if (event.key === 'ArrowDown') {
        event.preventDefault();
        this.recallCommand(1);
      }
    });

    this.elements.gameSwitch.addEventListener('change', () => {
      const gameId = this.elements.gameSwitch.value;
      if (gameId !== this.currentGame?.id) void this.requestGameSwitch(gameId);
    });

    this.elements.settingsForm.addEventListener('change', () => {
      const form = this.elements.settingsForm;
      const formData = new FormData(form);
      this.settings = {
        theme: formData.get('theme') ?? 'archive',
        fontSize: formData.get('fontSize') ?? 'medium',
        reducedMotion: form.elements.reducedMotion.checked,
        showHints: form.elements.showHints.checked,
      };
      saveSettings(this.settings);
      this.applySettings();
    });

    window.addEventListener('online', () => this.updateNetworkStatus());
    window.addEventListener('offline', () => this.updateNetworkStatus());

    for (const dialog of document.querySelectorAll('dialog')) {
      dialog.addEventListener('click', (event) => {
        if (event.target === dialog && dialog !== this.elements.confirmDialog) dialog.close();
      });
    }

    this.elements.confirmDialog.addEventListener('cancel', (event) => {
      event.preventDefault();
      this.resolveConfirmation(false);
    });
  }

  async handleAction(action) {
    switch (action) {
      case 'home':
        await this.requestHome();
        break;
      case 'settings':
        this.syncSettingsForm();
        this.renderSaveManagement();
        this.elements.settingsDialog.showModal();
        break;
      case 'about':
        if (this.elements.settingsDialog.open) this.elements.settingsDialog.close();
        this.elements.aboutDialog.showModal();
        break;
      case 'install':
        await this.installApp();
        break;
      case 'restart':
        await this.requestRestart();
        break;
      case 'transcript':
        this.downloadTranscript();
        break;
      case 'help':
        this.showGameHelp();
        break;
      default:
        break;
    }
  }

  renderLibrary() {
    this.elements.gameGrid.innerHTML = GAMES.map((game, index) => {
      const saveDate = formatSaveDate(game.id);
      const saved = Boolean(saveDate);

      return `
        <article class="game-card game-card--${game.motif}" style="--card-accent: ${game.accent}; --card-accent-rgb: ${game.accentRgb}">
          <div class="card-index">0${index + 1}</div>
          <div class="game-art" aria-hidden="true">
            <div class="art-frame">
              <span class="art-symbol"></span>
              <span class="art-horizon"></span>
            </div>
            <span class="art-volume">${game.numeral}</span>
          </div>
          <div class="game-card-copy">
            <p class="card-eyebrow">${game.eyebrow}</p>
            <h3>${game.title}</h3>
            <p class="card-subtitle">${game.subtitle}</p>
            <p class="card-description">${game.description}</p>
            <div class="card-meta">
              <span>Z-Machine v3</span>
              <span>${game.release}</span>
            </div>
          </div>
          <div class="card-actions">
            <button class="primary-card-button" type="button" data-game="${game.id}">
              ${saved ? 'Nouvelle partie' : 'Ouvrir le volume'} <span aria-hidden="true">→</span>
            </button>
            ${
              saved
                ? `<button class="resume-card-button" type="button" data-resume="${game.id}">
                    <svg aria-hidden="true"><use href="#icon-restore"></use></svg>
                    Reprendre <small>${saveDate}</small>
                  </button>`
                : ''
            }
          </div>
        </article>
      `;
    }).join('');
  }

  renderPlayerControls() {
    this.elements.quickCommands.innerHTML = `
      <span class="assist-label">Commandes rapides</span>
      <div class="quick-command-grid">
        ${QUICK_COMMANDS.map(
          (item) => `
            <button type="button" ${item.action ? `data-action="${item.action}"` : `data-command="${item.command}" disabled`}>
              <span class="quick-command-code">${item.shortLabel.slice(0, 2).toUpperCase()}</span>
              <span>${item.label}<small>${(item.command ?? 'guide').toUpperCase()}</small></span>
            </button>
          `,
        ).join('')}
      </div>
    `;

    this.elements.compass.innerHTML = DIRECTIONS.map(
      (direction) => `
        <button
          type="button"
          data-command="${direction.command}"
          aria-label="${direction.label}"
          title="${direction.label} · ${direction.command.toUpperCase()}"
          style="grid-area: ${direction.cell}"
          disabled
        >${direction.glyph}</button>
      `,
    ).join('');
  }

  populateGameSwitcher() {
    this.elements.gameSwitch.innerHTML = GAMES.map(
      (game) => `<option value="${game.id}">${game.title} · ${game.subtitle}</option>`,
    ).join('');
  }

  openLibrary() {
    document.body.classList.remove('is-playing');
    this.elements.library.hidden = false;
    this.elements.player.hidden = true;
    this.elements.volumeSwitcher.hidden = true;
    document.title = 'Zork — La trilogie interactive';
  }

  openPlayer(game) {
    this.currentGame = game;
    document.body.classList.add('is-playing');
    this.elements.library.hidden = true;
    this.elements.player.hidden = false;
    this.elements.volumeSwitcher.hidden = false;
    this.elements.gameSwitch.value = game.id;
    this.elements.dossierNumber.textContent = game.numeral;
    this.elements.dossierTitle.textContent = game.title;
    this.elements.dossierSubtitle.textContent = game.subtitle;
    this.elements.dossierDescription.textContent = game.description;
    this.elements.editionNote.textContent = `${game.release} · Traduction des sources MIT`;
    this.elements.player.style.setProperty('--game-accent', game.accent);
    this.elements.player.style.setProperty('--game-accent-rgb', game.accentRgb);
    document.title = `${game.title} — ${game.subtitle}`;
    this.updateSaveState();
    void this.loadGame(game);
  }

  async loadGame(game) {
    this.setTerminalState('Chargement', false);
    this.elements.output.innerHTML = '<span class="loading-line">Ouverture des archives…</span>';

    try {
      const response = await fetch(game.file);
      if (!response.ok) throw new Error(`Fichier de jeu inaccessible (${response.status})`);

      const storyData = await response.arrayBuffer();
      if (new Uint8Array(storyData)[0] !== 3) {
        throw new Error('Le fichier chargé n’est pas un programme Z-Machine v3 valide.');
      }

      this.io = new ZorkIOAdapter({
        gameId: game.id,
        outputElement: this.elements.output,
        inputElement: this.elements.input,
        statusElement: this.elements.status,
        onCommand: (command) => this.onCommand(command),
        onReady: (ready) => this.setReadyForCommand(ready),
        onSave: (record) => this.onSave(record),
        onRestore: (restored) => this.onRestore(restored),
        onStatus: (status) => this.onGameStatus(status),
        onQuit: () => this.setTerminalState('Partie terminée', false),
        onRestart: () => {
          this.commandHistory = [];
          this.historyIndex = 0;
          this.commandCount = 0;
          this.showToast('La partie recommence.');
        },
      });

      this.machine = ZMachine.load(storyData, this.io);
      this.io.initialize(this.machine.version);
      this.io.setOutputStream(2, true);
      this.elements.engineVersion.textContent = `v${this.machine.version}`;

      void this.machine.run().catch((error) => this.showGameError(error));
    } catch (error) {
      this.showGameError(error);
    }
  }

  showGameError(error) {
    console.error(error);
    this.readyForCommand = false;
    this.elements.input.disabled = true;
    this.elements.output.innerHTML = `
      <div class="game-error">
        <strong>Impossible d’ouvrir ce volume.</strong>
        <span>${error instanceof Error ? error.message : 'Erreur inconnue'}</span>
        <button type="button" data-action="restart">Réessayer</button>
      </div>
    `;
    this.setTerminalState('Archive indisponible', false);
  }

  setReadyForCommand(ready) {
    this.readyForCommand = ready;
    this.elements.input.disabled = !ready;
    this.setTerminalState(ready ? 'À votre écoute' : 'Interprétation', ready);
    this.updateCommandButtons();

    if (ready) {
      this.refreshStatusLine();

      if (window.matchMedia('(pointer: coarse)').matches) {
        window.setTimeout(() => this.elements.input.blur(), 0);
      }

      if (this.shouldAutoResume && !this.didAutoResume && hasSave(this.currentGame.id)) {
        this.didAutoResume = true;
        window.setTimeout(() => this.submitCommand('reprendre'), 120);
      }
    }
  }

  refreshStatusLine() {
    if (!this.machine || !this.io) return;

    try {
      const locationObject = this.machine.variables.load(16);
      const location = locationObject ? this.machine.getObjectName(locationObject) : 'Lieu inconnu';
      const rawScore = this.machine.variables.load(17);
      const scoreOrHours = rawScore & 0x8000 ? rawScore - 0x10000 : rawScore;
      const turnsOrMinutes = this.machine.variables.load(18);
      const isTime = Boolean(this.machine.header.flags1 & 0x02);
      this.io.showStatusLine(location, scoreOrHours, turnsOrMinutes, isTime);
    } catch (error) {
      console.warn('Barre d’état indisponible :', error);
    }
  }

  setTerminalState(label, active) {
    this.elements.terminalState.textContent = label;
    this.elements.terminalState.closest('.terminal-state')?.classList.toggle('is-active', active);
  }

  onCommand(command) {
    const cleanCommand = command.trim();
    if (!cleanCommand) return;
    this.commandHistory.push(cleanCommand);
    this.historyIndex = this.commandHistory.length;
    this.commandCount += 1;
  }

  onSave(record) {
    if (record) {
      this.showToast('Progression sauvegardée sur cet appareil.');
      this.updateSaveState();
      this.renderLibrary();
      this.renderSaveManagement();
    } else {
      this.showToast('La sauvegarde a échoué.', 'error');
    }
  }

  onRestore(restored) {
    this.showToast(
      restored ? 'Sauvegarde restaurée.' : 'Aucune sauvegarde disponible pour ce volume.',
      restored ? 'success' : 'error',
    );
  }

  onGameStatus(status) {
    this.elements.status.setAttribute(
      'aria-label',
      status.isTime
        ? `${status.location}, ${status.scoreOrHours} heures ${status.turnsOrMinutes}`
        : `${status.location}, score ${status.scoreOrHours}, ${status.turnsOrMinutes} coups`,
    );
  }

  submitCommand(command) {
    if (!this.readyForCommand) {
      this.showToast('Le jeu termine son action précédente.');
      return;
    }

    this.elements.input.value = command;
    this.dispatchInput();
  }

  dispatchInput() {
    this.elements.input.dispatchEvent(
      new KeyboardEvent('keydown', {
        key: 'Enter',
        code: 'Enter',
        bubbles: true,
        cancelable: true,
      }),
    );
  }

  recallCommand(direction) {
    if (!this.commandHistory.length) return;
    this.historyIndex = Math.max(
      0,
      Math.min(this.commandHistory.length, this.historyIndex + direction),
    );
    this.elements.input.value = this.commandHistory[this.historyIndex] ?? '';
    window.requestAnimationFrame(() => {
      this.elements.input.setSelectionRange(
        this.elements.input.value.length,
        this.elements.input.value.length,
      );
    });
  }

  updateCommandButtons() {
    for (const button of document.querySelectorAll('[data-command]')) {
      const needsSave = button.dataset.command === 'reprendre';
      button.disabled = !this.readyForCommand || (needsSave && !hasSave(this.currentGame?.id));
    }
  }

  updateSaveState() {
    if (!this.currentGame) return;
    const saveDate = formatSaveDate(this.currentGame.id);
    this.elements.saveStatus.textContent = saveDate ? `Sauvegardé le ${saveDate}` : 'Aucune sauvegarde';
    this.elements.restoreButton.disabled = !saveDate || !this.readyForCommand;
  }

  renderSaveManagement() {
    this.elements.saveManagement.innerHTML = GAMES.map((game) => {
      const date = formatSaveDate(game.id);
      return `
        <div class="managed-save">
          <span class="managed-save-volume">${game.numeral}</span>
          <div><strong>${game.title}</strong><small>${date ?? 'Aucune sauvegarde'}</small></div>
          <button type="button" data-delete-save="${game.id}" ${date ? '' : 'disabled'} aria-label="Supprimer la sauvegarde ${game.title}">
            <svg aria-hidden="true"><use href="#icon-trash"></use></svg>
          </button>
        </div>
      `;
    }).join('');
  }

  async requestDeleteSave(gameId) {
    const game = getGame(gameId);
    if (!game || !hasSave(gameId)) return;
    const accepted = await this.confirm({
      title: `Effacer la sauvegarde de ${game.title} ?`,
      message: 'Cette progression locale sera définitivement supprimée.',
      acceptLabel: 'Effacer',
    });
    if (!accepted) return;
    deleteSave(gameId);
    this.renderSaveManagement();
    this.renderLibrary();
    this.updateSaveState();
    this.updateCommandButtons();
    this.showToast('Sauvegarde supprimée.');
  }

  async requestHome() {
    if (!this.currentGame) return;
    if (this.commandCount > 0) {
      const accepted = await this.confirm({
        title: 'Revenir à la trilogie ?',
        message: 'La partie en cours sera abandonnée. Utilisez « Sauvegarder » avant de partir pour conserver votre progression.',
        acceptLabel: 'Quitter la partie',
      });
      if (!accepted) return;
    }
    const url = new URL(window.location.href);
    url.search = '';
    window.location.assign(url);
  }

  async requestGameSwitch(gameId) {
    const game = getGame(gameId);
    if (!game) return;
    const accepted =
      this.commandCount === 0 ||
      (await this.confirm({
        title: `Passer à ${game.title} ?`,
        message: 'La partie actuelle sera abandonnée si elle n’a pas été sauvegardée.',
        acceptLabel: 'Changer de volume',
      }));
    if (accepted) this.navigateToGame(gameId, false);
    else this.elements.gameSwitch.value = this.currentGame.id;
  }

  async requestRestart() {
    if (!this.currentGame) return;
    const accepted = await this.confirm({
      title: `Recommencer ${this.currentGame.title} ?`,
      message: 'La session actuelle repartira du début. Votre sauvegarde locale ne sera pas effacée.',
      acceptLabel: 'Recommencer',
    });
    if (!accepted) return;

    const url = new URL(window.location.href);
    url.search = '';
    url.searchParams.set('game', this.currentGame.id);
    window.history.replaceState({}, '', url);
    window.location.reload();
  }

  navigateToGame(gameId, resume) {
    const url = new URL(window.location.href);
    url.search = '';
    url.searchParams.set('game', gameId);
    if (resume) url.searchParams.set('resume', '1');
    window.location.assign(url);
  }

  confirm({ title, message, acceptLabel }) {
    this.elements.confirmTitle.textContent = title;
    this.elements.confirmMessage.textContent = message;
    this.elements.confirmDialog.querySelector('[data-confirm="accept"]').textContent = acceptLabel;
    this.elements.confirmDialog.showModal();

    return new Promise((resolve) => {
      this.confirmResolver = resolve;
    });
  }

  resolveConfirmation(accepted) {
    this.elements.confirmDialog.close();
    this.confirmResolver?.(accepted);
    this.confirmResolver = null;
  }

  downloadTranscript() {
    if (!this.io || !this.currentGame) return;
    const transcript = this.io.getTranscript();
    if (!transcript.trim()) {
      this.showToast('Le récit est encore vide.');
      return;
    }

    const header = `${this.currentGame.title} — ${this.currentGame.subtitle}\n${new Date().toLocaleString('fr-FR')}\n${'—'.repeat(56)}\n\n`;
    const blob = new Blob([header, transcript], { type: 'text/plain;charset=utf-8' });
    const link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = `${this.currentGame.id}-recit-${new Date().toISOString().slice(0, 10)}.txt`;
    link.click();
    URL.revokeObjectURL(link.href);
    this.showToast('Récit exporté.');
  }

  showGameHelp() {
    if (!this.elements.fieldGuide) return;
    this.elements.fieldGuide.open = true;
    this.elements.fieldGuide.scrollIntoView({ behavior: 'smooth', block: 'center' });
    this.showToast('Le guide de terrain est ouvert.');
  }

  applySettings() {
    const root = document.documentElement;
    root.dataset.theme = this.settings.theme;
    root.dataset.fontSize = this.settings.fontSize;
    root.classList.toggle('reduce-motion', this.settings.reducedMotion);
    this.elements.playAssist.hidden = !this.settings.showHints;
    document.querySelector('meta[name="theme-color"]').content =
      this.settings.theme === 'midnight' ? '#11131a' : '#0c1512';
  }

  syncSettingsForm() {
    const form = this.elements.settingsForm;
    form.elements.theme.value = this.settings.theme;
    form.elements.fontSize.value = this.settings.fontSize;
    form.elements.reducedMotion.checked = this.settings.reducedMotion;
    form.elements.showHints.checked = this.settings.showHints;
  }

  showToast(message, type = 'success') {
    window.clearTimeout(this.toastTimer);
    this.elements.toast.textContent = message;
    this.elements.toast.dataset.type = type;
    this.elements.toast.classList.add('is-visible');
    this.toastTimer = window.setTimeout(() => {
      this.elements.toast.classList.remove('is-visible');
    }, 3200);
  }

  updateNetworkStatus() {
    const online = navigator.onLine;
    this.elements.networkStatus.classList.toggle('is-offline', !online);
    this.elements.networkStatus.querySelector('.network-label').textContent = online
      ? 'En ligne'
      : 'Hors ligne';
  }

  setupInstallPrompt() {
    window.addEventListener('beforeinstallprompt', (event) => {
      event.preventDefault();
      this.installPrompt = event;
      document.body.classList.add('can-install');
    });

    window.addEventListener('appinstalled', () => {
      this.installPrompt = null;
      document.body.classList.remove('can-install');
      this.showToast('Zork est installé. Bonne exploration.');
    });
  }

  async installApp() {
    if (this.installPrompt) {
      this.installPrompt.prompt();
      await this.installPrompt.userChoice;
      this.installPrompt = null;
      document.body.classList.remove('can-install');
      return;
    }

    this.elements.installDialog.showModal();
  }

  async registerServiceWorker() {
    if (!('serviceWorker' in navigator) || !import.meta.env.PROD) return;
    try {
      await navigator.serviceWorker.register('./sw.js', { scope: './' });
    } catch (error) {
      console.warn('Service worker non enregistré :', error);
    }
  }
}

const app = new ZorkApp();
app.init();
