local cache_dir = vim.env.HOME .. '/.cache/nvim/'

vim.o.formatexpr = 'v:lua.require"conform".formatexpr()'

-- vim.opt.list = true
-- Reserve space for diagnostic icons
vim.opt.signcolumn = 'yes' -- always show sign column; prevent shifting
vim.opt.shortmess:append({ c = true })
vim.opt.shortmess:append('c')
-- stop anoying messages
vim.opt.shortmess:append({ c = true })

vim.opt.clipboard = 'unnamedplus'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.infercase = true

vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
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

vim.opt.completeopt = 'menuone,noinsert,noselect'

vim.opt.autoread = true
vim.opt.cmdheight = 1
vim.opt.showcmd = false

vim.opt.showmode = false
vim.opt.showmatch = true
vim.opt.ruler = true
vim.opt.cursorline = true

-- Remove vim temporary files
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.undofile = true
vim.opt.undodir = cache_dir .. 'undo/'
vim.opt.backupdir = cache_dir .. 'backup/'
vim.opt.viewdir = cache_dir .. 'view/'

-- make backspace behave in a sane manner
vim.opt.backspace = 'indent,eol,start'

-- Encoding configurations
vim.opt.encoding = 'utf-8'
vim.opt.fileencodings = 'utf-8'
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99

vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0

vim.g.python3_host_prog = '/opt/homebrew/bin/python3'

-- disable netrw (nvim-tree conflicts)
vim.g.loaded_netrw = 1
vim.g.netrw_silent = 1
vim.g.loaded_netrwPlugin = 1

-- formatting
vim.opt.formatoptions:append({ r = true, o = false, l = true })

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
vim.opt.wildignorecase = true

vim.cmd([[ set guicursor= ]])
vim.cmd([[ syntax on ]])
vim.cmd([[autocmd FileType * set formatoptions-=ro]]) --dont add comments on lines above

-- Disable unused providers
vim.g.loaded_netrwPlugin = 1
-- netrw
vim.g.nvim_tree_disable_netrw = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.loaded_matchparen = 1
-- vim.g.netrw_winsize = 25

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0

vim.diagnostic.config({
  virtual_text = false,
  float = { header = '', prefix = '', focusable = false },
  update_in_insert = true,
  severity_sort = true,
})

-- remember cursor position
vim.api.nvim_create_autocmd('BufRead', {
  callback = function(opts)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
          not (ft:match('commit') and ft:match('rebase'))
          and last_known_line > 1
          and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], 'nx', false)
        end
      end,
    })
  end,
})

vim.cmd('au ColorScheme * hi clear SignColumn')
