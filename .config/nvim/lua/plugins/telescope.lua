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
      '<leader>fb',
      function()
        require('telescope').extensions.file_browser.file_browser({ hidden = true, no_ignore = true })
      end,
      desc = '[file] [b]rowser',
    },
    {
      'ff',
      function()
        require('telescope.builtin').find_files({ hidden = true, no_ignore = true })
      end,
      desc = '[f]ind [f]iles',
    },
    {
      '<leader>fo',
      function()
        require('telescope.builtin').live_grep({ hidden = true, no_ignore = true })
      end,
      desc = '[o]pen file browser',
    },
    -- {
    --   '<leader>;',
    --   function()
    --     require('telescope.builtin').live_grep({ hidden = true, no_ignore = true })
    --   end,
    --   desc = 'Grep (root dir)',
    -- },
    {
      '<leader>;',
      function()
        require('telescope').extensions.live_grep_args.live_grep_args()
      end,
      desc = 'Live Grep with args (root dir)',
    },
    {
      '<leader>fr',
      function()
        require('telescope').extensions.recent_files.pick()
      end,
    },
    {
      '<leader>+',
      function()
        require('telescope.builtin').live_grep({ cwd = false })
      end,
      desc = 'Grep (cwd)',
    },
    {
      '<leader>gs',
      function()
        require('telescope.builtin').grep_string()
      end,
      desc = 'Find word under cursor',
    },
    { '<leader>fl', '<cmd>Telescope highlights<cr>', desc = 'Find Highlights' },
    { '<leader>fz', '<cmd>Telescope zoxide list<cr>', desc = 'Find Directory' },
    {
      '<leader>gb',
      function()
        require('telescope.builtin').git_branches()
      end,
      desc = '[g]it [b]ranches',
    },
    {
      '<leader>gbd',
      function()
        vim.cmd('GitBranchesByDate')
      end,
      desc = '[g]it [b]ranches by [d]ate',
    },
    {
      '<leader>gB',
      function()
        require('telescope.builtin').git_bcommits()
      end,
      desc = '[g]it [B]uffer commits',
    },
    {
      '<leader>gc',
      function()
        require('telescope.builtin').git_commits()
      end,
      desc = '[g]it [c]ommits (repo)',
    },
    {
      '<leader>gS',
      function()
        require('telescope.builtin').git_status()
      end,
      desc = '[g]it [S]tatus',
    },
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local transform_mod = require('telescope.actions.mt').transform_mod
    local actions_state = require('telescope.actions.state')
    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local conf = require('telescope.config').values
    local lga_actions = require('telescope-live-grep-args.actions')
    local lga_shortcuts = require('telescope-live-grep-args.shortcuts')

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
          prompt_title = 'Git Branches (by last commit)',
          finder = finders.new_table({
            results = output,
          }),
          sorter = conf.generic_sorter({}),
          attach_mappings = function(prompt_bufnr, map)
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
        theme = 'dropdown',
        path_display = { 'absolute' },
        prompt_prefix = '   ',
        selection_caret = ' ',
        entry_prefix = '  ',
        multi_icon = '',
        file_sorter = require('telescope.sorters').get_fuzzy_file,
        generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
        set_env = { ['COLORTERM'] = 'truecolor' },
        results_title = false,
        color_devicons = true,
        preview = { treesitter = false },
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
          '__pycache__/*',
          'node_modules/*',
          'obj/Debug',
          'bin/Debug',
          '.dart_tool/',
          '.vscode/',
          '.pyenv/**',
          '.rbenv/**',
          '%.lock',
          '%.pdb',
          '%.so',
          '%.dll',
          '%.class',
          '.rustup/**',
          '%.exe',
          '%.cache',
          '%.pdf',
          '%.dylib',
          'dist/**',
          'build/**',
          'go/**',
          '.rye/**',
          '.git/**',
          '.next/**',
          '.undo/**',
          'undodir/**',
          '.undo',
          'package%-lock.json',
          'yarn%-lock.json',
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
          '--glob',
          '!src/**',
          '!src/**',
          '--glob',
          '!.git/',
          '--glob',
          '!node_modules/**',
        },
        mappings = {
          i = {
            ['<CR>'] = my_action.edit_or_qf,
            ['<C-e>'] = my_action.edit_or_qf,
            ['<Esc>'] = actions.close,
            ['<C-c>'] = actions.close,
            ['<C-h>'] = actions.which_key,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-n>'] = actions.move_selection_next,
            ['<C-p>'] = actions.move_selection_previous,
            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-d>'] = actions.preview_scrolling_down,
            ['<C-s>'] = actions.select_horizontal,
            ['<C-v>'] = actions.select_vertical,
            ['<C-t>'] = actions.select_tab,
          },
          n = {
            ['<Esc>'] = actions.close,
            ['<CR>'] = my_action.edit_or_qf,
            ['<C-e>'] = my_action.edit_or_qf,
            ['j'] = actions.move_selection_next,
            ['k'] = actions.move_selection_previous,
            ['n'] = actions.move_selection_next,
            ['N'] = actions.move_selection_previous,
            ['<C-n>'] = actions.move_selection_next,
            ['<C-p>'] = actions.move_selection_previous,
            ['h'] = actions.preview_scrolling_left,
            ['l'] = actions.preview_scrolling_right,
            ['gg'] = actions.move_to_top,
            ['G'] = actions.move_to_bottom,
            ['q'] = actions.close,
            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-d>'] = actions.preview_scrolling_down,
            ['<C-s>'] = actions.select_horizontal,
            ['<C-v>'] = actions.select_vertical,
            ['<C-t>'] = actions.select_tab,
            ['H'] = actions.move_to_top,
            ['M'] = actions.move_to_middle,
            ['L'] = actions.move_to_bottom,
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
          find_command = {
            'rg',
            '--files',
            '--hidden',
            '--no-ignore-vcs',
            '--glob',
            '!.git',
            '--glob',
            '!node_modules',
            '--glob',
            '!dist',
            '--glob',
            '!build',
            '--glob',
            '!target',
            '--glob',
            '!vendor',
            '--glob',
            '!*.lock',
            '--glob',
            '!package-lock.json',
            '--glob',
            '!__pycache__',
            '--glob',
            '!bin',
            '--glob',
            '!undodir',
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
          hidden = true,
        },
        file_browser = {
          theme = 'ivy',
          hijack_netrw = true,
          mappings = { ['i'] = {}, ['n'] = {} },
        },
      },
    })

    telescope.load_extension('file_browser')
    telescope.load_extension('fzf')
    telescope.load_extension('live_grep_args')
    telescope.load_extension('recent_files')
    telescope.load_extension('themes')
  end,
}
