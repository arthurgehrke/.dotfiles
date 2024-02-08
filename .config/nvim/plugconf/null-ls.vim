lua << EOF
local prettier = require('prettier')
local null_ls = require("null-ls")

null_ls.setup({
  debug = false,
  sources = { 
    null_ls.builtins.formatting.eslint_d.with({ prefer_local = 'node_modules/.bin' }),
		null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettier.with({
      prefer_local = 'node_modules/.bin',
      filetypes = { 'javascript', 'typescript', 'typescriptreact', 'css', 'tsx' },
    }),
  }
})

prettier.setup({
  bin = 'prettier', -- or `'prettierd'` (v0.22+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
  cli_options = {
      -- https://prettier.io/docs/en/cli.html#--config-precedence
      config_precedence = "prefer-file", -- or "cli-override" or "file-override"
  },
})
EOF
