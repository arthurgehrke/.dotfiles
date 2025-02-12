return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'VeryLazy',
  config = function()
    require('ibl').setup({
      scope = {
        show_start = false,
      },
      indent = {
        char = '┊',
        tab_char = '┊',
        smart_indent_cap = true,
      },
      whitespace = {
        remove_blankline_trail = true,
      },
      exclude = {
        buftypes = { 'terminal', 'nofile' },
        filetypes = {
          'alpha',
          'log',
          'gitcommit',
          'dapui_scopes',
          'dapui_stacks',
          'dapui_watches',
          'dapui_breakpoints',
          'dapui_hover',
          'LuaTree',
          'dbui',
          'UltestSummary',
          'UltestOutput',
          'vimwiki',
          -- 'markdown',
          'vista',
          'NvimTree',
          'git',
          'TelescopePrompt',
          'undotree',
          'flutterToolsOutline',
          'org',
          'orgagenda',
          'help',
          'startify',
          'dashboard',
          'lazy',
          'neogitstatus',
          'Outline',
          'Trouble',
          'lspinfo',
        },
      },
    })
  end,
}
