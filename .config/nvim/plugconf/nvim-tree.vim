lua << EOF

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.api.nvim_set_hl(0, "NormalFloat", {
  fg = "none",
  bg = "none",
})

local signcolumn_width = 7 -- AKA gutter width
local min_buffer_width = 110 + signcolumn_width
local total_dual_panel_cols = min_buffer_width * 2 + 1
local min_sidebar_width = 10
local max_sidebar_width = 32

-- vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]
local get_sidebar_cols = function()
    local neovim_cols = vim.o.columns
    local sidebar_cols = neovim_cols - min_buffer_width - 1
    if total_dual_panel_cols < (neovim_cols - min_sidebar_width) then
        sidebar_cols = neovim_cols - total_dual_panel_cols - 1
    end
    if sidebar_cols < min_sidebar_width then
        sidebar_cols = min_sidebar_width
    end
    if sidebar_cols > max_sidebar_width then
        sidebar_cols = max_sidebar_width
    end
    return sidebar_cols
end

local find_buffer = function(buffer_name)
    for _, buf in pairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_get_name(buf):find(buffer_name, 1, true) then
            return buf
        end
    end
    return nil
end

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

   vim.keymap.set('n', '<C-d>', api.tree.change_root_to_node,          opts('CD'))
   vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))
   vim.keymap.set('n', '<C-k>', api.node.show_info_popup,              opts('Info'))
   vim.keymap.set('n', '<C-r>', api.fs.rename_sub,                     opts('Rename: Omit Filename'))
   vim.keymap.set('n', '<C-v>', api.node.open.vertical,                opts('Open: Vertical Split'))
   vim.keymap.set('n', '<C-s>', api.node.open.horizontal,              opts('Open: Horizontal Split'))
   vim.keymap.set('n', '<BS>',  api.node.navigate.parent_close,        opts('Close Directory'))
   vim.keymap.set('n', '<CR>',  api.node.open.edit,                    opts('Open'))
   vim.keymap.set('n', '.',     api.node.run.cmd,                      opts('Run Command'))
   vim.keymap.set('n', '-',     api.tree.change_root_to_parent,        opts('Up'))
   vim.keymap.set('n', 'a',     api.fs.create,                         opts('Create'))
   vim.keymap.set('n', 'c',     api.fs.copy.node,                      opts('Copy'))
   vim.keymap.set('n', 'C',     api.tree.toggle_git_clean_filter,      opts('Toggle Git Clean'))
   vim.keymap.set('n', '[c',    api.node.navigate.git.prev,            opts('Prev Git'))
   vim.keymap.set('n', ']c',    api.node.navigate.git.next,            opts('Next Git'))
   vim.keymap.set('n', 'd',     api.fs.remove,                         opts('Delete'))
   vim.keymap.set('n', 'D',     api.fs.trash,                          opts('Trash'))
   vim.keymap.set('n', 'E',     api.tree.expand_all,                   opts('Expand All'))
   vim.keymap.set('n', 'e',     api.fs.rename_basename,                opts('Rename: Basename'))
   vim.keymap.set('n', ']e',    api.node.navigate.diagnostics.next,    opts('Next Diagnostic'))
   vim.keymap.set('n', '[e',    api.node.navigate.diagnostics.prev,    opts('Prev Diagnostic'))
   vim.keymap.set('n', 'F',     api.live_filter.clear,                 opts('Clean Filter'))
   vim.keymap.set('n', 'f',     api.live_filter.start,                 opts('Filter'))
   vim.keymap.set('n', 'g?',    api.tree.toggle_help,                  opts('Help'))
   vim.keymap.set('n', 'gy',    api.fs.copy.absolute_path,             opts('Copy Absolute Path'))
   vim.keymap.set('n', 'H',     api.tree.toggle_hidden_filter,         opts('Toggle Dotfiles'))
   vim.keymap.set('n', 'I',     api.tree.toggle_gitignore_filter,      opts('Toggle Git Ignore'))
   vim.keymap.set('n', 'J',     api.node.navigate.sibling.last,        opts('Last Sibling'))
   vim.keymap.set('n', 'K',     api.node.navigate.sibling.first,       opts('First Sibling'))
   vim.keymap.set('n', 'o',     api.node.open.edit,                    opts('Open'))
   vim.keymap.set('n', 'O',     api.node.open.no_window_picker,        opts('Open: No Window Picker'))
   vim.keymap.set('n', 'p',     api.fs.paste,                          opts('Paste'))
   vim.keymap.set('n', 'P',     api.node.navigate.parent,              opts('Parent Directory'))
   vim.keymap.set('n', 'q',     api.tree.close,                        opts('Close'))
   vim.keymap.set('n', 'r',     api.fs.rename,                         opts('Rename'))
   vim.keymap.set('n', 'R',     api.tree.reload,                       opts('Refresh'))
   -- vim.keymap.set('n', 's',     api.node.run.system,                   opts('Run System')) -- open external fcking program
   vim.keymap.set('n', 'S',     api.tree.search_node,                  opts('Search'))
   vim.keymap.set('n', 'U',     api.tree.toggle_custom_filter,         opts('Toggle Hidden'))
   vim.keymap.set('n', 'W',     api.tree.collapse_all,                 opts('Collapse'))
   vim.keymap.set('n', 'x',     api.fs.cut,                            opts('Cut'))
   vim.keymap.set('n', 'y',     api.fs.copy.filename,                  opts('Copy Name'))
   vim.keymap.set('n', 'Y',     api.fs.copy.relative_path,             opts('Copy Relative Path'))
