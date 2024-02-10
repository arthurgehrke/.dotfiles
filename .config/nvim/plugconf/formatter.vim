lua << EOF
local util = require "formatter.util"
local any_formatter = require("formatter.filetypes.any")

local function conf(fn)
    return {
      function()
        return fn(vim.api.nvim_buf_get_name(0), filetype_to_extension[vim.bo.filetype] or nil)
      end,
    }
end

local stylua = conf(function()
    return {
      exe = "stylua",
      args = {
        "--indent-type",
        "Spaces",
        "--indent-width",
        "2",
        "-",
      },
      stdin = true,
    }
end)

require("formatter").setup {
  logging = true,
  log_level = vim.log.levels.WARN,
	try_node_modules = true,
  filetype = {
   -- lua = {
   --    -- Stylua
   --    function()
   --      return {
   --        exe = "stylua",
   --        args = {},
   --        stdin = false,
   --      }
   --    end,
   --  },

    lua = stylua,

    javascriptreact = { require 'formatter.defaults.prettier' },
    javascript = { require 'formatter.defaults.prettier' },

    xml = { require("formatter.filetypes.xml").tidy },

    json = { require("formatter.filetypes.json").prettierd },

    jsonc = { require("formatter.filetypes.json").prettierd },

    markdown = { require("formatter.filetypes.markdown").prettierd },
    -- html = { require 'formatter.defaults.prettierd' },
    -- css = { require 'formatter.defaults.prettierd' },

    lua = { require("formatter.filetypes.lua").stylua },

    -- python = {
    --   require("formatter.filetypes.python").black,
    -- },

    python = {
      -- require("formatter.filetypes.python").black,

      -- You can also define your own configuration
      function()
        return {
          exe = "black",
          args = { "-q", "--line-length=100", "-" },
          stdin = true,
        }
      end
    },

    sql = {
      function()
        return {
            exe = "sql-formatter",
            args = {vim.api.nvim_buf_get_name(0), "-l", "bigquery"},
            stdin = true
        }
      end
    },

    -- sql = {
    --   require("formatter.filetypes.sql").pgformat,
    -- },

    -- python = { require("formatter.filetypes.python").autopep8 },

    toml = { require("formatter.filetypes.toml").taplo },

    vim = { require("formatter.filetypes.toml").vint },

    typescriptreact = { require 'formatter.defaults.prettierd' },

    javascriptreact = { require("formatter.defaults.prettier") },
    -- typescript = { require 'formatter.defaults.prettierd' },
    typescript = { require("formatter.filetypes.typescript").prettier },

    -- yaml = { require("formatter.filetypes.yaml").prettier },

    yaml = { require("formatter.filetypes.yaml").prettierd },

    html = require("formatter.filetypes.html").prettier,
    css = require("formatter.filetypes.css").prettier,
    scss = require("formatter.filetypes.html").prettier,
    bash = {
      require("formatter.filetypes.sh").shfmt,
    },

    sh = {
      require("formatter.filetypes.sh").shfmt,
    }
  }
}

vim.keymap.set("n", "gq", "<Cmd>Format<CR>", { silent = true })
EOF

" nnoremap <silent> <space>gq :Format<CR>
nnoremap <silent> <space>gt :FormatWrite<CR>
