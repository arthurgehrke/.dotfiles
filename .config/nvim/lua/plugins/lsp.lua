return {
  {
    'mason-org/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = {
        'stylua',
        'shfmt',
        'black',
        'prettier',
        'prettierd',
        'beautysh',
        'shellharden',
        'goimports',
        'gofumpt',
        'sql-formatter',
        'jq',
        'luacheck',
        'shellcheck',
        'yamllint',
        'yamlfix',
        'jsonlint',
        'htmlhint',
        'htmlbeautifier',
        'eslint_d',
        'ruff',
        'phpstan',
        'vale',
        'golangci-lint',
        'sqlfluff',
        'stylelint',
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      mr:on('package:install:success', function()
        vim.defer_fn(function()
          require('lazy.core.handler.event').trigger({
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'mason-org/mason-lspconfig.nvim', opts = {} },
    },
    init = function()
      local icons = {
        [vim.diagnostic.severity.ERROR] = '󰅚',
        [vim.diagnostic.severity.WARN] = '󰀪',
        [vim.diagnostic.severity.HINT] = '󰌶',
        [vim.diagnostic.severity.INFO] = '󰋽',
      }

      vim.diagnostic.config({
        signs = {
          text = icons,
          texthl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
            [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
            [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
          },
        },
        virtual_text = false,
        float = {
          focusable = false,
          style = 'minimal',
          border = 'rounded',
          header = '',
          prefix = '',
          suffix = '',
          source = true,
          format = function(d)
            if d.code then
              return string.format('%s [%s]', d.message, d.code)
            end
            return d.message
          end,
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Diagnostic Float' })
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic Loclist' })

      vim.keymap.set('n', ']e', function()
        vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
      end, { desc = 'Next Error' })

      vim.keymap.set('n', '[e', function()
        vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
      end, { desc = 'Prev Error' })

      vim.keymap.set('n', ']w', function()
        vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN })
      end, { desc = 'Next Warning' })

      vim.keymap.set('n', '[w', function()
        vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN })
      end, { desc = 'Prev Warning' })
    end,
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
          map('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
          map('gtD', vim.lsp.buf.type_definition, '[G]oto [T]ype [D]efinition')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

          map('gvd', function()
            vim.cmd('vsplit')
            vim.lsp.buf.definition()
          end, 'V-Split Goto Definition')
          map('gsd', function()
            vim.cmd('split')
            vim.lsp.buf.definition()
          end, 'Split Goto Definition')

          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'v' })
          map('ca', function()
            vim.lsp.buf.code_action({ apply = true, context = { only = { 'source.fixAll' } } })
          end, 'Fix All')
          map('<leader>oi', function()
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { 'source.organizeImports.ts' }, diagnostics = {} },
            })
          end, 'Organize Imports')
          map('gq', function()
            vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
          end, 'Format buffer')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.name == 'clangd' then
            vim.keymap.set('n', '<leader>lh', '<cmd>ClangdSwitchSourceHeader<cr>', { buffer = event.buf, desc = 'LSP: Switch Source/Header' })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      vim.lsp.config('*', { capabilities = capabilities })

      local servers = {
        gopls = {
          cmd = { 'gopls' },
          filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
          root_markers = { 'go.work', 'go.mod', '.git' },
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              analyses = { unusedparams = true },
            },
          },
        },
        rust_analyzer = {},
        eslint = {
          filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
            'vue',
            'svelte',
            'astro',
          },
          settings = {
            workingDirectories = { mode = 'auto' },
            format = false,
          },
        },
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'openFilesOnly',
              },
            },
          },
        },
        ruff = {
          on_attach = function(client, _)
            client.server_capabilities.hoverProvider = false
          end,
        },
        lua_ls = {
          settings = {
            Lua = { completion = { callSnippet = 'Replace' } },
          },
        },
        vtsls = {
          filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
          },
          root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
          settings = {
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
            },
            typescript = {
              updateImportsOnFileMove = { enabled = 'always' },
              suggest = { completeFunctionCalls = true },
            },
            javascript = {
              updateImportsOnFileMove = { enabled = 'always' },
              suggest = { completeFunctionCalls = true },
              implicitProjectConfig = { checkJs = true },
            },
          },
        },
        angularls = {},
        html = {},
        clangd = {
          cmd = {
            'clangd',
            '--background-index',
            '--suggest-missing-includes',
            '--clang-tidy',
            '--header-insertion=iwyu',
          },
        },
      }

      for name, cfg in pairs(servers) do
        vim.lsp.config(name, cfg)
      end

      require('mason-lspconfig').setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_enable = true,
      })
    end,
  },
}
