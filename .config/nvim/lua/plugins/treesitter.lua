return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  version = false,
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })()
  end,
  event = { 'BufReadPre', 'BufReadPost', 'BufNewFile' },
  cmd = {
    'TSBufDisable',
    'TSBufEnable',
    'TSBufToggle',
    'TSDisable',
    'TSEnable',
    'TSToggle',
    'TSInstall',
    'TSInstallInfo',
    'TSInstallSync',
    'TSModuleInfo',
    'TSUninstall',
    'TSUpdate',
    'TSUpdateSync',
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-refactor',
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    vim.g.skip_ts_context_commentstring_module = true
    require('ts_context_commentstring').setup({
      enable_autocmd = false,
      config = {
        javascript = {
          __default = '// %s',
          jsx_element = '{/* %s */}',
          jsx_fragment = '{/* %s */}',
          jsx_attribute = '// %s',
          comment = '// %s',
        },
        typescript = { __default = '// %s', __multiline = '/* %s */' },
      },
    })

    local opts = {
      auto_install = true,
      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 1000 * 1024
          local filetype = vim.bo[buf].filetype

          if filetype == 'tmux' then
            return false
          end

          if filetype == 'markdown' then
            return false
          end

          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      ensure_installed = {
        'bash',
        'c',
        'css',
        'dockerfile',
        'git_config',
        'gitcommit',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'json5',
        'jsonc',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'python',
        'query',
        'r',
        'rnoweb',
        'regex',
        'ruby',
        'rust',
        'scss',
        'sql',
        'ssh_config',
        'tmux',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'yaml',
        'go',
        'vue',
        'angular',
      },
      refactor = {
        highlight_definitions = { enable = false },
        highlight_current_scope = { enable = false },
        smart_rename = {
          enable = true,
          keymaps = {
            smart_rename = 'grr',
          },
        },
        navigation = {
          enable = false,
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = false,
        },
      },
    }

    if type(opts.ensure_installed) == 'table' then
      opts.ensure_installed = vim.fn.uniq(opts.ensure_installed)
    end

    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

    require('nvim-treesitter.configs').setup(opts)

    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }
  end,
}
