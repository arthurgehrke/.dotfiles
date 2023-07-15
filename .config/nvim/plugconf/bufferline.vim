lua <<EOF
local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

bufferline.setup({
options = {
  mode = "buffers",
  indicator = {
    icon = '|', -- this should be omitted if indicator style is not 'icon'
    style = 'none',
  },
  themable = false,
  separator_style = 'thin',
  always_show_bufferline = true,
  show_buffer_icons = false,
  show_buffer_close_icons = false,
  show_close_icon = false,
  color_icons = true,
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
