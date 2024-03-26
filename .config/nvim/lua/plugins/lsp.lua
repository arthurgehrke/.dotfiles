return { {
  'neovim/nvim-lspconfig',
  config = function()
    local lspconfig = require 'lspconfig'


    lspconfig.tsserver.setup {}
    lspconfig.bashls.setup {}

    -- graphql
    lspconfig.jsonls.setup {
      filetypes = {
        'json',
      },
    }

    lspconfig.bashls.setup({
      filetypes = {
        'bash',
        'sh',
        'zsh',
      },
    })

    -- lua
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    }
  end,
},
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      local api = require 'typescript-tools.api'
      require('typescript-tools').setup {
        handlers = {
          ['textDocument/publishDiagnostics'] = api.filter_diagnostics { 6133 },
        },
        settings = {
          tsserver_file_preferences = {
            importModuleSpecifierPreference = 'non-relative',
          },
        },
      }
    end,
  }
}
