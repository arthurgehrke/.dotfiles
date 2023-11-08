lua << EOF
local ok, lsp = pcall(require, "lsp-zero")
if not ok then
   return
end

local opt = vim.opt
local keymap = vim.keymap
local lspconfig = require('lspconfig')
local protocol = require('vim.lsp.protocol')
local schemas = require('schemastore')
local cmp = require'cmp'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

lsp.format_mapping('gq', {
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['lua_ls'] = {'lua'},
    ['rust_analyzer'] = {'rust'},
    ['null-ls'] = { 'typescript', 'typescriptreact', 'json' },
  }
})

lsp.set_sign_icons(
{
   error = "",
   warn = "",
   hint = "",
   info = ""
}
)

local util = require('lspconfig.util')

lsp.on_attach(function(client, bufnr)
lsp.default_keymaps({buffer = bufnr})
local opts = {buffer = bufnr, remap = false}
  vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
  vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
  vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  vim.keymap.set("n", "<space>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<space>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set({ 'n', 'v' }, '<space>af', function()
  vim.lsp.buf.format({async = true})
end,
{ silent = true, desc = 'format' })

vim.keymap.set({'n', 'x'}, 'gq', function()
vim.lsp.buf.format({async = false, timeout_ms = 10000})
end, opts)

vim.keymap.set({'n', 'x'}, '<space>al', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
vim.keymap.set({'n', 'x'}, "<space>ra", ":TypescriptAddMissingImports<CR>") 

vim.keymap.set({ 'n' }, '<space>k', function()
vim.lsp.buf.signature_help()
end,
{ silent = true, desc = 'toggle signature' })

vim.keymap.set({ 'n' }, '<space>od', function()
vim.diagnostic.open_float()
end,
{ silent = true, desc = 'open diags' })

vim.keymap.set({ 'n' }, '<space>oc', function()
vim.diagnostic.show_line_diagnostics()
end,
{ silent = true, desc = 'open diags' })

vim.keymap.set({ 'n', 'v' }, '<space>ca', function()
vim.lsp.buf.code_action()
end,
{ silent = true, desc = 'toggle signature' })
end)

vim.keymap.set('n', 'gf', "<cmd>Lspsaga lsp_finder<CR>", { noremap = true, silent = true, buffer = bufnr, desc = desc })

require('lspconfig').lua_ls.setup({
   on_attach = function(client, bufnr)
   local opts = { noremap = true, silent = true }
   local keymap = vim.api.nvim_buf_set_keymap
   keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
   keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
end
})

lsp.setup()


local on_attach = function(client, bufnr)

local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

   local opts = { silent = true, noremap = true }

   -- Mappings.
   vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
   vim.keymap.set({'n', 'x'}, '<space>af', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)

   if client.name == "tsserver" then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      keymap.set("n", "<space>re", ":TypescriptRenameFile<CR>") -- rename file and update imports
      keymap.set("n", "<space>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
      keymap.set("n", "<space>ra", ":TypescriptAddMissingImports<CR>") -- remove unused variables (not in youtube nvim video)
   end

end

-- null-ls
local null_ls = require("null-ls")

null_ls.setup({
   auto_restart = true,
   run_on_start = true,
   autostart = true,
   debug = false,
   on_attach = function(client, bufnr)
     if --[[ client.name == "eslint" or client.name == "angularls" or  ]] client.name == "null-ls" then
       return
     end

     client.server_capabilities.documentFormattingProvider = true
     client.server_capabilities.documentRangeFormattingProvider = true
   end,
   sources = {
      null_ls.builtins.formatting.prettier.with({
         condition = function(utils)
         return utils.root_has_file({
            '.prettierrc',
            '.prettierrc.json',
            '.prettierrc.yml',
            '.prettierrc.yaml',
            '.prettierrc.json5',
            '.prettierrc.js',
            '.prettierrc.cjs',
            '.prettierrc.toml',
            'prettier.config.js',
            'prettier.config.cjs',
         })
         end,
         only_local = "node_modules/.bin",
      }),
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.formatting.eslint_d.with {
         condition = function(utils)
         return utils.root_has_file { '.eslintrc.js', '.eslintrc.json' }
         end,
      },
      require("typescript.extensions.null-ls.code-actions"),
      null_ls.builtins.diagnostics.eslint_d.with {
         condition = function(utils)
         return utils.root_has_file { '.eslintrc.js', '.eslintrc.json' }
         end,
      },
      null_ls.builtins.diagnostics.jsonlint,
      null_ls.builtins.formatting.fixjson,
      null_ls.builtins.formatting.stylua.with({
        extra_args = { "--indent-type=Spaces", "--indent-width=2", "--column-width=100" },
      }),
      null_ls.builtins.formatting.pg_format.with {
         filetypes = { "sql", "pgsql" },
      },
      null_ls.builtins.code_actions.gitsigns,
      null_ls.builtins.formatting.xmllint,
   },
   root_dir = require("null-ls.utils").root_pattern(
     ".null-ls-root",
     ".neoconf.json",
     "Makefile",
     ".git",
     "package.lock-json"
   ),
})

cmp.setup({
 preselect = cmp.PreselectMode.None,
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
 confirm_opts = {
   behavior = cmp.ConfirmBehavior.Replace,
   select = false,
 },
 formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
 mapping = cmp.mapping.preset.insert({
   ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
   ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
   ['<CR>'] = cmp.mapping.confirm({select = true}),
   ['<C-p>'] = cmp.mapping.select_prev_item(),
   ['<C-n>'] = cmp.mapping.select_next_item(),
   ['q'] = cmp.mapping.abort(),
 }),
 sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
 }),
})

