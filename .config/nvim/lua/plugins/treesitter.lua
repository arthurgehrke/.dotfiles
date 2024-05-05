return {
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
  -- event = { 'BufReadPre', 'BufNewFile' },
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
    'nvim-treesitter/playground',
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  init = function(plugin)
    require('lazy.core.loader').add_to_rtp(plugin)
    require('nvim-treesitter.query_predicates')
  end,
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
      'bash',
      'tmux',
      'r',
      'c',
      'html',
      'javascript',
      'json',
      'lua',
      'markdown',
      'ruby',
      'rust',
      'scss',
      'markdown_inline',
      'luadoc',
      'luap',
      'markdown',
      'markdown_inline',
      'dockerfile',
      'jsdoc',
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
      'html',
      'gitcommit',
    },
    match = {
      enable = false,
    },
    matchup = { enable = false },
    -- rainbow = { enable = true, extended_mode = false },
    refactor = { highlight_definitions = { enable = true } },
    incremental_selection = {
      enable = false,
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
