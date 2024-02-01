lua << END
local status, lualine = pcall(require, "lualine")
if (not status) then return end
-- https://github.com/kuntau/dotfiles/blob/develop/config/nvim/lua/config/plugins/statusline.lua
-- StatusLine, bufferline & tabline configs
-- could be any of powerline, windline, lualine, airline or lightline

require('lualine').setup {
  options = {
    icons_enabled = true,
    -- theme = 'auto',
    theme = 'gruvbox',
    section_separators = '', 
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    -- disabled_filetypes = {
    --   statusline = { 'NvimTree' },
    --   winbar = { 'NvimTree' },
    -- },

    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { { 'filename', path = 3 } },
    lualine_c = { 'diagnostics' },
    lualine_x = {},
    lualine_y = { '' },
    lualine_z = { 'filetype' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    -- lualine_x = { 'location' },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

require('lualine').hide({
  place = {'statusline', 'tabline', 'winbar', 'NvimTree'}, -- The segment this change applies to.
  unhide = false,  -- whether to re-enable lualine again/
})
END
