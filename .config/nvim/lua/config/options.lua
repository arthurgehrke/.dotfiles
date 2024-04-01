vim.opt.clipboard = { 'unnamedplus' }

-- gutter sizing
vim.opt.signcolumn = 'yes:1'

-- vim.opt.virtualedit = 'block'

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.infercase = true

vim.opt.ignorecase = true
vim.opt.incsearch = true

vim.o.hlsearch = not vim.o.hlsearch

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4

vim.opt.hidden = true

--vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.completeopt = 'menu,menuone,noselect'

vim.o.showmode = true

vim.o.ruler = true
vim.opt.cursorline = true

vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.writebackup = false
vim.opt.backup = false
vim.opt.wrap = false
vim.opt.undofile = true

vim.o.undodir = vim.fn.stdpath('cache') .. '/undoes'
vim.o.fileformats = 'unix,dos,mac'

vim.opt.autoread = true
vim.o.ttimeoutlen = 50
vim.o.updatetime = 50
vim.o.showcmd = false
vim.opt.cmdheight = 1
vim.o.laststatus = 2

vim.opt.completeopt = 'menuone,noinsert,noselect'

vim.o.autoindent = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.scrolloff = 5
vim.o.sidescroll = 1 -- zh zl
vim.o.sidescrolloff = 10

vim.o.emoji = false

-- Turn on the filetype plugin
vim.opt.filetype = 'on'

vim.opt.encoding = 'utf-8'
vim.opt.lazyredraw = true

-- no bells
vim.opt.errorbells = false
vim.opt.visualbell = false

vim.opt.foldlevel = 999
vim.opt.termguicolors = true
vim.o.background = 'dark' -- or "light" for light mode

vim.opt.mouse = 'a'
vim.opt.list = true

vim.opt.listchars = { eol = nil, trail = '~', tab = '  ', nbsp = '␣' }

vim.g.loaded_perl_provider = 0
vim.g.python3_host_prog = '/Users/arthurgehrke/.pyenv/shims/python'
vim.env.PYENV_VERSION = vim.fn.system('pyenv version'):match('(%S+)%s+%(.-%)')
vim.g.ruby_host_prog = '/usr/bin/ruby'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchparen = 1

vim.diagnostic.config({
  virtual_text = false,
  float = { header = '', prefix = '', focusable = false },
  update_in_insert = false,
  severity_sort = true,
  signs = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  underline = {
    severity = { min = vim.diagnostic.severity.HINT },
  },
})

-- Use nerd font for gutter signs
local signs = { Error = "󰅚", Warn = "󰀪", Hint = "󰌶", Info = "󰋽" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
