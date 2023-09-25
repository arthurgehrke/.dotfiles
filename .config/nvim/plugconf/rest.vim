
lua << EOF

local status, rest = pcall(require, "rest.nvim")
if (not status) then return end

require("rest-nvim").setup({
      result_split_horizontal = false,
      result_split_in_place = true,
      skip_ssl_verification = true,
      encode_url = true,
      -- Highlight request on run
      highlight = {
        enabled = true,
        timeout = 150,
      },
      result = {
        show_url = true,
        show_http_info = true,
        show_headers = true,
        formatters = {
          json = "jq",
          html = function(body)
            return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
          end
        },
      },
      -- Jump to request line on run
      jump_to_request = false,
      env_file = '.env',
      custom_dynamic_variables = {},
      yank_dry_run = true,
    })

EOF
" rest.nvim
autocmd FileType http nnoremap <buffer> <space>rr <Plug>RestNvim
autocmd FileType http nnoremap <buffer> <space>rc <Plug>RestNvimPreview
noremap <leader>re <plug>RestNvim
nnoremap <leader>rp <plug>RestNvimPreview
nnoremap <leader>rr <plug>RestNvimLast
  command! Http lua require('rest-nvim').run()
    nmap <leader>hh <Plug>RestNvim
