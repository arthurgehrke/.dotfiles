return {
  'nvim-treesitter/nvim-treesitter',
  -- event = 'VeryLazy',
  version = false,
  lazy = false,
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })()
  end,
  -- event = { 'BufReadPre', 'BufNewFile' },
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
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  opts = {
    auto_install = true,
    highlight = {
      enable = true,
      disable = function(_, buf)
        local max_filesize = 1000 * 1024 -- 1000 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    autopairs = {
      enable = false,
    },
    fold = { enable = false },
    endwise = {
      enable = false,
    },
    autotag = {
      enable = false,
    },
    ensure_installed = {
      'markdown',
      'markdown_inline',
      'r',
      'rnoweb',
      'tmux',
      'html',
      'javascript',
      'json',
      'jsonc',
      'jsdoc',
      'json5',
      'lua',
      'ruby',
      'rust',
      'scss',
      'luadoc',
      'luap',
      'dockerfile',
      'python',
      'query',
      'regex',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'ssh_config',
      'r',
      'sql',
      'yaml',
      'c',
      'bash',
      'gitcommit',
      'git_config',
    },
    match = {
      enable = false,
    },
    matchup = { enable = false },
    refactor = { highlight_definitions = { enable = true } },
    incremental_selection = {
      enable = false,
    },
    context_commentstring = {
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
    },
  },
  ---@param opts TSConfig
  config = function(_, opts)
    if type(opts.ensure_installed) == 'table' then
      ---@type table<string, boolean>
      local added = {}
      opts.ensure_installed = vim.tbl_filter(function(lang)
        if added[lang] then
          return false
        end
        added[lang] = true
        return true
      end, opts.ensure_installed)
    end
    vim.api.nvim_set_option_value('foldmethod', 'expr', {})
    vim.api.nvim_set_option_value('foldexpr', 'nvim_treesitter#foldexpr()', {})
    require('nvim-treesitter.configs').setup(opts)
  end,
}
