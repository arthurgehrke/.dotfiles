autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif

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

set termguicolors
let g:nvim_tree_show_icons = {
\ 'git': 1,
\ 'folders': 1,
\ 'files': 0,
\ 'folder_arrows': 1,
\ }

nnoremap <Space>f :NvimTreeToggle<CR>
nnoremap <Space>r :NvimTreeRefresh<CR>
nnoremap <Space>c :NvimTreeFindFile<CR>

lua << EOF
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup {
  disable_netrw = true, -- disables netrw completely
  auto_reload_on_write = true,
  hijack_netrw = true, -- Hijack netrw window on startup. prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
  hijack_cursor = false, -- hijack the cursor in the tree to put it at the start of the filename
  auto_reload_on_write = true,
  hijack_unnamed_buffer_when_opening = true,
  hijack_directories = {
    enable = true,
    auto_open = false,
  },
  open_on_setup = true,
  open_on_tab = false,
  update_cwd = false, -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  diagnostics = {
    enable = false,
  },
  update_focused_file = {  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
    enable = true,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd = false,
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  renderer = {
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
        },
      },
    icons = {
      webdev_colors = true,
      },
    },
  view = {
    side = 'left',
    width = 40,
    height = 30,
    preserve_window_proportions = false,
    relativenumber = false,
    number = false,
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
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
      },
    },
  actions = {
    change_dir = {
      enable = false,
      global = false,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = true,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", },
          buftype  = { "nofile", "terminal", "help", },
        }
      }
    }
  }
}
local opts = { silent = true, noremap = true }
EOF
