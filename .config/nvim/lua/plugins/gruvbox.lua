return {
  'ellisonleao/gruvbox.nvim',
  enabled = true,
  lazy = false,
  -- disable = true,
  priority = 1000,
  config = function()
    require('gruvbox').setup({
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = false,
        operators = false,
        comments = false,
      },
      strikethrough = false,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true,
      contrast = 'hard',
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = true,
    })

    vim.cmd("colorscheme gruvbox")
  end,
}
