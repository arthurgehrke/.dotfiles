-- npm i -g eslint prettier eslint_d

vim.g.ale_linters = {
  javascript      = {'eslint', 'tsserver'},
  typescript      = {'eslint', 'tsserver'},
  -- \ 'javascriptreact' : ['eslint', 'tsserver'],
  -- \ 'typescriptreact' : ['eslint', 'tsserver']
}

vim.g.ale_fixers = {
  typescript = {'eslint'},
  javascript = {'eslint'},
  '*'= {'remove_trailing_lines', 'trim_whitespace'},
  -- \'javascript.jsx': ['prettier', 'eslint'],
  -- \'typescriptreact': ['prettier', 'eslint'],
  -- \'css': ['prettier'],
  -- \'json': ['prettier'],
 }
