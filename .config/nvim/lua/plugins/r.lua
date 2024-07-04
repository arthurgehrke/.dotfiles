return {
  'R-nvim/R.nvim',
  lazy = false,
  ft = { 'r', 'rmd' },
  keys = {
    { '<LocalLeader>r', '', desc = '+R' },
    { ft = { 'r', 'rdoc' }, '<leader><Space>', '<Plug>RDSendLine', desc = 'which_key_ignore' },
    { ft = { 'r', 'rdoc' }, mode = 'x', '<leader><Space>', '<Plug>RDSendSelection', desc = 'Send Selection to R' },
    { '<LocalLeader>r:', ':RSend ', desc = 'Send R Command' },
    { '<LocalLeader>rf', '<Plug>RStart', desc = 'Start R' },
    { '<LocalLeader>ro', '<Plug>ROBToggle', desc = 'Object Browser' },
    { '<LocalLeader>rq', '<Plug>RClose', desc = 'Stop R' },
    { '<LocalLeader>rH', '<Plug>RHelp', desc = 'R Help' },
    { '<LocalLeader>rp', '<Plug>RObjectPr', desc = 'Print Object' },
    { '<LocalLeader>rs', '<Plug>RObjectStr', desc = 'Print Structure' },
    { '<LocalLeader>rS', '<Plug>RSummary', desc = 'Summary' },
    { '<LocalLeader>rn', '<Plug>RObjectNames', desc = 'View Names' },
    { '<LocalLeader>rv', '<Plug>RViewDF', desc = 'View DF' },
    { '<LocalLeader>rP', '<Plug>RSeparatePathPaste', desc = 'Separate Path Paste' },
    {
      '<LocalLeader>rg',
      function()
        require('r.run').action('glimpse')
      end,
      desc = 'Glimpse',
    },
    {
      '<LocalLeader>rc',
      function()
        require('r.run').action('class')
      end,
      desc = 'View Class',
    },
    {
      '<LocalLeader>rl',
      function()
        require('r.run').action('levels')
      end,
      desc = 'View Levels',
    },
    {
      '<LocalLeader>rh',
      function()
        require('r.run').action('head')
      end,
      desc = 'View Head',
    },
    {
      '<LocalLeader>rt',
      function()
        require('r.run').action('tail')
      end,
      desc = 'View Tail',
    },
    {
      '<LocalLeader>ru',
      '<cmd>RSend update.packages(ask = FALSE)<CR>',
      desc = 'Update Packages',
    },
    {
      '<LocalLeader>rU',
      '<cmd>RSend BiocManager::install()<CR>',
      desc = 'Update Bioconductor Packages',
    },
    {
      '<LocalLeader>ri',
      function()
        local current_word = vim.call('expand', '<cword>')
        local rsend_command = string.format(':RSend install.packages("' .. current_word .. '")')
        vim.api.nvim_command(rsend_command)
      end,
      desc = 'Install Package',
    },
  },

  config = function()
    -- Create a table with the options to be passed to setup()
    local opts = {
      R_args = { '--quiet', '--no-save' },
      user_maps_only = true,
      hook = {
        on_filetype = function()
          -- This function will be called at the FileType event
          -- of files supported by R.nvim. This is an
          -- opportunity to create mappings local to buffers.
          vim.keymap.set('n', '<Enter>', '<Plug>RDSendLine', { buffer = true })
          vim.keymap.set('v', '<Enter>', '<Plug>RSendSelection', { buffer = true })
        end,
      },
      min_editor_width = 72,
      rconsole_width = 78,
      disable_cmds = {
        'RClearConsole',
        'RCustomStart',
        'RSPlot',
        'RSaveClose',
      },
    }
    -- Check if the environment variable "R_AUTO_START" exists.
    -- If using fish shell, you could put in your config.fish:
    -- alias r "R_AUTO_START=true nvim"
    if vim.env.R_AUTO_START == 'true' then
      opts.auto_start = 1
      opts.objbr_auto_start = true
    end
    require('r').setup(opts)
  end,
}
