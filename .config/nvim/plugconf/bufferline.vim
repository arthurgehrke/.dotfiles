lua <<EOF
require('bufferline').setup {
  options = {
    -- mode                        = 'buffers',
    numbers                      = "ordinal", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    close_command                = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    right_mouse_command          = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command           = "buffer %d", -- can be a string | function, see "Mouse actions"
    middle_mouse_command         = nil, -- can be a string | function, see "Mouse actions"
    buffer_close_icon            = "",
    modified_icon                = "●",
    close_icon                   = "",
    left_trunc_marker            = "",
    truncate_names = false, -- whether or not tab names should be truncated
    right_trunc_marker           = "",
    indicator                    = {
      icon = '',
      style = 'none',
    },
    -- max_name_length              = 30,
    -- max_prefix_length            = 30, -- prefix used when a buffer is de-duplicated
    -- tab_size                     = 21,
    diagnostics_update_in_insert = false,
    offsets                      = { { filetype = "NvimTree", text = "File Explorer", padding = 1 } },
    show_buffer_icons            = false,
    show_buffer_close_icons      = false,
    show_close_icon              = false,
    show_tab_indicators          = true,
    persist_buffer_sort          = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style              = "thin",
    always_show_bufferline       = true,
    enforce_regular_tabs         = true,
    sort_by = 'insert_at_end' -- 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
  },
}
EOF
nnoremap <silent><space>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><space>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><space>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><space>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><space>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><space>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><space>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><space>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><space>9 <Cmd>BufferLineGoToBuffer 9<CR>
nnoremap <silent><space>$ <Cmd>BufferLineGoToBuffer -1<CR>
