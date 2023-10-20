lua <<EOF
local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

bufferline.setup({
options = {
  mode = "buffers",
  themable = false,
  theme = 'tokyonight',
  style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
  mode = "buffers",
  indicator = {
    icon = '|', -- this should be omitted if indicator style is not 'icon'
    style = 'none',
  },
  separator_style = 'thin',
  always_show_bufferline = true,
  show_buffer_icons = false,
  show_buffer_close_icons = false,
  show_close_icon = true,
  color_icons = false,
  offsets = {
    {
        filetype = "NvimTree",
        text = "File Explorer",
          text_align = "left",
          separator = true
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
  persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
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
