return {
  "nvim-tree/nvim-tree.lua",
  lazy = true,
  event = "VeryLazy",
  keys = {
    { '<leader>f', ':NvimTreeFindFileToggle<CR>', silent = true },
  },
  cmd = 'NvimTreeOpen',
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = function()
    local icons = require("lazyvim.config").icons
    local tree_cb = require('nvim-tree.config').nvim_tree_callback

    return {
      auto_reload_on_write = true,
      create_in_closed_folder = false,
      disable_netrw = false,
      hijack_cursor = true,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = true,
      ignore_buffer_on_setup = false,
      open_on_setup = false,
      open_on_setup_file = false,
      open_on_tab = false,
      respect_buf_cwd = false,
      sync_root_with_cwd = true,
      notify = {
        threshold = vim.log.levels.WARN,
      },
      update_focused_file = {
        enable = true,
        update_cwd = false,
        update_root = false,
        ignore_list = {},
      },
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = false,
      },
      view = {
        adaptive_size = true,
        centralize_selection = false,
        width = 30,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "no",
        hide_root_folder = false,
        mappings = {
          custom_only = false,
          list = {
            {key = {'<s>'},          cb = tree_cb('split')},
            {key = {'<v>'},          cb = tree_cb('vsplit')},
            {key = {'R'},              cb = tree_cb('refresh')},
            {key = {'a'},              cb = tree_cb('create')},
            {key = {'d'},              cb = tree_cb('remove')},
            {key = {'r'},              cb = tree_cb('full_rename')},
            {key = {'x'},              cb = tree_cb('cut')},
            {key = {'c'},              cb = tree_cb('copy')},
            {key = {'p'},              cb = tree_cb('paste')},
            {key = {'q'},              cb = tree_cb('close')},
            {key = {'W'},              cb = tree_cb('collapse_all')},
            {key = {'f'},              cb = tree_cb('live_filter')},
            {key = {'F'},              cb = tree_cb('clear_live_filter')},
            {key = {'-'},              cb = tree_cb('dir_up')},
          }
        }},
      diagnostics = {
        enable = false
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
        },
        open_file = {
          quit_on_open = false,
          resize_window = false,
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = false,
        },
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
      filters = {
        dotfiles = false,
        custom = { ".git$", "node_modules", '.cache', 'dist', '.dist', 'build', '.next' },
        exclude = { ".env" },
      },
      renderer = {
        add_trailing = true,
        group_empty = true,
        highlight_git = true,
        full_name = true,
        highlight_opened_files = "none",
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "CMakeLists.txt" },
        symlink_destination = true,
        indent_markers = {
          enable = true,
          icons = {
            corner = "└ ",
            edge = "│ ",
            item = "│ ",
            none = "  ",
          },
        },
        icons = {
          webdev_colors = true,
          git_placement = "before",
          padding = " ",
          symlink_arrow = "  ",
          show = {
            file = false,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            git = {
              unstaged = "",
              staged = "",
              unmerged = "",
              renamed = "",
              untracked = "",
              deleted = "",
              ignored = "",
            },
            folder = {
              arrow_open = "",
              arrow_closed = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
          },
        },
      },
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      ignore_ft_on_setup = {},
    }
  end
}
