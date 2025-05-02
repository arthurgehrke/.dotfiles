return {
  {
    'mhinz/vim-startify',
    lazy = false,
    enabled = true,
    config = function()
      local g, cmd = vim.g, vim.cmd
      local fn = vim.fn

      g.ascii = {
        ' ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
        ' ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
        ' ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
        ' ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
        ' ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
        ' ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
      }

      g.startify_custom_header = fn['startify#pad'](g.ascii)

      g.startify_session_dir = '~/.config/nvim/session'
      g.startify_lists = {
        { type = 'dir', header = { '   Projetos Recentes (' .. fn.getcwd() .. ')' } },
        { type = 'files', header = { '   Arquivos Recentes' } },
        { type = 'commands', header = { '   Comandos Rápidos' } },
      }

      g.startify_commands = {
        { f = { '  Find File', 'Telescope find_files' } },
        { r = { '  Find Word', 'Telescope live_grep' } },
        { G = { '  Git Status (Fugitive)', 'G' } },
        { D = { '  Diff View', 'DiffviewOpen' } },
        { ts = { '  Treesitter Update', 'TSUpdateSync' } },
        { ch = { '  Check Health', 'checkhealth' } },
        { lc = { '  Check Plugins', 'Lazy check' } },
        { ls = { '  Sync Plugins', 'Lazy sync' } },
        { m = { '  Mason', 'Mason' } },
        { l = { '  Lazy UI', 'Lazy' } },
      }

      g.startify_session_sort = 1
      g.startify_change_to_dir = 0
      g.startify_session_autoload = 1
      g.startify_session_delete_buffers = 0
      g.startify_session_persistence = 1
      g.startify_change_to_vcs_root = 1
      g.startify_padding_left = 6
      g.webdevicons_enable_startify = 1
      g.startify_enable_special = 1
      g.startify_files_number = 10
      g.startify_update_oldfiles = 1

      vim.g.startify_session_before_save = {
        'silent! helpclose',
        'silent! Neotree action=close',
        'silent! cclose',
        'silent! SymbolsOutlineClose',
        'silent! BuCloseDiffview',
        'silent! BuCloseFugitive',
      }

      vim.g.startify_session_remove_lines = { 'unlet SessionLoad' }
      vim.g.startify_session_savecmds = {
        'unlet SessionLoad',
      }
    end,
  },
}
