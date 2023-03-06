return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"lua",
			"vim",
			"help",
			"elm",
			"javascript",
			"typescript",
			"html",
			"css",
			"scss",
		},
		highlight = {
			enable = true,
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
