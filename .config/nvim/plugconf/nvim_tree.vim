let g:nvim_tree_icons = {
\ 'default': '',
\ 'symlink': '',
\ 'git': {
\   'unstaged': '',
\   'staged': "✓",
\   'unmerged': "",
\   'renamed': "➜",
\   'untracked': "U",
\   'deleted': "",
\   'ignored': "◌"
\   },
\ 'folder': {
\   'arrow_open': "",
\   'arrow_closed': "",
\   'default': "",
\   'open': "",
\   'empty': "",
\   'empty_open': "",
\   'symlink': "",
\   'symlink_open': "",
\   }
\ }

let g:nvim_tree_show_icons = {
\ 'git': 1,
\ 'folders': 1,
\ 'files': 0,
\ 'folder_arrows': 1,
\ }

let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file

nnoremap <Space>f :NvimTreeToggle<CR>
nnoremap <Space>r :NvimTreeRefresh<CR>
nnoremap <Space>c :NvimTreeFindFile<CR>

set termguicolors
highlight NvimTreeFolderIcon guibg=blue

lua << EOF
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup {
  indent_markers = 1, -- this option shows indent markers when folders are open

  disable_netrw = true, -- disables netrw completely
  hijack_netrw = true, -- Hijack netrw window on startup. prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
  hijack_cursor = false, -- hijack the cursor in the tree to put it at the start of the filename
  auto_close = true,
  open_on_setup = true,
  open_on_tab = true,
  update_cwd = false, -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_to_buf_dir = { -- hijacks new directory buffers when they are opened
    enable = false,
    auto_open = false
  },
  diagnostics = {
    enable = false,
  },
  update_focused_file = {  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
    enable = true,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  view = {
    side = 'left',
    width = 45,
    height = 30,
    number = false,
    auto_resize = true,
    relativenumber = false,
    signcolumn = "no",
    mappings = {
      custom_only = false,
      list = {
        { key = "v",                        cb = tree_cb("vsplit") },
        { key = "V",                        cb = tree_cb("split") },
        { key = "R",                            cb = tree_cb("refresh") },
        { key = "D",                            cb = tree_cb("trash") },
        { key = "r",                            cb = tree_cb("rename") },
        { key = "y",                            cb = tree_cb("copy_name") },
        { key = "Y",                            cb = tree_cb("copy_path") },
        { key = "gy",                           cb = tree_cb("copy_absolute_path") },
        { key = "[c",                           cb = tree_cb("prev_git_item") },
        { key = "]c",                           cb = tree_cb("next_git_item") },
        },
    },
  },
  filters = {
    dotfiles = false,
    custom = { ".git", "node_modules", '.cache', 'dist', '.dist', 'build' }
  }
}
local opts = {silent = true, noremap = true}
EOF
