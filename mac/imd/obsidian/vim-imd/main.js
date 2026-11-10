const { Plugin, MarkdownView } = require("obsidian");
const fs = require("fs");

// Talks to ~/.local/bin/imd (tools repo: mac/imd) directly through files: no child process,
// so a switch takes a few ms.
const IS_MAC = process.platform === "darwin";
const uid = IS_MAC ? process.getuid() : 0;
const FIFO = `/tmp/imd-${uid}.fifo`;
const CURRENT = `/tmp/imd-${uid}.current`;
const NORMAL_IM = "com.apple.keylayout.ABC";

module.exports = class VimImd extends Plugin {
  onload() {
    if (!IS_MAC) return;
    this.active = true;
    this.imToRestore = "";
    this.prevMode = "normal";
    this.lastSent = "";
    this.lastSentAt = -Infinity;
    this.editors = new WeakSet();

    const hookAll = () =>
      this.app.workspace.iterateAllLeaves((leaf) => {
        if (leaf.view instanceof MarkdownView) this.hookEditor(leaf.view);
      });
    this.app.workspace.onLayoutReady(hookAll);
    this.registerEvent(this.app.workspace.on("active-leaf-change", hookAll));
    this.registerEvent(this.app.workspace.on("file-open", hookAll));
  }

  onunload() {
    // CodeMirror listeners can't be removed individually; mute them instead.
    this.active = false;
  }

  hookEditor(view) {
    const cm = view.sourceMode?.cmEditor?.cm?.cm;
    if (!cm || this.editors.has(cm)) return;
    this.editors.add(cm);
    cm.on("vim-mode-change", (modeObj) => {
      if (this.active && modeObj) this.onModeChange(modeObj.mode);
    });
  }

  onModeChange(mode) {
    if (mode === "insert") {
      if (this.prevMode !== "insert" && this.imToRestore) this.send(this.imToRestore);
    } else if (this.prevMode === "insert") {
      // Read before switching, synchronously, so a quick re-entry restores the right source.
      this.imToRestore = this.readCurrent();
      this.send(NORMAL_IM);
    }
    this.prevMode = mode;
  }

  readCurrent() {
    // imd may not have applied a switch we just sent; trust our own request for a moment.
    if (performance.now() - this.lastSentAt < 50) return this.lastSent;
    try {
      return fs.readFileSync(CURRENT, "utf8").trim();
    } catch {
      return "";
    }
  }

  send(id) {
    this.lastSent = id;
    this.lastSentAt = performance.now();
    try {
      // O_RDWR never blocks on a FIFO, even if imd is down; ENOENT means imd isn't installed here.
      const fd = fs.openSync(FIFO, fs.constants.O_RDWR | fs.constants.O_NONBLOCK);
      fs.writeSync(fd, `${id}\n`);
      fs.closeSync(fd);
    } catch {}
  }
};
