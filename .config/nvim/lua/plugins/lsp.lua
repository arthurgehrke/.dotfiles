return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'b0o/schemastore.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lspconfig = require('lspconfig')
      local util = require('lspconfig/util')

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = 'single',
        focusable = false,
        silent = true,
      })

      local servers = {
        ts_ls = {
          root_dir = util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
          filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact' },
          cmd = { 'typescript-language-server', '--stdio' },
          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = true
            client.server_capabilities.documentRangeFormattingProvider = true

            if client.name == 'eslint' then
              client.server_capabilities.documentFormattingProvider = false
            end

            vim.api.nvim_buf_set_keymap(
              bufnr,
              'n',
              '<leader>gq',
              '<cmd>lua vim.lsp.buf.format()<CR>',
              { noremap = true, silent = true }
            )
          end,
        },
        -- tsserver = {
        --   root_dir = util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
        --   filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact' },
        --   cmd = { 'typescript-language-server', '--stdio' },
        --   on_attach = function(client, bufnr)
        --     -- Desativa formatação do tsserver para evitar conflito com prettier/eslint
        --     client.server_capabilities.documentFormattingProvider = false
        --     client.server_capabilities.documentRangeFormattingProvider = false
        --   end,
        -- },
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' }, -- Reconhecer 'vim' como global
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
              },
            },
          },
        },
        marksman = {},
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                typeCheckingMode = 'off',
              },
            },
          },
        },
        pylsp = {},
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },
        -- eslint = {
        --   root_dir = util.root_pattern(
        --     '.eslintrc',
        --     '.eslintrc.js',
        --     '.eslintrc.cjs',
        --     '.eslintrc.yaml',
        --     '.eslintrc.yml',
        --     '.eslintrc.json',
        --     'package.json',
        --     '.git'
        --   ),
        --   on_attach = function(client, bufnr)
        --     client.server_capabilities.documentFormattingProvider = false
        --     client.server_capabilities.documentRangeFormattingProvider = false

        --     vim.api.nvim_create_autocmd('BufWritePre', {
        --       buffer = bufnr,
        --       command = 'EslintFixAll',
        --     })
        --   end,
        --   settings = {
        --     workingDirectory = { mode = 'auto' },
        --   },
        -- },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        bashls = {
          cmd = { 'bash-language-server', 'start' },
          filetypes = { 'sh', 'bash', 'zsh', 'conf' },
        },
        cssls = {
          capabilities = capabilities,
          cmd = { 'vscode-css-language-server', '--stdio' },
          filetypes = { 'css', 'scss', 'less' },
          settings = {
            css = { validate = true },
            scss = { validate = true },
            less = { validate = true },
          },
        },
        html = {
          capabilities = capabilities,
          cmd = { 'vscode-html-language-server', '--stdio' },
          filetypes = { 'html' },
          settings = {
            html = {
              format = { enable = true },
              hover = { documentation = false, references = false },
            },
          },
        },
        r_language_server = {
          cmd = { 'R', '--slave', '-e', 'languageserver::run()' },
          filetypes = { 'r', 'rmd' },
          root_dir = util.root_pattern('.git', '.Rprofile'),
          settings = {},
        },
      }

      for server, config in pairs(servers) do
        if config.enabled ~= false then
          lspconfig[server].setup(vim.tbl_deep_extend('force', {
            capabilities = capabilities,
          }, config))
        end
      end
    end,
  },
  {
    'pmizio/typescript-tools.nvim',
    lazy = true,
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue' },
    config = function()
      require('typescript-tools').setup({
        settings = {
          separate_diagnostic_server = true,
          publish_diagnostic_on = 'insert_leave',
          tsserver_logs = 'verbose',
          disable_member_code_lens = true,
          jsx_close_tag = { enable = true, filetypes = { 'javascriptreact', 'typescriptreact' } },
          tsserver_file_preferences = {
            quotePreference = 'single',
            importModuleSpecifierEnding = 'minimal',
            importModuleSpecifierPreference = 'relative',
          },
        },
      })

      vim.keymap.set('n', '<leader>to', '<cmd>TSToolsOrganizeImports<cr>', { desc = 'TS Organize Imports' })
      vim.keymap.set('n', '<leader>ts', '<cmd>TSToolsSortImports<cr>', { desc = 'TS Sort Imports' })
      vim.keymap.set('n', '<leader>tru', '<cmd>TSToolsRemoveUnused<cr>', { desc = 'TS Remove Unused' })
      vim.keymap.set('n', '<leader>td', '<cmd>TSToolsGoToSourceDefinition<cr>', { desc = 'TS Go To Source Definition' })
      vim.keymap.set('n', '<leader>tri', '<cmd>TSToolsRemoveUnusedImports<cr>', { desc = 'TS Remove Unused Imports' })
      vim.keymap.set('n', '<leader>tf', '<cmd>TSToolsFixAll<cr>', { desc = 'TS Fix All' })
      vim.keymap.set('n', '<leader>tia', '<cmd>TSToolsAddMissingImports<cr>', { desc = 'TS Add Missing Imports' })
    end,
  },
}
