lua << EOF
require('lint').linters_by_ft = {
  markdown = {'markdownlint'},
  -- typescript = {'eslint', 'eslint_d'},
  bash = { 'shellcheck' },
	typescriptreact = { "eslint" },
  typescript = { "eslint" },
  json = {'jsonlint'},
  lua = { 'luacheck' },
  python = { 'ruff' },
}

-- suppress eslint not found in node_modules global error
local eslint_d = require("lint").linters.eslint_d
eslint_d.args = {
	"--no-warn-ignored",
	"--format",
	"json",
	"--stdin",
	"--stdin-filename",
	function()
		return vim.api.nvim_buf_get_name(0)
	end,
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
EOF
