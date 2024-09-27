return {
  {
    'mhinz/vim-startify',
    lazy = false,
    enabled = true,
    config = function()
      local g, cmd = vim.g, vim.cmd
      local fn = vim.fn

      g.ascii = {
        '███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
        '████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
        '██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
        '██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
        '██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
        '╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
        '╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
        '╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
      }

      g.startify_session_dir = '~/.config/nvim/session'
      g.startify_lists = {
        { type = 'dir', header = { '         Folders' .. fn.getcwd() } },
        { type = 'files', header = { '         Recent Files' } },
        { type = 'commands', header = { '       גּ  Commands' } },
      }

      g.startify_custom_header = 'startify#center(g:ascii)'
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
        { f = { '  Find File', 'Telescope find_files' } },
        { r = { '  Find Word', 'Telescope live_grep' } },
        { lc = { '  Check Plugins', 'Lazy check' } },
        { ls = { '  Sync Plugins (Lazy install, clean, update)', 'Lazy sync' } },
        { ts = { '  Update Treesitter', 'TSUpdateSync' } },
        { D = { '  Diff View', 'DiffviewOpen' } },
        { G = { '  Git (Fugitive)', 'G' } },
        { ch = { '  Check Health', 'checkhealth' } },
        { m = { '  Mason', 'Mason' } },
        { l = {'Lazy', ':Lazy'}},
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
