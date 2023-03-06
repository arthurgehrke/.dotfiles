return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      icons_enabled = true,
      theme = "gruvbox",
      component_separators = {left = "", right = ""},
      section_separators = {left = "", right = ""},  
    },  
    disabled_filetypes = {
      statusline = {"alpha", "NvimTree", "Outline", "lazy"},
      winbar = {
        "help", "startify", "packer", "neogitstatus", "NvimTree", "Trouble", "alpha", "lir",
        "Outline", "spectre_panel", "toggleterm", "qf"
      }
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = { "filename", { "diff", symbols = { added = "烙", modified = " ", removed = " " } } },
      lualine_x = { "encoding", { "fileformat", icons_enabled = false }, "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = { "nvim-tree", { sections = { lualine_a = { "filetype" } }, filetypes = { "Outline" } } },	},
  }
