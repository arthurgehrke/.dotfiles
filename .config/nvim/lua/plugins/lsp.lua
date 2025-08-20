return {
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

    -- Handler para evitar a abertura da quickfix window ao usar "go to definition"
    vim.lsp.handlers['textDocument/definition'] = function(_, result, ctx, _)
      if not result or vim.tbl_isempty(result) then
        print('Definition not found')
        return
      end
      if vim.tbl_islist(result) then
        vim.lsp.util.jump_to_location(result[1], 'utf-8')
      else
        vim.lsp.util.jump_to_location(result, 'utf-8')
      end
    end

    local servers = {
      ts_ls = {
        root_dir = util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
        filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
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
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
          },
        },
      },
      eslint = {
        settings = { workingDirectories = { mode = 'auto' } },
        filetypes = {
          'javascript',
          'javascriptreact',
          'javascript.jsx',
          'typescript',
          'typescriptreact',
          'typescript.tsx',
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
}
