local g, cmd = vim.g, vim.cmd
local fn = vim.fn

g.ascii = {
  "                                                                  ",
  "                                                                  ",
  "                                                                  ",
  "                                                                  ",
  "                                                                  ",
  "  _|      _|  _|_|_|_|    _|_|    _|      _|  _|_|_|  _|      _|  ",
  "  _|_|    _|  _|        _|    _|  _|      _|    _|    _|_|  _|_|  ",
  "  _|  _|  _|  _|_|_|    _|    _|  _|      _|    _|    _|  _|  _|  ",
  "  _|    _|_|  _|        _|    _|    _|  _|      _|    _|      _|  ",
  "  _|      _|  _|_|_|_|    _|_|        _|      _|_|_|  _|      _|  ",
  "                                                                  ",
  "                                                                  ",
  "                                                                  ",
  "                                                                  ",
  "                                                                  "
}

g.startify_custom_header = "startify#center(g:ascii)"
g.startify_session_dir = '~/.config/nvim/session'
g.startify_lists = {
  { type = 'dir', header = { "         Folders" .. fn.getcwd() } },
  { type = "files", header = { "         Recent Files" } },
  { type = "sessions", header = { "         Sessions" } },
  { type = "bookmarks", header = { "         Bookmarks" } },
  { type = "commands", header = { "       גּ  Commands" } },
}

g.startify_commands = {
  { e = { "Check Vim health", ":checkhealth" } },
  { i = { "Install PLugins", ":PlugInstall" } },
  { u = { "Update Plugin", ":PlugUpdate" } },
  { c = { "Clean Plugin", ":PlugClean" } },
  { r = { "Restart LSP", ":LspRestart" } },
}

g.startify_bookmarks = {
  { v = "~/.config/nvim/init.vim" },
  { b = "~/.config/kitty/kitty.conf" },
  { s = "~/.zshrc" },
  { z = "~/.gitconfig" },
  { a = "~/.config/nvim/plugconf/" },
  { t = "~/.tmux.conf" },
  -- {d = "~/dotfiles"},
  -- {p = "~/CodeHub/playgrounds/playground.js"}
}

g.startify_session_sort = 1
g.startify_change_to_dir = 0
g.startify_session_autoload = 1
g.startify_session_delete_buffers = 0
g.startify_session_persistence = 1
g.startify_change_to_vcs_root = 1
g.startify_padding_left = 6
g.webdevicons_enable_startify = 1
g.startify_enable_special = 1
g.startify_files_number = 5
g.startify_update_oldfiles = 1
