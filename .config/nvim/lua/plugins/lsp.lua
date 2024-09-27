return {
  -- Configuração principal do LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'b0o/schemastore.nvim',
      'hrsh7th/cmp-nvim-lsp', -- Para autocompletar com LSP
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lspconfig = require('lspconfig')
      local util = require('lspconfig/util')

      -- Configurações de capacidades e integração com nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Configuração de handlers globais com bordas arredondadas
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = 'single',
        focusable = false,
        silent = true,
      })

      local servers = {
        -- TypeScript e JavaScript (tsserver)
        ts_ls = {
          root_dir = util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
          filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact' },
          cmd = { 'typescript-language-server', '--stdio' },
          on_attach = function(client, bufnr)
            -- Reativar formatação no tsserver
            client.server_capabilities.documentFormattingProvider = true
            client.server_capabilities.documentRangeFormattingProvider = true

            -- Desativar formatação no eslint para evitar conflitos
            if client.name == 'eslint' then
              client.server_capabilities.documentFormattingProvider = false
            end

            -- Configurar keymap para formatação
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
        -- Lua (lua_ls)
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
        -- Python (pyright)
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
        -- Python (pylsp) - desativado por padrão para evitar conflitos com pyright
        pylsp = {
          enabled = false,
        },
        -- JSON (jsonls)
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },
        -- ESLint (eslint)
        eslint = {
          root_dir = util.root_pattern(
            '.eslintrc',
            '.eslintrc.js',
            '.eslintrc.cjs',
            '.eslintrc.yaml',
            '.eslintrc.yml',
            '.eslintrc.json',
            'package.json',
            '.git'
          ),
          on_attach = function(client, bufnr)
            -- Desativa formatação do eslint para evitar conflito com prettier/tsserver
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false

            -- Configuração para executar o eslint sempre que o buffer for salvo
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              command = 'EslintFixAll',
            })
          end,
          settings = {
            -- Certifique-se de que o eslint respeite as configurações do projeto
            workingDirectory = { mode = 'auto' },
          },
        },
        -- YAML (yamlls)
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        -- Bash/Shell (bashls)
        bashls = {
          filetypes = { 'sh', 'bash', 'zsh' },
        },
        -- CSS (cssls)
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
        -- HTML (html)
        html = {
          capabilities = capabilities,
          cmd = { 'vscode-html-language-server', '--stdio' },
          filetypes = { 'html' },
          settings = {
            html = {
              format = { enable = true },
              hover = { documentation = true, references = true },
            },
          },
        },
        -- R (R Language Server)
        r_language_server = {
          cmd = { 'R', '--slave', '-e', 'languageserver::run()' },
          filetypes = { 'r', 'rmd' },
          root_dir = util.root_pattern('.git', '.Rprofile'),
          settings = {},
        },
      }

      -- Configuração dos servidores LSP
      for server, config in pairs(servers) do
        if config.enabled ~= false then
          lspconfig[server].setup(vim.tbl_deep_extend('force', {
            capabilities = capabilities,
          }, config))
        end
      end
    end,
  },

  -- Configuração do typescript-tools.nvim para TypeScript
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

      -- Keymaps específicos para TypeScript
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
