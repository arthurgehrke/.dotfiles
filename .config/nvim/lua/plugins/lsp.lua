return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      local util = require('lspconfig/util')

      local handlers = {
        ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' }),
        ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' }),
      }

      local override_formatting_capability = function(client, override)
        client.server_capabilities.documentFormattingProvider = override
        client.server_capabilities.documentRangeFormattingProvider = override
      end

      lspconfig.tsserver.setup({
        root_dir = util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
        settings = {
          completions = {
            completeFunctionCalls = true,
          },
        },
      })

      lspconfig.jsonls.setup({
        handlers = handlers,
        init_options = {
          provideFormatter = false,
        },
      })

      lspconfig.eslint.setup({
        on_attach = function(client, bufnr)
          -- This LS doesn't broadcast formatting support initially and Neovim
          -- doesn't support dynamic registration so force broadcasting
          -- formatting capabilities.
          override_formatting_capability(client, true)
        end,

        settings = { format = false },
        root_dir = util.root_pattern(
          '.eslintrc',
          '.eslintrc.js',
          '.eslintrc.cjs',
          '.eslintrc.yaml',
          '.eslintrc.yml',
          '.eslintrc.json'
        ),
        handlers = handlers,
      })

      lspconfig.bashls.setup({})

      -- graphql
      lspconfig.jsonls.setup({
        filetypes = {
          'json',
        },
      })

      lspconfig.bashls.setup({
        filetypes = {
          'bash',
          'sh',
          'zsh',
        },
      })

      -- lua
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      })
    end,
  },
  {
    'pmizio/typescript-tools.nvim',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    ft = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
      'vue',
    },
    config = function()
      local api = require('typescript-tools.api')
      require('typescript-tools').setup({
        handlers = {
          ['textDocument/publishDiagnostics'] = api.filter_diagnostics({ 6133 }),
        },
        settings = {
          tsserver_file_preferences = {
            importModuleSpecifierPreference = 'non-relative',
          },
        },
      })
    end,
    opts = {
      filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
        'vue',
      },
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = 'literal',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
}
