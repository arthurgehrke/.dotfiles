"npm install -g typescript typescript-language-server diagnostic-languageserver eslint_d

lua << EOF
local nvim_lsp = require("lspconfig")
local on_attach = function(client, bufnr)
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
local opts = { noremap=true, silent=true }
 vim.lsp.handlers['textDocument/references'] = vim.lsp.with(
	on_references, {
		-- Use location list instead of quickfix list
 		loclist = false,
 	}
 )

require('lspconfig').tsserver.setup {
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = require"lspconfig/util".root_pattern("package.json", ".eslintrc", ".git"),
     handlers = {
       ["textDocument/publishDiagnostics"] = vim.lsp.with(
         vim.lsp.diagnostic.on_publish_diagnostics, {
           -- Disable virtual_text
           virtual_text = false
         }
       ),
     }
   }
end
EOF
let g:completion_enable_auto_popup = 0

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gvd <cmd>:vsplit<cr><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gsd <cmd>:split<cr><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <space>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <space>vrh :lua vim.lsp.buf.signature_help()<CR>
nnoremap go <c-o>

