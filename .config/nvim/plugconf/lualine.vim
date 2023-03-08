lua << END
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    always_divide_middle = true,
    disabled_types = { 'NvimTree' },
    ignore_focus = {
      'NvimTree'
      },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      'branch', 
      {
          'diff',
          -- color = { bg = 'grey', }
          colored = false, 
      },
      'diagnostics',
    },
		lualine_c = {'filename', {'diff', symbols = {added = '烙', modified = ' ', removed = ' '}}},
    lualine_x = {'encoding', {'fileformat', icons_enabled = false}, 'filetype'},
    lualine_y = {'progress'},
		lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = { 'nvim-tree', 'symbols-outline' }
}
END