end

require'nvim-tree'.setup {
   on_attach = on_attach,
   sync_root_with_cwd = false,
   auto_reload_on_write = true,
   reload_on_bufenter = false,
   disable_netrw = false,
   hijack_cursor = true,
   hijack_netrw = true,
   prefer_startup_root = true,
   open_on_tab = false,
   update_cwd = false, -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
   on_attach = on_attach,
   reload_on_bufenter = true,
   diagnostics = {
      enable = false,
      show_on_dirs = false,
      show_on_open_dirs = false,
      debounce_delay = 50,
   },
   update_focused_file = {  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
      enable = true,
      update_cwd = false,
      update_root = false,
      ignore_list = {},
   },
   git = {
      enable = true,
      ignore = false,
      timeout = 500,
   },
   filesystem_watchers = {
     enable = true,
     debounce_delay = 50,
     ignore_dirs = {
       "node_modules"
     },
   },
   git = {
     enable = true,
     show_on_dirs = true,
     show_on_open_dirs = true,
     disable_for_dirs = {},
     timeout = 400,
   },
   renderer = {
     symlink_destination = false,
     indent_markers = {
       enable = false,
       inline_arrows = true,
       icons = {
         corner = " ",
         edge = " ",
         item = "┊",
         bottom = "",
         none = " ",
       },
     },
      icons = {
        web_devicons = {
          file = {
            enable = true,
            color = true,
          },
          folder = {
            enable = false,
            color = true,
          },
        },
        git_placement = "before",
        modified_placement = "after",
        webdev_colors = true,
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
          modified = true,
          diagnostics = false,
          bookmarks = false,
        },
         glyphs = {
            default = "",
            symlink = "",
            bookmark = "󰆤",
            modified = "●",
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
      preserve_window_proportions = false,
      debounce_delay = 15,
      relativenumber = false,
      adaptive_size = true,
      number = false,
      signcolumn = "auto",
      width = get_sidebar_cols(),
      float = {
        enable = false
      },
   },
   filters = {
      git_ignored = false,
      dotfiles = false,
      git_clean = false,
      no_buffer = false,
      custom = { "node_modules", 'dist', '.dist', '.next' }, -- ".git$"
      exclude = { "tmp", "logs"  } -- "node_modules"
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
      always_show_folders = true
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
         restrict_above_cwd = false,
      },
      open_file = {
         quit_on_open = true,
         eject = true,
         resize_window = false,
         window_picker = {
           enable = true,
           picker = "default",
           chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
           exclude = {
             filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
             buftype = { "nofile", "terminal", "help", "diff" },
           },
         },
      },
      remove_file = {
         close_window = false,
      },
   },
   hijack_directories = {
     enable = true,
     auto_open = true,
   },
}

require'nvim-web-devicons'.setup({
   default = true
})

local nvim_tree_api = require('nvim-tree.api')

-- local function open_nvim_tree()
--   require("nvim-tree.api").tree.toggle({ focus = false })
-- end

vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd "quit"
    end
  end
})
EOF

nnoremap <Space>r :NvimTreeRefresh<CR>
nnoremap <Space>c :NvimTreeCollapse<CR>
" nnoremap <Space>f :NvimTreeToggle<CR>
nnoremap <Space>f :NvimTreeFindFileToggle<CR>
