lua << END
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox', -- auto
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    always_divide_middle = true,
    disabled_types = { 'NvimTree' },
    ignore_focus = {
      'NvimTree'
    },
  },
  sections = {
    lualine_a = {'mode', {}},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
		lualine_x = {},
		lualine_y = {"filetype", "progress" },
		lualine_z = {"location"},
  },
	tabline = {
		lualine_a = {
			{
				"buffers",
				separator = { left = "", right = "" },
				icons_enabled = false,
				right_padding = 2,
				mode = 2,
				symbols = { alternate_file = "" },
				update_in_insert = true,
        colored = true,           -- Displays diagnostics status in color if set to true.
				always_visible = true,
				show_modified_status = true,
				disabled_buftypes = { 'nvim-tree' }, -- Hide a window if its buffer's type is disabled
				filetype_names = {
					NvimTree = 'NvimTree',
					dashboard = 'Dashboard',
					fzf = 'FZF',
					alpha = 'Alpha'
				}
			},
		},
	},
  inactive_sections = {
    lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {"location"},
  },
  extensions = { 'nvim-tree', 'symbols-outline', 'fzf' }
}
END
