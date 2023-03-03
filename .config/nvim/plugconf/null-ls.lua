local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.completion.spell,
    null_ls.builtins.diagnostics.jsonlint,
    null_ls.builtins.formatting.fixjson,
    null_ls.builtins.formatting.prettier.with({
      prefer_local = "node_modules/.bin",
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    }),

  },
})
