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
    'nvim-telescope/telescope-frecency.nvim',
  },
  keys = {
    {
      '<leader>fb',
      function()
        require('telescope').extensions.file_browser.file_browser({ hidden = true, no_ignore = true })
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
      '<leader>fo',
      function()
        require('telescope.builtin').live_grep({ hidden = true, no_ignore = true })
      end,
      desc = 'Live Grep',
    },
    {
      '<leader>;',
      function()
        require('telescope').extensions.live_grep_args.live_grep_args()
      end,
      desc = 'Live Grep Args Root',
    },
    {
      '<leader>f;',
      function()
        require('telescope').extensions.live_grep_args.live_grep_args({
          vimgrep_arguments = vim.tbl_extend(
            'force',
            require('telescope.config').values.vimgrep_arguments,
            { '--fixed-strings' }
          ),
        })
      end,
      desc = 'Live Grep Literal',
    },
    {
      '<leader>fr',
      function()
        require('telescope').extensions.recent_files.pick()
      end,
      desc = 'Recent Files',
    },
    {
      '<leader>fc',
      function()
        require('telescope').extensions.frecency.frecency({})
      end,
      desc = 'Frecency',
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
    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local conf = require('telescope.config').values
    local lga_actions = require('telescope-live-grep-args.actions')
    local builtin = require('telescope.builtin')

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

    local function git_branches_by_date()
      local output = vim.fn.systemlist(
        'git for-each-ref --sort=-committerdate --format=\'%(refname:short) %(committerdate:relative)\' refs/heads/'
      )

      pickers
        .new({}, {
          prompt_title = 'Git Branches By Date',
          finder = finders.new_table({
            results = output,
          }),
          sorter = conf.generic_sorter({}),
          attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = actions_state.get_selected_entry()[1]
              local branch = vim.split(selection, ' ')[1]
              vim.cmd('Git checkout ' .. branch)
            end)
            return true
          end,
        })
        :find()
    end

    vim.api.nvim_create_user_command('GitBranchesByDate', git_branches_by_date, {})

    telescope.setup({
      defaults = {
        path_display = { 'truncate' },
        prompt_prefix = '   ',
        selection_caret = ' ',
        entry_prefix = '  ',
        multi_icon = '󰒍 ',
        file_sorter = require('telescope.sorters').get_fuzzy_file,
        generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
        set_env = { ['COLORTERM'] = 'truecolor' },
        results_title = false,
        color_devicons = true,
        preview = { treesitter = true },
        sorting_strategy = 'ascending',
        selection_strategy = 'reset',
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
          '__pycache__/',
          'node_modules/',
          '.dart_tool/',
          '.vscode/',
          '.git/',
          '.next/',
          '.undo/',
          'undodir/',
          '%.lock',
          '%.pdf',
          '%.dylib',
          '%.exe',
          '%.so',
          '%.pdb',
          '%.class',
          'dist/',
          'build/',
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
          '--no-ignore-vcs',
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
          mappings = {
            i = { ['<c-d>'] = actions.delete_buffer },
          },
        },
        live_grep = { preview = true },
        grep_string = { preview = true },
        man_pages = { sections = { '2', '3' } },
        lsp_document_symbols = { path_display = { 'hidden' } },
        lsp_workspace_symbols = { path_display = { 'shorten' } },
        find_files = {
          hidden = true,
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
          hidden = true,
        },
        file_browser = {
          theme = 'ivy',
          hijack_netrw = true,
          mappings = { ['i'] = {}, ['n'] = {} },
        },
        frecency = {
          show_scores = false,
          show_unindexed = true,
          ignore_patterns = { '*.git/*', '*/tmp/*' },
          disable_devicons = false,
        },
      },
    })

    telescope.load_extension('file_browser')
    telescope.load_extension('fzf')
    telescope.load_extension('live_grep_args')
    telescope.load_extension('recent_files')
    telescope.load_extension('themes')
    telescope.load_extension('frecency')
  end,
}
