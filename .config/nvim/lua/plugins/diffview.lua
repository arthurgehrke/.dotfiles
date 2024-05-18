return {
	"sindrets/diffview.nvim",
  enabled = false,
	keys = {
		{
			"<leader>go",
			"<cmd>DiffviewOpen<CR>",
			desc = "DiffviewOpen",
		},
		{
			"<leader>gq",
			"<cmd>DiffviewClose<CR>",
			desc = "DiffviewClose",
		},
		{
			"<leader>gf",
			"<cmd>DiffviewFileHistory %<CR>",
			desc = "DiffviewFileHistory cur file",
		},
	},
}
