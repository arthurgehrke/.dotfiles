local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
  "                                                     ",
  "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
  "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
  "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
  "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
  "                                                     ",
}

dashboard.section.buttons.val = {
  dashboard.button("<leader>  ff", "  Find File", ":Telescope find_files<CR>"),
  dashboard.button("<leader>  fg", "  Find Word  ", ":Telescope live_grep<CR>"),
  dashboard.button("<leader>  fo", "  Recent File", ":Telescope oldfiles<CR>"),
  dashboard.button("<leader>  es", "  Settings", ":e $MYVIMRC | :cd %:p:h <CR>"),
  dashboard.button("<leader>  q ", "  Quit NVIM", ":qa<CR>"),
  dashboard.button("n", " New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("s", " Settings", ":e ~/.config/nvim<CR>"),
  dashboard.button("q", " Quit", ":qa<CR>"),
}

-- alpha
-- alpha.setup(require'alpha.themes.startify'.config)
-- dashboard
alpha.setup(dashboard.opts)
alpha.setup(require 'alpha.themes.startify'.config)


vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
