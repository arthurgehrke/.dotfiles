" npm i -g typescript typescript-language-server
" npm install -g typescript typescript-language-server diagnostic-languageserver eslint_d

lua << EOF
local lsp_servers = {
  'cssls',
  'html',
  'jsonls',
  'pyright',
  'tailwindcss',
  'tsserver',
}

require("mason").setup({
ui = {
    icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
        }
    }
})
require('mason-lspconfig').setup({
  ensure_insatlled = lsp_servers,
  automatic_installation = true,
})

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

local nvim_lsp = require('lspconfig')
local protocol = require('vim.lsp.protocol')

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  local opts = { silent = true, noremap = true }

  -- Mappings.
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>aa', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<space>ac', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  if client.name == "tsserver" then                                                                                                   
      client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
      buf_set_keymap('n', '<space>zal', '<cmd>TypescriptAddMissingImports<CR>', opts)
      buf_set_keymap('n', '<space>lak', '<cmd>TypescriptOrganizeImports<CR>', opts)
      buf_set_keymap('n', '<F2>', '<cmd>TypescriptRenameFile<CR>', opts)
  end
end

-- Set up clients

local null_ls = require("null-ls")
null_ls.setup({
    on_attach = on_attach,
    should_attach = function(bufnr)
        local cur_ft = vim.bo[bufnr].filetype
        return vim.tbl_contains({ "vue", "typescript", "javascript", "python", "lua" }, cur_ft)
    end,
    sources = {
        --#formatters
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.eslint_d,
        require("typescript.extensions.null-ls.code-actions")
    },
})

  nvim_lsp.tsserver.setup {
    on_attach = on_attach,
    filetypes = { "typescript" },
    cmd = { "typescript-language-server", "--stdio" },
  }

  nvim_lsp.lua_ls.setup {
    on_attach = on_attach
  }

  nvim_lsp.vimls.setup {
    on_attach = on_attach,
    filetypes = { 
        "vim"
      }
  }
  
  require("typescript").setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    server = { -- pass options to lspconfig's setup method
        on_attach = on_attach
    },
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = true,
    virtual_text = false,
    loclist = false,
    signs = false,
    -- virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
  }
)

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
EOF

let g:completion_enable_auto_popup = 0

nnoremap <silent> gvd <cmd>:vsplit<cr><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gsd <cmd>:split<cr><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap go <c-o>
