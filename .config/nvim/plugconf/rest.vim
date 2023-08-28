
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
        show_curl_command = false,
        show_http_info = true,
        show_headers = true,
        formatters = {
          json = "jq",
          html = function(body)
            return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
          end
        },
        result = {
          -- toggle showing URL, HTTP info, headers at top the of result window
          show_url = true,
          show_http_info = true,
          show_headers = true,
          -- executables or functions for formatting response body [optional]
          -- set them to nil if you want to disable them
          formatters = {
            json = "jq",
            html = function(body)
            return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
            end
          },
        },
      },
      -- Jump to request line on run
      jump_to_request = false,
      env_file = '.env',
      custom_dynamic_variables = {},
      yank_dry_run = true,
    })
EOF

nnoremap <space>rr <Plug>RestNvim<CR>
nnoremap <space>rc <Plug>RestNvimPreview<CR>
nnoremap <space>rl <Plug>RestNvimLast<CR>
