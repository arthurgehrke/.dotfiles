lua << EOF
require("bufferline").setup{
options = {
  number = "none",
  max_name_length = 18,
  max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
  tab_size = 18,
  diagnostics = false,
  offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "left", highlight = "Directory"}},
  -- indicator_icon = '▎',
  show_buffer_icons = false, -- disable filetype icons for buffers
  show_buffer_close_icons = false,
  show_close_icon = false,
  show_tab_indicators = false,
  persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
  separator_style = "thin",
  enforce_regular_tabs = false,
  always_show_bufferline = false,
  sort_by = 'relative_directory'
  }
}
EOF
