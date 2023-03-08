nnoremap <Space>r :NvimTreeRefresh<CR>
nnoremap <Space>c :NvimTreeCollapse<CR>
nnoremap <Space>s :NvimTreeFindFileToggle<CR>
nnoremap <Space>f :NvimTreeToggle<CR>

lua << EOF

local function open_nvim_tree(data)
  local IGNORED_FT = {
    "markdown",
  }

  -- buffer is a real file on the disk
  local real_file = vim.fn.filereadable(data.file) == 1

  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  -- &ft
  local filetype = vim.bo[data.buf].ft

  -- only files please
  if not real_file and not no_name then
    return
  end

  -- skip ignored filetypes
  if vim.tbl_contains(IGNORED_FT, filetype) then
    return
  end

  -- open the tree but don't focus it
  require("nvim-tree.api").tree.toggle({ focus = false })
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]
require'nvim-tree'.setup {
  sync_root_with_cwd = true,
  hijack_cursor = true, -- hijack the cursor in the tree to put it at the start of the filename
  disable_netrw = true, -- disables netrw completely
  auto_reload_on_write = true,
  hijack_netrw = true, -- Hijack netrw window on startup. prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
  auto_reload_on_write = true,
  prefer_startup_root = true,
  hijack_unnamed_buffer_when_opening = false,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  open_on_tab = false,
  update_cwd = false, -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  diagnostics = {
    enable = false,
  },
  update_focused_file = {  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
    enable = true,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd = true,
    update_root = false,
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
      show = {
        file = false,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    glyphs = {
      default = "",
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
      git = {
        unstaged = "",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "*",
        deleted = "",
        ignored = "◌",
        },
      },
    },
  },
  view = {
    adaptive_size = true,
    preserve_window_proportions = true,
    relativenumber = false,
    number = false,
    signcolumn = "no",
    mappings = {
      custom_only = false,
      list = {
        { key = "v",                        cb = tree_cb("vsplit") },
        { key = "s",                        cb = tree_cb("split") },
        { key = "R",                            cb = tree_cb("refresh") },
        { key = "D",                            cb = tree_cb("trash") },
        { key = "r",                            cb = tree_cb("rename") },
        { key = "y",                            cb = tree_cb("copy_name") },
        { key = "Y",                            cb = tree_cb("copy_path") },
        { key = "gy",                           cb = tree_cb("copy_absolute_path") },
        { key = "[c",                           cb = tree_cb("prev_git_item") },
        { key = "]c",                           cb = tree_cb("next_git_item") },
        { key = "f",                              action = "live_filter" },
        { key = "F",                              action = "clear_live_filter" },
        { key = "x",                              action = "cut" },
        { key = "c",                              action = "copy" },
        { key = "p",                              action = "paste" },
        },
      },
    },
  filters = {
    dotfiles = false,
    custom = { ".git$", "node_modules", '.cache', 'dist', '.dist', 'build', '.next' }
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
      -- restrict_above_cwd = false,
      restrict_above_cwd = true,
    },
    open_file = {
      quit_on_open = true,
      resize_window = true,
      window_picker = {
        enable = true,
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
EOF
