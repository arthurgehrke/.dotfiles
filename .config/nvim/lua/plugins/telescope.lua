return {
  'nvim-telescope/telescope.nvim',
  lazy = false,
  cmd = { 'Telescope' },
  dependencies = {
    { 'nvim-lua/popup.nvim' },
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-file-browser.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-symbols.nvim' },
    'nvim-telescope/telescope-symbols.nvim',
    'jvgrootveld/telescope-zoxide',
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-fzy-native.nvim', build = 'make' },
  },
  keys = {
    {
      '<leader>fb',
      -- stylua: ignore
      function() require("telescope").extensions.file_browser.file_browser({ hidden = true, no_ignore = true, path = "%:p:h" }) end,
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
      -- stylua: ignore
      function() require("telescope").extensions.file_browser.file_browser({ hidden = true, no_ignore = true, path = "%:p:h" }) end,
      desc = '[o]pen file browser',
    },
    {
      '<leader>;',
      function()
        require('telescope.builtin').live_grep({
          additional_args = function(args)
            return vim.list_extend(args, { '--hidden', '--no-ignore' })
          end,
        })
      end,
      desc = 'Find words',
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
    -- {
    --   '<leader>;',
    --   function()
    --     require('telescope.builtin').live_grep({
    --       default_text = vim.fn.expand('<cword>'),
    --     })
    --   end,
    --   desc = 'Grep cursor word',
    -- },
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local actions_layout = require('telescope.actions.layout')
    local transform_mod = require('telescope.actions.mt').transform_mod
    local actions_state = require('telescope.actions.state')

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
        theme = 'dropdown',
        prompt_prefix = ' ❯ ',
        color_devicons = true,
        preview = {
          treesitter = false,
        },
        file_sorter = require('telescope.sorters').get_fuzzy_file,
        file_ignore_patterns = {
          '__pycache__/',
          '__pycache__/*',
          'build/',
          'dist/',
          'gradle/',
          'node_modules/',
          'node_modules/*',
          'obj/Debug',
          'bin/Debug',
          '.dart_tool/',
          '.git/',
          '.vscode/',
          '%.lock',
          '%.pdb',
          '%.so',
          '%.dll',
          '%.class',
          '%.exe',
          '%.cache',
          '%.pdf',
          '%.dylib',
          'node_modules',
          'dist/**',
          'build/**',
          '.git/**',
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
          '--multiline',
          '--only-matching',
          '--follow',
        },
        mappings = { -------------------------------------------------------------- {{{
          i = {
            ['<CR>'] = my_action.edit_or_qf,
            ['<C-e>'] = my_action.edit_or_qf,
            ['<C-x>'] = actions.select_horizontal, -- open file in split horizontal
            ['<C-v>'] = actions.select_vertical, -- open file in split vertical

            ['<esc>'] = actions.close,
            ['<C-n>'] = actions.move_selection_next,
            ['<C-p>'] = actions.move_selection_previous,

            ['<C-u>'] = false, -- NOTE: 为了在 insert 模式下使用 <C-u> 清空 input, 不能使用 nil.
            ['<C-d>'] = false,

            ['<C-l>'] = actions.send_selected_to_qflist + actions.open_qflist,
          },

          n = {
            ['<ESC>'] = actions.close,
            ['<CR>'] = my_action.edit_or_qf,
            ['<C-e>'] = my_action.edit_or_qf,
            ['<C-x>'] = actions.select_horizontal, -- open file in split horizontal
            ['<C-v>'] = actions.select_vertical, -- open file in split vertical
            --["<C-t>"] = actions.select_tab,  -- open file in new tab

            ['<C-n>'] = actions.move_selection_next,
            ['<C-p>'] = actions.move_selection_previous,

            ['gg'] = actions.move_to_top,
            ['G'] = actions.move_to_bottom,
            --["M"] = actions.move_to_middle,

            ['<C-u>'] = false,
            ['<C-d>'] = false,

            ['<S-Up>'] = actions.results_scrolling_up,
            ['<S-Down>'] = actions.results_scrolling_down,
            --- actions.results_scrolling_left(), actions.results_scrolling_right()

            ['<Tab>'] = actions.toggle_selection + actions.move_selection_next,
            ['<S-Tab>'] = actions_layout.cycle_layout_next, -- layout window

            --- NOTE: put all <tab> selected files to quickfix list.
            ['<C-l>'] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
        initial_mode = 'insert',
        selection_strategy = 'reset',
        sorting_strategy = 'descending',
        layout_strategy = 'horizontal',
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = 'smart_case', -- or "ignore_case" or "respect_case", the default case_mode is "smart_case"
          hidden = true,
        },
        zoxide = {
          prompt_title = '[ Zoxide directories ]',
          mappings = {
            default = {
              action = function(selection)
                vim.cmd.tcd(selection.path)
              end,
              after_action = function(selection)
                vim.notify("Current working directory set to '" .. selection.path .. "'", vim.log.levels.INFO)
              end,
            },
          },
        },
      },
    })

    require('telescope').load_extension('live_grep_args')
    require('telescope').load_extension('file_browser')
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('fzy_native')
    require('telescope').load_extension('zoxide')
    require('telescope').load_extension('live_grep_args')
  end,
}
