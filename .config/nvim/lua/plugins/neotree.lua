return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    lazy = true,
    branch = "v2.x",
    enabled = false,
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>f", "<cmd>Neotree toggle=true<cr>", desc = "N[e]o-tree" },
    },
    config = function()
      require("neo-tree").setup({
        window = {
          mappings = {
            ["l"] = "open_with_window_picker",
            ["h"] = "close_node",
            ["<C-x>"] = "split_with_window_picker",
            ["<C-v>"] = "vsplit_with_window_picker",
          },
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = vim.fn.getcwd() ~= vim.env.DOTFILES,
            hide_hidden = vim.fn.getcwd() ~= vim.env.DOTFILES,
          },
        },
      })
    end,
  },
}
