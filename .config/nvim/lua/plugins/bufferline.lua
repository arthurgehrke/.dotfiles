return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
  },
  opts = {
    options = {
      mode = "buffers", -- set to "tabs" to only show tabpages instead
      themable = true,
      numbers = "ordinal",
      always_show_bufferline = false,
      show_close_icon = false,
      show_buffer_icons = true,
      show_buffer_close_icons = false,
      show_buffer_default_icon = true,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left"
        },
      },
    },
  },
}
