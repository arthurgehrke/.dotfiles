return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      local util = require('lspconfig/util')
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

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

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
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

      lspconfig.jsonls.setup({
        filetypes = {
          'json',
        },
      })

      lspconfig.yamlls.setup({
        yaml = {
          keyOrdering = false,
        },
      })

      lspconfig.bashls.setup({
        filetypes = {
          'bash',
          'sh',
          'zsh',
        },
      })
    end,
  },
  {
    'pmizio/typescript-tools.nvim',
    lazy = true,
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

        -- settings = {
        --   tsserver_file_preferences = {
        --     includeInlayParameterNameHints = 'literal',
        --     includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --     includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        --     includeInlayFunctionParameterTypeHints = true,
        --     includeInlayVariableTypeHints = true,
        --     includeInlayFunctionLikeReturnTypeHints = false,
        --     includeInlayPropertyDeclarationTypeHints = true,
        --     includeInlayEnumMemberValueHints = true,
        --   },
        -- },
        settings = {
          separate_diagnostic_server = true,
          composite_mode = 'separate_diagnostic',
          publish_diagnostic_on = 'insert_leave',
          tsserver_logs = 'verbose',
          disable_member_code_lens = true,
          jsx_close_tag = {
            enable = true,
            filetypes = { 'javascriptreact', 'typescriptreact' },
          },
          tsserver_file_preferences = {
            quotePreference = 'single',
            importModuleSpecifierEnding = 'minimal',
            importModuleSpecifierPreference = 'relative',
          },
        },
      })

      vim.keymap.set('n', '<leader>to', '<cmd>TSToolsOrganizeImports<cr>', { desc = ' TS Organize Imports' })
      vim.keymap.set('n', '<leader>ts', '<cmd>TSToolsSortImports<cr>', { desc = ' TS Sort Imports' })
      vim.keymap.set('n', '<leader>tru', '<cmd>TSToolsRemoveUnused<cr>', { desc = ' TS Removed Unused' })
      vim.keymap.set(
        'n',
        '<leader>td',
        '<cmd>TSToolsGoToSourceDefinition<cr>',
        { desc = ' TS Go To Source Definition' }
      )
      vim.keymap.set('n', '<leader>tri', '<cmd>TSToolsRemoveUnusedImports<cr>', { desc = ' TS Removed Unused Imports' })
      vim.keymap.set('n', '<leader>tf', '<cmd>TSToolsFixAll<cr>', { desc = ' TS Fix All' })
      vim.keymap.set('n', '<leader>tia', '<cmd>TSToolsAddMissingImports<cr>', { desc = ' TS Add Missing Imports' })
    end,
  },
}
