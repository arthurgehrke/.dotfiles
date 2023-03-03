vim.g.startify_files_number = 8
vim.g.startify_change_to_dir = 1
vim.g.startify_update_oldfiles = 1
vim.g.startify_session_autoload = 1
vim.g.startify_session_persistence = 1
vim.g.startify_session_delete_buffers = 1
vim.g.startify_change_to_vcs_root = 0

vim.g["startify_lists"] = {
  { type = "dir",       header = { ("   Current Directory " .. vim.fn.getcwd()) } },
  { type = "sessions",  header = { "   Sessions" } },
  { type = "bookmarks", header = { "   Bookmarks" } },
  { type = "files",     header = { "   Files" } },
}

vim.g["startify_bookmarks"] = {
  { i = "~/.config/nvim" },
  { p = "~/repositories/doare" },
}
