lua <<EOF

local dashboard = require('dashboard')
dashboard.setup {
	config = {
		project = { enable = true, limit = 8, icon = 'your icon', label = '', action = 'Telescope find_files cwd=' },
		mru = { limit = 10, icon = 'your icon', label = '', },
		footer = {}, -- footer
    packages = { enable = true }, -- show how many plugins neovim loaded
		-- change_to_vcs_root = true,
		theme = 'hyper',
		week_header = {
			enable = false,
		},
		shortcut = {
			{
        action = 'PlugUpdate',
        desc = ' Update',
        group = '@property',
        icon = '⥀',
        key = 'u',
			},
			{
				action = 'Files',
				desc = 'Files',
				group = 'Label',
				icon = ' ',
				icon_hl = '@variable',
				key = 'ff',
			},
		},
	},
}
EOF
let g:dashboard_change_to_dir=1
