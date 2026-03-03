return {
  {
    'mason-org/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = {
        'stylua', 'shfmt', 'black', 'prettier', 'prettierd', 'goimports',
        'gofumpt', 'sql-formatter', 'jq', 'luacheck', 'shellcheck', 'yamllint',
        'jsonlint', 'htmlhint', 'eslint_d', 'ruff', 'phpstan', 'vale', 'golangci-lint',
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
    'williamboman/mason-lspconfig.nvim',
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'saghen/blink.cmp',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- === SEUS ATALHOS DE LSP CONSOLIDADOS ===
          map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
          map('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
          map('gtD', vim.lsp.buf.type_definition, '[G]oto [T]ype [D]efinition')
          
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
          
          -- Splits com Definition
          map('gvd', function() vim.cmd('vsplit'); vim.lsp.buf.definition() end, 'V-Split Goto Definition')
          map('gsd', function() vim.cmd('split'); vim.lsp.buf.definition() end, 'Split Goto Definition')

          -- Ações de Código
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'v' })
          map('ca', function() vim.lsp.buf.code_action({ apply = true, context = { only = { 'source.fixAll' } } }) end, 'Fix All')
          map('<leader>oi', function() vim.lsp.buf.code_action({ apply = true, context = { only = { 'source.organizeImports.ts' }, diagnostics = {} } }) end, 'Organize Imports')

          -- Formatação
          map('gq', function() vim.lsp.buf.format({ async = false, timeout_ms = 2000 }) end, 'Format buffer')

          -- Inlay hints (se o servidor suportar)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local function client_supports_method(c, method, bufnr)
            if vim.fn.has('nvim-0.11') == 1 then
              return c:supports_method(method, bufnr)
            else
              return c.supports_method(method, { bufnr = bufnr })
            end
          end

          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local util = require('lspconfig/util')

      local servers = {
        gopls = {
          capabilities = capabilities,
          cmd = { 'gopls' },
          filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
          root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              analyses = { unusedparams = true },
            },
          },
        },
        rust_analyzer = {},
        vue_ls = {},
        eslint = {},
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
          on_attach = function(client, bufnr)
            client.server_capabilities.hoverProvider = false
          end,
        },
        lua_ls = {
          settings = {
            Lua = { completion = { callSnippet = 'Replace' } },
          },
        },
        
        -- TypeScript/Angular:
        vtsls = {},
        -- ts_ls = {}, <-- COMENTADO para não conflitar com o vtsls
        angularls = {},
        html = {},
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, { 'stylua' })
      
      require('mason-lspconfig').setup({
        ensure_installed = ensure_installed,
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
