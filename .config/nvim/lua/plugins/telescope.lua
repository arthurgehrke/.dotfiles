return {
  'nvim-telescope/telescope.nvim',
  lazy = false,
  cmd = { 'Telescope' },
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-lua/plenary.nvim' },
    { 'smartpde/telescope-recent-files' },
    'nvim-telescope/telescope-file-browser.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    'andrew-george/telescope-themes',
  },
  keys = {
    {
      'fb',
      function()
        require('telescope').extensions.file_browser.file_browser({ hidden = true })
      end,
      desc = 'File Browser',
    },
    {
      'ff',
      function()
        require('telescope.builtin').find_files({ hidden = true, no_ignore = true })
      end,
      desc = 'Find Files',
    },
    {
      '<leader>fF',
      function()
        require('telescope.builtin').find_files({ hidden = true })
      end,
      desc = 'Find Files (respeita .gitignore)',
    },
    {
      '<leader>;',
      function()
        require('telescope').extensions.live_grep_args.live_grep_args({
          additional_args = { '--fixed-strings' },
        })
      end,
      desc = 'Live Grep Args (literal)',
    },
    {
      '<leader>fe',
      function()
        require('telescope').extensions.live_grep_args.live_grep_args()
      end,
      desc = 'Live Grep Args (regex)',
    },
    { '<leader>tr', '<cmd>Telescope resume<cr>', desc = 'Telescope Resume' },
    {
      '<leader>f;',
      function()
        require('telescope').extensions.live_grep_args.live_grep_args({
          additional_args = { '--fixed-strings' },
        })
      end,
      desc = 'Live Grep Literal',
    },
    {
      '<leader>+',
      function()
        require('telescope.builtin').live_grep({ cwd = false })
      end,
      desc = 'Grep CWD',
    },
    {
      '<leader>gs',
      function()
        require('telescope.builtin').grep_string()
      end,
      desc = 'Find Word Cursor',
    },
    { '<leader>fl', '<cmd>Telescope highlights<cr>', desc = 'Find Highlights' },
    {
      '<leader>gb',
      function()
        require('telescope.builtin').git_branches()
      end,
      desc = 'Git Branches',
    },
    {
      '<leader>gbd',
      function()
        vim.cmd('GitBranchesByDate')
      end,
      desc = 'Git Branches By Date',
    },
    {
      '<leader>gB',
      function()
        require('telescope.builtin').git_bcommits()
      end,
      desc = 'Git Buffer Commits',
    },
    {
      '<leader>gc',
      function()
        require('telescope.builtin').git_commits()
      end,
      desc = 'Git Commits Repo',
    },
    {
      '<leader>gS',
      function()
        require('telescope.builtin').git_status()
      end,
      desc = 'Git Status',
    },
  },
  config = function()
    local builtin = require('telescope.builtin')
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local transform_mod = require('telescope.actions.mt').transform_mod
    local actions_state = require('telescope.actions.state')
    local lga_actions = require('telescope-live-grep-args.actions')

    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local previewers = require('telescope.previewers')
    local sorters = require('telescope.sorters')

    local function tokens(prompt)
      local t = {}
      for tok in prompt:gmatch('%S+') do
        table.insert(t, tok:lower())
      end
      return t
    end

    local function buffer_line_multigrep(opts)
      opts = opts or {}
      local bufnr = vim.api.nvim_get_current_buf()
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local ft = vim.bo[bufnr].filetype
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

      local results = {}
      for i, line in ipairs(lines) do
        results[#results + 1] = { lnum = i, text = line }
      end

      local title = bufname ~= '' and vim.fn.fnamemodify(bufname, ':t') or '[No Name]'

      pickers.new(opts, {
        prompt_title = 'Line Multi Grep — ' .. title,
        finder = finders.new_table({
          results = results,
          entry_maker = function(item)
            return {
              value = item,
              display = string.format('%5d  %s', item.lnum, item.text),
              ordinal = item.text,
              lnum = item.lnum,
              text = item.text,
            }
          end,
        }),
        sorter = sorters.Sorter:new({
          scoring_function = function(_, prompt, _, entry)
            if not prompt or prompt == '' then
              return 1
            end
            local hay = entry.text:lower()
            for _, tok in ipairs(tokens(prompt)) do
              if not hay:find(tok, 1, true) then
                return -1
              end
            end
            return 1
          end,
          highlighter = function(_, prompt, display)
            local positions = {}
            if not prompt or prompt == '' then
              return positions
            end
            local lower = display:lower()
            local prefix_offset = display:find('%S%s') or 0
            for _, tok in ipairs(tokens(prompt)) do
              local from = 1
              while true do
                local s, e = lower:find(tok, from, true)
                if not s then break end
                if s > prefix_offset then
                  for i = s, e do
                    positions[#positions + 1] = i
                  end
                end
                from = e + 1
              end
            end
            return positions
          end,
        }),
        previewer = previewers.new_buffer_previewer({
          title = 'Line Preview',
          get_buffer_by_name = function() return bufname ~= '' and bufname or 'line-multigrep' end,
          define_preview = function(self, entry)
            vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
            if ft and ft ~= '' then
              pcall(vim.api.nvim_buf_set_option, self.state.bufnr, 'filetype', ft)
            end
            vim.schedule(function()
              if not vim.api.nvim_win_is_valid(self.state.winid) then return end
              pcall(vim.api.nvim_win_set_cursor, self.state.winid, { entry.lnum, 0 })
              vim.api.nvim_win_call(self.state.winid, function()
                vim.cmd('normal! zz')
              end)
            end)
          end,
        }),
        attach_mappings = function(prompt_bufnr, _)
          actions.select_default:replace(function()
            local entry = actions_state.get_selected_entry()
            actions.close(prompt_bufnr)
            if entry and entry.lnum then
              vim.api.nvim_win_set_cursor(0, { entry.lnum, 0 })
              vim.cmd('normal! zz')
            end
          end)
          return true
        end,
      }):find()
    end

    vim.keymap.set('n', '<leader>fg', buffer_line_multigrep, { desc = 'Line Multi Grep (buffer)' })

    local make_entry = require('telescope.make_entry')

    local function dir_line_multigrep(opts)
      opts = opts or {}
      opts.cwd = opts.cwd or vim.uv.cwd()
      local base_entry_maker = make_entry.gen_from_vimgrep(opts)
      local current_tokens = {}

      local finder = finders.new_async_job({
        command_generator = function(prompt)
          if not prompt or prompt == '' then return nil end
          current_tokens = tokens(prompt)
          if #current_tokens == 0 then return nil end
          return {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--ignore-case',
            '--hidden',
            '--glob=!.git/',
            '--glob=!node_modules/',
            '--glob=!dist/',
            '--glob=!build/',
            '--glob=!.next/',
            '--glob=!undodir/',
            '-F',
            '--',
            current_tokens[1],
          }
        end,
        entry_maker = function(line)
          local entry = base_entry_maker(line)
          if not entry then return nil end
          if #current_tokens > 1 then
            local hay = (entry.text or ''):lower()
            for i = 2, #current_tokens do
              if not hay:find(current_tokens[i], 1, true) then
                return nil
              end
            end
          end
          return entry
        end,
        cwd = opts.cwd,
      })

      pickers.new(opts, {
        debounce = 100,
        prompt_title = 'Dir Line Multi Grep — ' .. vim.fn.fnamemodify(opts.cwd, ':t'),
        finder = finder,
        previewer = require('telescope.config').values.grep_previewer(opts),
        sorter = sorters.empty(),
      }):find()
    end

    vim.keymap.set('n', '<leader>fa', dir_line_multigrep, { desc = 'Line Multi Grep (dir)' })

    vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = '#504945', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = '#83a598', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'TelescopeTitle', { fg = '#1d2021', bg = '#83a598', bold = true })

    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      })
    end, { desc = 'Search Open Files' })

    vim.keymap.set('n', '<leader>sf', function()
      builtin.find_files({ hidden = true })
    end, { desc = 'Search Files' })

    vim.keymap.set('n', '<leader>trw', function()
      require('telescope').extensions.live_grep_args.live_grep_args({
        additional_args = function()
          return { '--fixed-strings' }
        end,
      })
    end, {})

    vim.keymap.set('n', '<leader>sg', function()
      require('telescope').extensions.live_grep_args.live_grep_args({
        additional_args = function()
          return { '--hidden' }
        end,
      })
    end, {})

    vim.keymap.set('n', '<leader>sh', function()
      require('telescope').extensions.live_grep_args.live_grep_args({ cwd = vim.fn.expand('~') })
    end, { desc = 'Search Home' })

    local my_action = transform_mod({
      edit_or_qf = function(prompt_bufnr)
        local picker = actions_state.get_current_picker(prompt_bufnr)
        local selected_items = picker:get_multi_selection()
        if #selected_items == 0 then
          actions.select_default(prompt_bufnr)
        else
          actions.send_selected_to_qflist(prompt_bufnr)
          vim.cmd('copen')
        end
      end,
    })

    telescope.setup({
      defaults = {
        path_display = { 'truncate' },
        prompt_prefix = '   ',
        selection_caret = ' ',
        entry_prefix = '  ',
        multi_icon = '󰒍 ',
        set_env = { ['COLORTERM'] = 'truecolor' },
        results_title = false,
        color_devicons = true,
        preview = { treesitter = false, filesize_limit = 1 }, -- 1 MB
        sorting_strategy = 'descending',
        selection_strategy = 'follow',
        layout_strategy = 'horizontal',
        layout_config = {
          prompt_position = 'top',
          horizontal = {
            prompt_position = 'top',
            mirror = false,
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = { mirror = false },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_ignore_patterns = {
          '%.lock$',
          '%.pdf$',
          '%.dylib$',
          '%.exe$',
          '%.so$',
          '%.pdb$',
          '%.class$',
        },
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden',
          '--glob=!.git/',
          '--glob=!node_modules/',
          '--glob=!dist/',
          '--glob=!build/',
          '--glob=!.next/',
          '--glob=!.dart_tool/',
          '--glob=!.undo/',
          '--glob=!undodir/',
          '--glob=!*.lock',
        },
        mappings = {
          i = {
            ['<CR>'] = my_action.edit_or_qf,
            ['<C-e>'] = my_action.edit_or_qf,
            ['<esc>'] = actions.close,
            ['<C-n>'] = actions.move_selection_next,
            ['<C-p>'] = actions.move_selection_previous,
            ['<C-x>'] = false,
            ['<C-u>'] = false,
            ['<C-d>'] = false,
            ['<C-c>'] = actions.close,
            ['<C-s>'] = actions.select_horizontal,
            ['<C-v>'] = actions.select_vertical,
            ['<C-t>'] = actions.select_tab,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
          },
          n = {
            ['<ESC>'] = actions.close,
            ['<CR>'] = my_action.edit_or_qf,
            ['<C-e>'] = my_action.edit_or_qf,
            ['<C-x>'] = actions.select_horizontal,
            ['<C-v>'] = actions.select_vertical,
            ['<C-n>'] = actions.move_selection_next,
            ['<C-p>'] = actions.move_selection_previous,
            ['gg'] = actions.move_to_top,
            ['G'] = actions.move_to_bottom,
            ['j'] = actions.move_selection_next,
            ['k'] = actions.move_selection_previous,
            ['H'] = actions.move_to_top,
            ['M'] = actions.move_to_middle,
            ['L'] = actions.move_to_bottom,
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
        initial_mode = 'insert',
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      },
      pickers = {
        buffers = {
          sort_mru = true,
        },
        live_grep = {
          preview = true,
          debounce = 100,
        },
        grep_string = { preview = true },
        man_pages = { sections = { '2', '3' } },
        lsp_document_symbols = { path_display = { 'hidden' } },
        find_files = {
          theme = 'ivy',
          hidden = true,
          find_command = {
            'fd',
            '--type',
            'f',
            '--type',
            'l',
            '--hidden',
            '--follow',
            '--exclude',
            '.git',
            '--exclude',
            'node_modules',
            '--exclude',
            'dist',
            '--exclude',
            'build',
            '--exclude',
            '.next',
            '--exclude',
            '.dart_tool',
            '--exclude',
            'undodir',
            '--exclude',
            '.undo',
            '--exclude',
            '.cache',
            '--exclude',
            '.venv',
            '--exclude',
            '__pycache__',
            '--exclude',
            'target',
            '--exclude',
            '.DS_Store',
          },
        },
      },
      extensions = {
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ['<c-\\>'] = lga_actions.quote_prompt({ postfix = ' --hidden ' }),
            },
          },
        },
        themes = {
          layout_config = {
            horizontal = { width = 0.8, height = 0.7 },
          },
          enable_previewer = true,
          persist = {
            enabled = true,
            path = vim.fn.stdpath('config') .. '/lua/colorscheme.lua',
          },
        },
        recent_files = {},
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'ignore_case',
        },
        file_browser = {
          theme = 'ivy',
          hijack_netrw = true,
          mappings = { ['i'] = {}, ['n'] = {} },
        },
      },
    })

    telescope.load_extension('fzf')
    telescope.load_extension('file_browser')
    telescope.load_extension('live_grep_args')
    telescope.load_extension('recent_files')
    telescope.load_extension('themes')
  end,
}
