return {
  'mfussenegger/nvim-lint',
  lazy = false,
  optional = true,
  opts = {
    linters_by_ft = {
      zsh = { 'zsh' },
      yaml = { 'yamllint' },
    },
  },
}
