vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- -- Use lazy.nvim for plugin management
require("config.lazy")
require("config.options")
-- require("config.colorscheme")
require("config.keymaps")
require("config.autocmds")
