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

      local launch_file = fn.stdpath('data') .. '/launch_history'
      local launch_max = 30

      local function read_launches()
        if fn.filereadable(launch_file) == 0 then
          return {}
        end
        return fn.readfile(launch_file)
      end

      local launches = read_launches()

      local function record_launch()
        local targets = {}
        for _, arg in ipairs(fn.argv()) do
          table.insert(targets, (fn.fnamemodify(arg, ':p'):gsub('/$', '')))
        end
        if #targets == 0 then
          targets = { fn.getcwd() }
        end

        local entries, seen = {}, {}
        for _, p in ipairs(vim.list_extend(targets, read_launches())) do
          if p ~= '' and not seen[p] then
            seen[p] = true
            table.insert(entries, p)
          end
        end
        fn.writefile(vim.list_slice(entries, 1, launch_max), launch_file)
      end

      record_launch()

      local function launch_list()
        local items = {}
        for _, p in ipairs(launches) do
          local is_dir = fn.isdirectory(p) == 1
          if is_dir or fn.filereadable(p) == 1 then
            local e = fn.fnameescape(p)
            table.insert(items, {
              line = fn.fnamemodify(p, ':~') .. (is_dir and '/' or ''),
              cmd = is_dir and ('cd ' .. e .. ' | edit ' .. e) or ('edit ' .. e),
            })
          end
        end
        return items
      end

      g.startify_session_dir = '~/.config/nvim/session'
      g.startify_lists = {
        { type = 'dir', header = { '   Projetos Recentes (' .. fn.getcwd() .. ')' } },
        { type = 'files', header = { '   Arquivos Recentes' } },
        { type = 'commands', header = { '   Comandos Rápidos' } },
        { type = launch_list, header = { '   󰋚  Lançamentos do Nvim' } },
      }

      g.startify_commands = {
        { f = { '  Find File', 'Telescope find_files' } },
        { r = { '  Find Word', 'Telescope live_grep' } },
        { G = { '  Git Status (Fugitive)', 'G' } },
        { ts = { '  Treesitter Update', 'TSUpdate' } },
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
        'silent! cclose',
        'silent! BuCloseFugitive',
      }

      vim.g.startify_session_remove_lines = { 'unlet SessionLoad' }
      vim.g.startify_session_savecmds = {
        'unlet SessionLoad',
      }
    end,
  },
}
