lua << END
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'material',
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {'progress'},
    lualine_z = {'encoding', 'fileformat', 'filetype'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fzf', 'nvim-tree'}
}
END
