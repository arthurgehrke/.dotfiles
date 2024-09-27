vim.opt.autowrite = true
vim.opt.conceallevel = 2
-- vim.opt.textwidth = 120

-- Faster scrolling
vim.o.lazyredraw = true
-- Decrease redraw time
vim.o.redrawtime = 100

-- shortmess is used to avoid excessive messages
vim.opt.shortmess = vim.opt.shortmess + { c = true }

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append('<>hl')

-- Disable search count res from the bottom right corner
vim.opt.shortmess:append('S')

-- Disable ins-completion-menu messages
vim.opt.shortmess:append('c')

-- Wrap long lines at a blank
vim.o.linebreak = true

vim.o.showbreak = '⤿ '
vim.opt.clipboard = { 'unnamedplus' }
vim.opt.breakindent = true

vim.opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}

if vim.fn.has('nvim-0.10') == 1 then
  vim.opt.smoothscroll = true
end

vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.grepprg = 'rg --vimgrep'

-- gutter sizing
vim.opt.signcolumn = 'yes:1'

-- vim.opt.virtualedit = 'block'

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.showmatch = false
vim.opt.matchpairs = '(:),{:},[:],<:>'
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

vim.o.showmode = true

vim.o.ruler = true
vim.opt.cursorline = true

local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand('~/.config')
vim.opt.undofile = true
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.backupdir = { prefix .. '/nvim/.backup//' }
vim.opt.directory = { prefix .. '/nvim/.swp//' }

vim.opt.history = 1000 --> cmd history depth
vim.opt.swapfile = false
vim.opt.undoreload = 10000 --> number of lines to save for undo
vim.o.writebackup = false
vim.opt.undolevels = 10000
vim.opt.backup = false -- overwrites previous backups instead of making new one

vim.o.fileformats = 'mac,unix,dos'
vim.opt.wrap = false
-- vim.o.whichwrap = "b,s,<,>,[,]"
-- vim.opt.whichwrap = "b,s"

vim.o.wildignorecase = true
vim.o.wildignore = "*.o,*.obj,*~,*.so,*.swp,*.DS_Store,'*/cache/*', '*/tmp/*'" -- stuff to ignore when tab completing
vim.o.showfulltag = true

vim.opt.errorformat:prepend('%f|%l col %c|%m')

vim.opt.autoread = true
vim.o.ttimeoutlen = 50
vim.o.updatetime = 250

vim.opt.showcmd = false
vim.opt.cmdheight = 1
vim.opt.laststatus = 2

-- completeopt is used to manage code suggestions
-- menuone: show popup even when there is only one suggestion
-- noinsert: Only insert text when selection is confirmed
-- noselect: force us to select one from the suggestions
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert', 'preview' }

vim.o.infercase = true -- ignore case on insert completion

vim.o.autoindent = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.scrolloff = 5
vim.o.sidescroll = 1 -- zh zl
vim.o.sidescrolloff = 10

vim.o.emoji = false

vim.opt.encoding = 'utf-8'
vim.opt.lazyredraw = true

-- no bells
vim.opt.errorbells = false
vim.opt.visualbell = false

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.opt.foldnestmax = 10
-- vim.opt.foldlevelstart = 10
-- vim.opt.foldlevel = 2
-- vim.opt.foldlevel = 999
vim.opt.foldenable = false

vim.opt.termguicolors = true
vim.opt.background = 'dark'

vim.opt.mouse = 'a'
vim.opt.list = true

vim.opt.listchars = { eol = nil, trail = '~', tab = '  ', nbsp = '␣' }

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_matchit = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
-- vim.g.loaded_2html_plugin = 1
-- vim.g.loaded_sql_completion = 1
-- vim.g.loaded_spec = 1
vim.g.vim_json_conceal = 0

-- ripgrep
vim.opt.rtp:append('/opt/homebrew/opt/fzf')

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  float = { border = 'rounded' },
  underline = true,
  update_in_insert = true,
  severty_sort = true,
})

-- Use nerd font for gutter signs
local signs = { Error = 'E', Warn = 'W', Hint = 'H', Info = 'I' }
-- local signs = { Error = '󰅚', Warn = '󰀪', Hint = '󰌶', Info = '󰋽' }

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.g.loaded_perl_provider = 0
vim.g.ruby_host_prog = '/usr/bin/ruby'
vim.g.python3_host_prog = '/Users/arthurgehrke/.pyenv'

if os.getenv('TERM') == 'alacritty' then
  vim.o.ttymouse = 'sgr'
end

if vim.env.TERM == 'alacritty' then
  vim.opt.ttymouse = 'sgr'
end
