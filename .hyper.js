"use strict";
module.exports = {
  config: {
    updateChannel: "stable",
    fontSize: 13.5,
    fontFamily:
      'MesloLGS NF, MesloLGS Nerd Font Mono, MesloLGS Nerd Font, Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
    fontWeight: "normal",
    fontWeightBold: "bold",
    letterSpacing: 0, // offset.x ~ 1 no Alacritty ≈ letterSpacing pequeno
    lineHeight: 1.0,
    letterSpacing: 1.0,
    cursorShape: "BLOCK", // 'BEAM' | 'UNDERLINE' | 'BLOCK'
    cursorBlink: false, // blinking = Off
    cursorColor: "#ebdbb2", // colors.cursor.cursor
    cursorAccentColor: "#282828",

    foregroundColor: "#ebdbb2",
    backgroundColor: "#282828",
    selectionColor: "rgba(235, 219, 178, 0.99)", // colors.selection.background
    borderColor: "#282828",
    colors: {
      black: "#282828",
      red: "#cc241d",
      green: "#98971a",
      yellow: "#d79921",
      blue: "#458588",
      magenta: "#b16286",
      cyan: "#689d6a",
      white: "#a89984",
      lightBlack: "#928374",
      lightRed: "#fb4934",
      lightGreen: "#b8bb26",
      lightYellow: "#fabd2f",
      lightBlue: "#83a598",
      lightMagenta: "#d3869b",
      lightCyan: "#8ec07c",
      lightWhite: "#ebdbb2",
    },
    css: "",
    termCSS: "",
    workingDirectory: "",
    showHamburgerMenu: "",
    showWindowControls: "",
    padding: '0.5px 0.5px',      // window.padding {x:1,y:1}
    modifierKeys: { altIsMeta: true },
    colors: {
      black: "#000000",
      red: "#C51E14",
      green: "#1DC121",
      yellow: "#C7C329",
      blue: "#0A2FC4",
      magenta: "#C839C5",
      cyan: "#20C5C6",
      white: "#C7C7C7",
      lightBlack: "#686868",
      lightRed: "#FD6F6B",
      lightGreen: "#67F86F",
      lightYellow: "#FFFA72",
      lightBlue: "#6A76FB",
      lightMagenta: "#FD7CFC",
      lightCyan: "#68FDFE",
      lightWhite: "#FFFFFF",
      limeGreen: "#32CD32",
      lightCoral: "#F08080",
    },
    shell: "/bin/zsh",
    shellArgs: ["--login"],
    env: {
      TERM: "xterm-256color",
    },
    env: {},
    bell: "false",
    copyOnSelect: true,

    scrollback: 100000, // scrolling.history
    defaultSSHApp: true,
    quickEdit: false,
    macOptionSelectionMode: "vertical",
    webGLRenderer: true,
    webLinksActivationKey: "",
    disableLigatures: true,
    disableAutoUpdates: false,
    screenReaderMode: false,
    preserveCWD: true,
  },
  plugins: [],
  localPlugins: [],
  keymaps: {
  },
};
