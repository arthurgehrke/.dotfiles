vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
local fn = vim.fn

-- opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
-- opt.formatoptions = "jcroqlnt" -- tcqj
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 0
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
-- opt.scrolloff = 4 -- Lines of context
-- opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "auto" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.spelllang = { "en" }
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.undofile = true
opt.undodir = fn.stdpath("data") .. "undo"
opt.shell = "/bin/zsh"
opt.writebackup = false
opt.backup = false
opt.swapfile = false

-- Shorter messages
vim.opt.shortmess:append("c")
-- opt.shortmess:append { W = true, I = true, c = true }

-- Indent Settings
opt.shiftwidth = 4 -- Size of an indent
opt.expandtab = true -- Use spaces instead of tabs
opt.tabstop = 4 -- Number of spaces tabs count for
opt.smartindent = true -- Insert indents automatically
opt.softtabstop = 4
opt.wrap = false -- Disable line wrap

-- Line Numbers
opt.number = true
opt.relativenumber = true

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Prefer ripgrep if it exists
if fn.executable("rg") > 0 then
  -- opt.grepprg = "rg --hidden --glob '!.git' --no-heading --smart-case --vimgrep --follow $*"
 -- opt.grepformat = "%f:%l:%c:%m"
  opt.grepprg = "rg --vimgrep"
end

