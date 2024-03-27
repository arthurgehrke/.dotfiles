return {
  -- dashboard
  {
    'mhinz/vim-startify',
    lazy = false,
    config = function()
      local g, cmd = vim.g, vim.cmd
      local fn = vim.fn

      g.ascii = {
        '                                                                  ',
        '                                                                  ',
        '                                                                  ',
        '                                                                  ',
        '                                                                  ',
        '  _|      _|  _|_|_|_|    _|_|    _|      _|  _|_|_|  _|      _|  ',
        '  _|_|    _|  _|        _|    _|  _|      _|    _|    _|_|  _|_|  ',
        '  _|  _|  _|  _|_|_|    _|    _|  _|      _|    _|    _|  _|  _|  ',
        '  _|    _|_|  _|        _|    _|    _|  _|      _|    _|      _|  ',
        '  _|      _|  _|_|_|_|    _|_|        _|      _|_|_|  _|      _|  ',
        '                                                                  ',
        '                                                                  ',
        '                                                                  ',
        '                                                                  ',
        '                                                                  ',
      }

      g.startify_session_dir = '~/.config/nvim/session'
      g.startify_lists = {
        { type = 'dir', header = { '         Folders' .. fn.getcwd() } },
        { type = 'files', header = { '         Recent Files' } },
        { type = 'sessions', header = { '         Sessions' } },
        { type = 'bookmarks', header = { '         Bookmarks' } },
        { type = 'commands', header = { '       גּ  Commands' } },
      }

      g.startify_bookmarks = {
        { v = '~/.config/nvim/init.vim' },
        { b = '~/.config/kitty/kitty.conf' },
        { s = '~/.zshrc' },
        { z = '~/.gitconfig' },
        { a = '~/.config/nvim/plugconf/' },
        { t = '~/.tmux.conf' },
        -- {d = "~/dotfiles"},
        -- {p = "~/CodeHub/playgrounds/playground.js"}
      }

      g.startify_custom_header = "startify#center(g:ascii)"
      g.startify_session_sort = 1
      g.startify_change_to_dir = 0
      g.startify_session_autoload = 1
      g.startify_session_delete_buffers = 0
      g.startify_session_persistence = 1
      g.startify_change_to_vcs_root = 1
      g.startify_padding_left = 6
      g.webdevicons_enable_startify = 1
      g.startify_enable_special = 1
      g.startify_files_number = 5
      g.startify_update_oldfiles = 1

      vim.g.startify_commands = {
        { f = { '  Find Word', 'Telescope live_grep' } },
        { o = { '  Find File', 'Telescope find_files' } },
        { lc = { '  Check Plugins', 'Lazy check' } },
        { ls = { '  Sync Plugins (Lazy install, clean, update)', 'Lazy sync' } },
        { ts = { '  Update Treesitter', 'TSUpdateSync' } },
        { D = { '  Diff View', 'DiffviewOpen' } },
        { G = { '  Git (Fugitive)', 'G' } },
        { ch = { '  Check Health', 'checkhealth' } },
        { m = { '  Mason', 'Mason' } },
      }

      -- Help texts should not be added to the session
      vim.g.startify_session_before_save = {
        'silent! helpclose',
        'silent! Neotree action=close',
        'silent! cclose',
        'silent! SymbolsOutlineClose',
        'silent! BuCloseDiffview',
        'silent! BuCloseFugitive',
      }

      -- barbar doesn't load immediately because it
      -- ignores the autocommands while SessionLoad is set
      vim.g.startify_session_remove_lines = { 'unlet SessionLoad' }
      vim.g.startify_session_savecmds = {
        'unlet SessionLoad',
      }
    end,
  },
}
