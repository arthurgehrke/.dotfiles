
-- Reserve space for diagnostic icons
vim.opt.signcolumn = "yes"          -- always show sign column; prevent shifting
vim.opt.isfname:append("@-@")

vim.o.splitright = true
vim.o.splitbelow = true
vim.o.showmatch = true
vim.opt.smartcase = true
vim.opt.infercase = true

vim.o.ignorecase = true
vim.opt.incsearch = true
vim.o.hlsearch = false
vim.opt.scrolloff=2

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4

vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
vim.o.hidden = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 50
vim.opt.ttimeoutlen = 50

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.lazyredraw = true           -- faster scrolling

-- verificar
vim.o.pumheight = 10
-- vim.opt.ruler = false
vim.opt.foldcolumn = "0"

-- stop anoying messages
vim.opt.shortmess:append {c = true}

vim.o.cmdheight = 1
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.showmatch = true
vim.opt.ruler = true
vim.opt.cursorline = true

-- Remove vim temporary files
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.wrap = false

-- make backspace behave in a sane manner
vim.opt.backspace = "indent,eol,start"

-- Encoding configurations
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8"
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.g.python3_host_prog = "/usr/bin/python3" -- Optional, for python3 support

vim.opt.clipboard = "unnamedplus" -- Share X winows clipboard with vim

-- disable netrw (nvim-tree conflicts)
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- formatting
vim.opt.formatoptions:append { r = true, o = true, l = true }

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

vim.cmd([[ set guicursor= ]])
vim.cmd([[ syntax on ]])
vim.cmd([[autocmd FileType * set formatoptions-=ro]]) --dont add comments on lines above

vim.opt.list = true

-- Disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_matchparen = 1 

vim.opt.fillchars = {
  -- Characters to be used in various user-interface elements.
  stl = ' ', -- Status-line of the current window.
  stlnc = ' ', -- Status-line of the non-current windows.
  vert = ' ', -- Vertical separator to be used with :vsplit.
  fold = ' ', -- Character to be used with 'foldtext'.
  diff = '╱', -- Deleted lines of the 'diff' option.
  msgsep = '─', -- Message separator for 'display' option.
  eob = ' ', -- Empty lines at the end of a buffer.
}

local function visual_paste_without_yank()
  vim.fn.setreg('x', vim.fn.getreg('*'))
  vim.api.nvim_paste(vim.fn.getreg('*'), {}, -1)
  vim.fn.setreg('*', vim.fn.getreg('x'))
end

vim.keymap.set('v', 'p', visual_paste_without_yank, { noremap = true, silent = true })

vim.g.nvim_tree_disable_netrw = 0
-- netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.cmd('au ColorScheme * hi clear SignColumn')

local function visual_paste_without_yank()
  vim.fn.setreg('x', vim.fn.getreg('*'))
  vim.api.nvim_paste(vim.fn.getreg('*'), {}, -1)
  vim.fn.setreg('*', vim.fn.getreg('x'))
end

vim.keymap.set('v', 'p', visual_paste_without_yank, { noremap = true, silent = true })

vim.g.nvim_tree_disable_netrw = 0
-- netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.opt.diffopt = { -- Option settings for diff mode.
  'filler', -- Show filler lines.
  'vertical', -- Start diff mode with vertical splits.
  'algorithm:histogram', -- Use the specified diff algorithm.
}
