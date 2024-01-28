lua <<EOF
local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

bufferline.setup({
options = {
  mode = "buffers",
  themable = false,
  theme = 'gruvbox',
  -- style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
  mode = "buffers",
  indicator = {
    icon = '|', -- this should be omitted if indicator style is not 'icon'
    style = 'none',
  },
  separator_style = 'thin',
  always_show_bufferline = true,
  show_buffer_icons = false,
  show_buffer_close_icons = false,
  show_close_icon = false,
  color_icons = false,
  -- offsets = {
  --   {
  --       filetype = "NvimTree",
  --       text = "File Explorer",
  --         text_align = "left",
  --         separator = true
  --   },
  -- },
offsets = {
			{
				filetype = "NvimTree",
				text = function()
					-- return "File Explorer"
					-- git symbolic-ref --short -q HEAD
					-- git --no-pager rev-parse --show-toplevel --absolute-git-dir --abbrev-ref HEAD
					-- git --no-pager rev-parse --short HEAD
					-- local b = vim.fn.trim(vim.fn.system("git symbolic-ref --short -q HEAD"))
					-- if string.match(b, "fatal") then
					-- 	b = ""
					-- else
					-- 	b = "  " .. b
					-- end
					-- return vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t") .. b
					return "File Explorer"
				end,
				padding = 1,
				highlight = "Directory",
				-- text_align = "center"
				text_align = "left",
			},
		},
  -- {filetype = "NvimTree", text = "File Explorer" , text_align = "center"},
    -- {filetype = "dbui", text = "Db Explorer" , text_align = "center"},
    -- {filetype = "Outline", text = "Outline" , text_align = "center"},
    
    sort_by = 'insert_at_end',
    hover = {
      enabled = true,
      delay = 200,
      reveal = {'close'}
    },
  persist_buffer_sort = false, -- whether or not custom sorted buffers should persist
  highlights = {
      separator = {
        fg = '#073642',
        bg = '#002b36'
      },
      separator_selected = {
        fg = '#073642'
      },
      background = {
        fg = '#657b83',
        bg = '#002b36'
      },
      buffer_selected = {
        fg = '#fdf6e3',
        bold = true,
      },
      fill = {
        bg = '#073642'
      },
    }
  }
})
EOF
