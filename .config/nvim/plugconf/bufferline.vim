lua <<EOF
require("bufferline").setup({
options = {
  mode = "buffers",
  indicator_icon = "|",
  buffer_close_icon = "",
  modified_icon = "●",
  close_icon = '',
  themable = false,
  left_trunc_marker = "",
  right_trunc_marker = "",
  theme = 'gruvbox',
  tab_size = 21,
  diagnostics = false, -- | "nvim_lsp" | "coc",
  diagnostics_update_in_insert = false,
  max_name_length = 30,
  max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
  -- style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
  mode = "buffers",
  indicator = {
    icon = '|', -- this should be omitted if indicator style is not 'icon'
    style = 'none',
  },
  numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
  separator_style = 'thin',
  always_show_bufferline = true,
  enforce_regular_tabs = true,
  show_buffer_icons = true,
  show_buffer_close_icons = false,
  show_close_icon = false,
  show_tab_indicators = true,
  color_icons = false,
  offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
  -- persist_buffer_sort = false, -- whether or not custom sorted buffers should persist
  persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
-- offsets = {
-- 			{
-- 				filetype = "NvimTree",
-- 				text = function()
-- 					return "File Explorer"
-- 				end,
-- 				padding = 1,
-- 				highlight = "Directory",
-- 				text_align = "left",
-- 			},
-- 		},
  -- {filetype = "NvimTree", text = "File Explorer" , text_align = "center"},
    -- {filetype = "dbui", text = "Db Explorer" , text_align = "center"},
    -- {filetype = "Outline", text = "Outline" , text_align = "center"},
    
    sort_by = 'insert_at_end',
    hover = {
      enabled = true,
      delay = 200,
      reveal = {'close'}
    },
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