function setAutoCmp(mode)
   if mode then
      cmp.setup({
         completion = {
            autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged }
         }
      })
   else
      cmp.setup({
         completion = {
            autocomplete = false
         }
      })
   end
end
setAutoCmp(false)

-- enable automatic completion popup on typing
vim.cmd('command! AutoCmpOn lua setAutoCmp(true)')
-- disable automatic competion popup on typing
vim.cmd('command! AutoCmpOff lua setAutoCmp(false)')

require('lspconfig').tsserver.setup({
   on_init = function(client)
     client.server_capabilities.documentFormattingProvider = false
     client.server_capabilities.documentFormattingRangeProvider = false
   end,
   capabilities = capabilities,
   filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
   cmd = { "typescript-language-server", "--stdio" },
   on_attach = function(client)
     client.resolved_capabilities.document_formatting = false
   end,
})

require('lspconfig').yamlls.setup({
   settings = {
      format = { enable = true },
      json = {
         schemas = schemas.json.schemas().yamlls,
      },
   },
   filetypes = { "yaml" }
})

require('lspconfig').jsonls.setup({
   settings = {
      format = { enable = true },
      json = {
         schemas = schemas.json.schemas().jsonls,
      },
   },
   filetypes = { "json" }
})

require('lspconfig').html.setup({
   settings = {
      format = { enable = true },
      json = {
         schemas = schemas.json.schemas().html,
      },
   },
   filetypes = { "html" }
})

require('lspconfig').yamlls.setup({
   settins = {
      yamlls = {
        format = { enable = true, singleQuote = true },
        validate = true,
        hover = true,
        completion = true,
        schemaStore = {
          enable = true,
          url = "https://www.schemastore.org/api/json/catalog.json",
        },
        schemas = schemas.json.schemas().yamls,
      },
   },
   filetypes = { "yaml" }
})

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

require 'lspconfig'.bashls.setup ({
  cmd = {
    "bash-language-server",
    "start"
  },
  filetypes = { "sh", "zsh" },
  capabilities = CAPABILITIES,
})

require('lspconfig').ruff_lsp.setup({})

 require('lspconfig').pyright.setup ({
   capabilities = capabilities,
   on_attach = on_attach,
   settings = {
     python = {
       analysis = {
         autoImportCompletions = false,
         useLibraryCodeForTypes = false
       }
       }
     },
     before_init = function(_, config)
     config.settings.python.pythonPath = require('lspconfig').util.path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
     end
 })

require('lspconfig').marksman.setup({
  capabilities = capabilities,
  filetypes = {
    "markdown", "md", "latex", "tex", "org", "plaintext", "txt"
  },
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    client.server_capabilities.completionProvider = false
  end
})

require('lspconfig').cssls.setup({
  cmd          = { "css-languageserver", "--stdio" },
  filetypes    = { "css", "scss", "less" },
  -- root_dir  = root_pattern("package.json", ".git") or bufdir,
  settings = {
    css = {
      validate = true
    },
    less = {
      validate = true
    },
    scss = {
      validate = true
    }
  },
  single_file_support = true,
})

vim.diagnostic.config({
   virtual_text = false,
   signs = false,
   update_in_insert = true,
   underline = true,
   severity_sort = true,
   -- float = true,
   float = {
        severity_sort = true,
        source = "if_many",
        border = "rounded",
        prefix = function(diagnostic)
            local diag_to_format = {
                [vim.diagnostic.severity.ERROR] = { "Error", "LspDiagnosticsDefaultError" },
                [vim.diagnostic.severity.WARN] = { "Warning", "LspDiagnosticsDefaultWarning" },
                [vim.diagnostic.severity.INFO] = { "Info", "LspDiagnosticsDefaultInfo" },
                [vim.diagnostic.severity.HINT] = { "Hint", "LspDiagnosticsDefaultHint" },
            }
            local res = diag_to_format[diagnostic.severity]
            return string.format("(%s) ", res[1]), res[2]
        end,
    },
})

vim.opt.updatetime = 100
vim.env.NEOVIM_NODE_VERSION = 'v18.12.1'

if vim.fn.has('unix') and vim.env.NEOVIM_NODE_VERSION then
    local node_dir = vim.env.HOME .. '/.nvm/versions/node/' .. vim.env.NEOVIM_NODE_VERSION .. '/bin/'
    if (vim.fn.isdirectory(node_dir)) then
        vim.env.PATH = node_dir .. ':' .. vim.env.PATH
    end
end
EOF

nnoremap <silent> gvd <cmd>:vsplit<cr><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gsd <cmd>:split<cr><cmd>lua vim.lsp.buf.definition()<CR>

nnoremap <space>ew :e <C-R>=expand("%:.:h") . "/"<CR>
nnoremap <space>tcd :tcd %:h<CR>
