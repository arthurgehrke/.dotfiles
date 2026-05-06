return {
  'MagicDuck/grug-far.nvim',
  cmd = 'GrugFar',
  keys = {
    { '<leader>S', '<cmd>GrugFar<cr>' },
  },
  config = function()
    require('grug-far').setup({
      debounceMs = 100,
      maxSearchMatches = 1000,
      enabledEngines = { 'ripgrep' },
      engines = {
        ripgrep = {
          defaults = {
            flags = '--smart-case --hidden --fixed-strings --glob !.git',
          },
        },
      },
      showCompactInputs = true,
      showStatusIcon = false,
      showEngineInfo = false,
      transient = true,
      folding = {
        enabled = false,
      },
      resultLocation = {
        showNumberLabel = false,
      },
    })
    vim.api.nvim_set_hl(0, 'GrugFarResultsMatch', { link = 'Search' })
  end,
}
