function setTheme(theme, set_custom)
  theme = theme or "gruvbox-material"
  set_custom = set_custom or false

  vim.opt.termguicolors = true
  vim.opt.background = "dark"
  vim.cmd.colorscheme(theme)

  if set_custom == true then
    if theme == "gruvbox" or "gruvbox-material" then
      vim.g.gruvbox_material_background = "soft"
      -- vim.g.gruvbox_material_colors_override = { bg0 = { "#222222", "235" } }
      vim.g.gruvbox_material_statusline_style = "default"
      vim.g.gruvbox_material_foreground = "original"
      vim.g.gruvbox_material_better_performance = 1
    end

    if theme == "gruvbox" then
      require("gruvbox").setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = false,
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "hard", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        -- dim_inactive = false,
        transparent_mode = false,
      })

    end

    -- Nvim-Tree
    vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#222222" })
    vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "#222222", fg = "#222222" })
    vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "#222222" })
    vim.api.nvim_set_hl(0, "VertSplit", { fg = "#222222", bg = "#222222" })

    vim.api.nvim_set_hl(0, "Pmenu", { bg = "#191919" })
    vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#ebdbb2", fg = "#191919" })

    vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { bg = "#191919", fg = "#cc5547" })
    vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { bg = "#191919", fg = "#83A598" })
    vim.api.nvim_set_hl(0, "DiagnosticFloatingWarning", { bg = "#1fd143", fg = "#FABD2F" })
    vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { bg = "#db27d5" })

    vim.api.nvim_set_hl(0, "Floaterm", { bg = "#191919" })
    vim.api.nvim_set_hl(0, "FloatermBorder", { bg = "#191919" })

    vim.api.nvim_set_hl(0, "FocusedSymbol", { bg = "#a89984", fg = "#282828" })
  end
end

setTheme("gruvbox", true)

