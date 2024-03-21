local cache_dir = vim.env.HOME .. '/.cache/nvim/'
vim.api.nvim_set_hl(0, 'YankyPut', {})
vim.api.nvim_set_hl(0, 'YankyYanked', {})
vim.api.nvim_set_hl(0, 'HighlightYank', {})
vim.api.nvim_set_hl(0, 'TextYankPos', {})
vim.api.nvim_set_hl(0, '@lsp.type.comment.cpp', {})
vim.api.nvim_set_hl(0, '@lsp.type.comment', { sp = '' })
vim.api.nvim_set_hl(0, '@lsp.type.namespace', {})
vim.api.nvim_set_hl(0, '@lsp.type.parameter', {})
vim.api.nvim_set_hl(0, '@lsp.type.property', {})
vim.api.nvim_set_hl(0, '@lsp.type.typeParameter', {})
vim.api.nvim_set_hl(0, '@lsp.type.variable', {})

vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank()]])

-- `,<cr>` clears highlights
vim.api.nvim_set_keymap("", "<leader><cr>", ":noh<cr>", { silent = true })

-- Disable the worst feature of vim
vim.api.nvim_set_keymap("", "q:", "", { noremap = true })
vim.api.nvim_set_keymap("", "q/", "", { noremap = true })
vim.api.nvim_set_keymap("", "q?", "", { noremap = true })


vim.opt.shell = '/bin/zsh'
-- vim.opt.formatexpr = 'v:lua.require"conform".formatexpr()'
vim.opt.shiftwidth = 2

vim.opt.background = "dark"
vim.opt.termguicolors = true

-- vim.opt.list = true
-- Reserve space for diagnostic icons
vim.opt.signcolumn = 'yes' -- always show sign column; prevent shifting
-- stop anoying messages
vim.opt.shortmess:append({ c = true })
vim.opt.syntax = "enable"
-- vim.opt.clipboard = "unnamedplus"

if vim.fn.executable "xclip" == 1 then
  vim.g.clipboard = {
    copy = {
      ["+"] = "xclip -selection clipboard",
      ["*"] = "xclip -selection clipboard",
    },
    paste = {
      ["+"] = "xclip -selection clipboard -o",
      ["*"] = "xclip -selection clipboard -o",
    },
  }
elseif vim.fn.executable "xsel" == 1 then
  vim.g.clipboard = {
    copy = {
      ["+"] = "xsel --clipboard --input",
      ["*"] = "xsel --clipboard --input",
    },
    paste = {
      ["+"] = "xsel --clipboard --output",
      ["*"] = "xsel --clipboard --output",
    },
  }
end

vim.opt.clipboard = "unnamedplus"


vim.opt.mouse = "a"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.infercase = true

vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4

vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 50
vim.opt.ttimeoutlen = 50

vim.opt.pumheight = 15
-- vim.opt.pumheight = 10
-- vim.opt.ruler = false
vim.opt.foldcolumn = '0'

vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }

vim.opt.autoread = true
vim.opt.cmdheight = 1
vim.opt.showcmd = false

vim.opt.showmode = false
vim.opt.showmatch = false
vim.opt.ruler = true
vim.opt.cursorline = true
vim.g.noswapfile = true
vim.g.nobackup = true

-- Remove vim temporary files
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.undofile = true
vim.opt.undodir = cache_dir .. 'undo/'
vim.opt.backupdir = cache_dir .. 'backup/'

-- make backspace behave in a sane manner
vim.opt.backspace = 'indent,eol,start'

-- Encoding configurations
vim.opt.encoding = 'utf-8'
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99

-- disable netrw (nvim-tree conflicts)

-- formatting
-- vim.opt.formatoptions:append({ r = true, o = false, l = true })

-- spell check is annoying
vim.opt.spell = false

-- no bells
vim.opt.errorbells = false
vim.opt.visualbell = false

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.history = 1000
-- vim.opt.wildignorecase = true

-- vim.cmd([[ set guicursor= ]])
-- vim.cmd([[ syntax on ]])
-- vim.cmd([[autocmd FileType * set formatoptions-=ro]]) --dont add comments on lines above

-- Disable unused providers
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrw = 1
-- netrw
-- vim.g.nvim_tree_disable_netrw = 0
-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
local disable_plugins = {
  'loaded_gzip',
  'loaded_shada_plugin',
  'loadedzip',
  'loaded_spellfile_plugin',
  'loaded_tutor_mode_plugin',
  'loaded_tar',
  'loaded_tarPlugin',
  'loaded_zip',
  'loaded_zipPlugin',
  'loaded_rrhelper',
  'loaded_2html_plugin',
  'loaded_vimball',
  'loaded_vimballPlugin',
  'loaded_getscript',
  'loaded_getscriptPlugin',
  'loaded_matchparen',
  'loaded_matchit',
  'loaded_man',
  'loaded_netrw',
  'loaded_netrwPlugin',
  'loaded_netrwSettings',
  'loaded_netrwFileHandlers',
  'loaded_logiPat',
  'loaded_remote_plugins',
  'did_load_ftplugin',
  'did_indent_on',
  'did_install_default_menus',
  'did_install_syntax_menu',
  'skip_loading_mswin',
}

for _, name in pairs(disable_plugins) do
  vim.g[name] = 1
end

vim.g.minipairs_disable = true
vim.g.python3_host_prog = '/usr/bin/python3'
-- vim.g.netrw_winsize = 25
-- vim.g.loaded_perl_provider = 0
-- vim.g.loaded_python_provider = 0
-- vim.g.loaded_ruby_provider = 0
-- vim.g.loaded_node_provider = 0
-- vim.g.loaded_node_provider = 0
-- vim.g.loaded_python3_provider = 0

-- remember cursor position

vim.cmd('au ColorScheme * hi clear SignColumn')
-- vim.cmd('highlight CursorLineNr guibg=none guifg=none')
