require("rest-nvim").setup({
  result_split_horizontal = false,
  skip_ssl_verification = true,
  highlight = {
    enabled = true,
    timeout = 150,
  },
  jump_to_request = false,
  result = {
    -- toggle showing URL, HTTP info, headers at top the of result window
    show_url = true,
    -- show the generated curl command in case you want to launch
    -- the same request via the terminal (can be verbose)
    show_curl_command = false,
    show_http_info = true,
    show_headers = true,
    -- executables or functions for formatting response body [optional]
    -- set them to false if you want to disable them
    formatters = {
      json = "jq",
      html = function(body)
      return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
      end
    },
  },
})
