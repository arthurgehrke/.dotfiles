lua <<EOF
require('bufferline').setup {
   options = {
      mode                        = 'buffers',
      numbers                      = "ordinal", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
      close_command = "bdelete! %d",
      left_mouse_command           = "buffer %d", -- can be a string | function, see "Mouse actions"
      middle_mouse_command         = nil, -- can be a string | function, see "Mouse actions"
      buffer_close_icon            = "",
      modified_icon                = "●",
      close_icon                   = "",
      left_trunc_marker            = "",
      custom_filter = function(buf, buf_nums)
      local hidden_filetypes = { "fugitive", "gitcommit", "checkhealth", "fugitive" }
      return not vim.tbl_contains(hidden_filetypes, vim.bo[buf].filetype)
      end,
      truncate_names = true, -- whether or not tab names should be truncated
      right_trunc_marker           = "",
      indicator                    = {
         icon = '',
         style = 'none',
      },
      name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
      -- remove extension from markdown files for example
      if buf.name:match('%.md') then
         return vim.fn.fnamemodify(buf.name, ':t:r')
      end
      end,
      max_name_length = 18,
      show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
      max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
      tab_size                     = 18,
      diagnostics_update_in_insert = false,
      offsets = {
         {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "left",
            highlight = "Directory",
            separator = false,
            padding = 1
         },
      },
      show_buffer_icons            = false,
      show_buffer_close_icons      = false,
      show_close_icon              = false,
      show_tab_indicators          = true,
      persist_buffer_sort          = false, -- whether or not custom sorted buffers should persist
      separator_style              = "thin",
      always_show_bufferline       = true,
      show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
      sort_by = 'insert_at_end' -- 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
   },
}
EOF
