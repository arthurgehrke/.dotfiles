lua <<EOF
require'toggle_lsp_diagnostics'.init({ start_on = false, underline = false, virtual_text = { prefix = "XXX", spacing = 5 }})
EOF

nmap <space>tld  <Plug>(toggle-lsp-diag)
