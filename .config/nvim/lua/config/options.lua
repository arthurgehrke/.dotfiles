vim.opt.autowrite = true
vim.o.redrawtime = 100
vim.opt.shortmess:append('FcSs')
vim.opt.whichwrap:append('<>hl')
vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.clipboard = { 'unnamedplus' }
vim.opt.breakindent = true
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.signcolumn = 'yes:1'
vim.opt.cursorline = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.showmatch = false
vim.opt.matchpairs = '(:),{:},[:],<:>'
vim.opt.smartcase = true
vim.opt.infercase = true
vim.opt.ignorecase = true
vim.opt.incsearch = true

vim.o.hlsearch = not vim.o.hlsearch

vim.opt.number = true
vim.opt.numberwidth = 4

vim.opt.hidden = true
vim.o.showmode = true
vim.o.ruler = true

local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand('~/.config')

vim.opt.undofile = true
vim.opt.undodir = prefix .. '/nvim/undodir'
vim.opt.backupdir = { prefix .. '/nvim/backup//' }
vim.opt.directory = { prefix .. '/nvim/swap//' }
vim.opt.history = 1000
vim.opt.swapfile = false
vim.opt.undoreload = 10000
vim.o.writebackup = false
vim.opt.undolevels = 10000
vim.opt.backup = false
vim.o.fileformats = 'unix'
vim.opt.wrap = false
vim.o.wildignorecase = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.wildmenu = true
vim.o.wildignore = '*.o,*.obj,*~,*.so,*.swp,*.DS_Store,\'*/cache/*\', \'*/tmp/*\''
vim.o.showfulltag = true
vim.opt.errorformat:prepend('%f|%l col %c|%m')
vim.opt.autoread = true
vim.o.ttimeoutlen = 10
vim.o.updatetime = 250
vim.opt.showcmd = false
vim.opt.cmdheight = 0
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert', 'preview' }
vim.o.autoindent = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.scrolloff = 5
vim.o.sidescroll = 1
vim.o.sidescrolloff = 10
vim.o.emoji = false
vim.opt.encoding = 'utf-8'
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.foldmethod = 'manual'
vim.opt.foldenable = false
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.opt.mouse = 'a'
vim.opt.list = true
vim.opt.clipboard = 'unnamedplus'
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_matchit = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.vim_json_conceal = 0
vim.g.markdown_syntax_conceal = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
