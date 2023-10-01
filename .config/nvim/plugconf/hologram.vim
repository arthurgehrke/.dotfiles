lua << EOF
require('hologram').setup{
    auto_display = true -- WIP automatic markdown image display, may be prone to breaking
}

require('image').setup {
  render = {
    min_padding = 5,
    show_label = true,
		show_image_dimensions = true,
    use_dither = true,
    foreground_color = false,
    background_color = false
  },
  events = {
    update_on_nvim_resize = true,
  },
}
EOF
