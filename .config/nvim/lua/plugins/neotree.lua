return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        lazy = true,
        branch = "v2.x",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            {
                "<leader>fe",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
                end,
                desc = "Explorer NeoTree (root dir)",
            },
            {
                "<leader>fE",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
                end,
                desc = "Explorer NeoTree (cwd)",
            },
            { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
            { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
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
