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
    lualine_b = { { 'filename', path = 3 } },
    lualine_c = { 'diagnostics' },
    lualine_x = {'encoding', {'fileformat', symbols = {
        unix = '', -- e712
        dos = '',  -- e70f
        mac = '',  -- e711
    }}, 'filetype'},
    -- lualine_x = {'encoding', {'fileformat', icons_enabled = false}, 'filetype'},
    lualine_y = { '' },
    lualine_z = { 'filetype' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
		-- lualine_c = {'filename'},
		lualine_c = {},
		lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = { 'nvim-tree', 'symbols-outline' }
}
END
