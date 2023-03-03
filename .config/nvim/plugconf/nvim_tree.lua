-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local tree_cb = require 'nvim-tree.config'.nvim_tree_callback

require 'nvim-tree'.setup {
  hijack_netrw = true, -- Hijack netrw window on startup. prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
  auto_reload_on_write = true,
  prefer_startup_root = true,
  sync_root_with_cwd = true,
  hijack_cursor = true, -- hijack the cursor in the tree to put it at the start of the filename
  disable_netrw = true, -- disables netrw completely
  hijack_unnamed_buffer_when_opening = true,
  open_on_tab = false,
  update_cwd = false, -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  diagnostics = {
    enable = false,
  },
  update_focused_file = { -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
    enable = true,
    update_cwd = false,
    update_root = false,
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
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = false,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        folder = {
          -- arrow_open = icons.ui.ArrowOpen,
          -- arrow_closed = icons.ui.ArrowClosed,
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  view = {
    width = 30,
    adaptive_size = true,
    preserve_window_proportions = true,
    relativenumber = false,
    number = false,
    signcolumn = "no",
    mappings = {
      custom_only = false,
      list = {
        { key = "v",  cb = tree_cb("vsplit") },
        { key = "s",  cb = tree_cb("split") },
        { key = "R",  cb = tree_cb("refresh") },
        { key = "D",  cb = tree_cb("trash") },
        { key = "r",  cb = tree_cb("rename") },
        { key = "y",  cb = tree_cb("copy_name") },
        { key = "Y",  cb = tree_cb("copy_path") },
        { key = "gy", cb = tree_cb("copy_absolute_path") },
        { key = "[c", cb = tree_cb("prev_git_item") },
        { key = "]c", cb = tree_cb("next_git_item") },
        { key = "f",  action = "live_filter" },
        { key = "F",  action = "clear_live_filter" },
        { key = "x",  action = "cut" },
        { key = "c",  action = "copy" },
        { key = "p",  action = "paste" },
      },
    },
  },
  filters = {
    dotfiles = false,
    custom = { ".git$", "node_modules", '.cache', 'dist', '.dist', 'build', '.next' },
    exclude = { '.env' }
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
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
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = false,
  },
  actions = {
    expand_all = {
      max_folder_discovery = 50,
      exclude = {},
    },
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = true,
    },
    open_file = {
      quit_on_open = true,
      resize_window = true,
      window_picker = {
        enable = false,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", },
          buftype  = { "nofile", "terminal", "help", },
        }
      }
    },
    remove_file = {
      close_window = false,
    },
  }
}

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<space>f", ":NvimTreeToggle<CR>:wincmd =<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>s", ":NvimTreeFindFileToggle<CR>:wincmd =<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>r", ":NvimTreeRefresh<CR>:wincmd =<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>c", ":NvimTreeCollapse<CR>:wincmd =<CR>", opts)
