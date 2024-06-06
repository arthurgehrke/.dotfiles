return {
  'nvim-telescope/telescope.nvim',
  lazy = false,
  cmd = { 'Telescope' },
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-lua/plenary.nvim' },
    'nvim-telescope/telescope-file-browser.nvim',
    'nvim-telescope/telescope-live-grep-args.nvim',
  },
  keys = {
    {
      '<leader>fb',
      function()
        require('telescope').extensions.file_browser.file_browser({ hidden = true, no_ignore = true, path = '%:p:h' })
      end,
      desc = '[file] [b]rowser',
    },
    {
      'ff',
      function()
        require('telescope.builtin').find_files({ hidden = true })
      end,
      desc = '[f]ind [f]iles',
    },
    {
      '<leader>fo',
      function()
        require('telescope').extensions.file_browser.file_browser({ hidden = true, path = '%:p:h' })
      end,
      desc = '[o]pen file browser',
    },
    {
      '<leader>;',
      function()
        require('telescope.builtin').live_grep()
      end,
      desc = 'Grep (root dir)',
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
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
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
        prompt_prefix = '   ',
        selection_caret = ' ',
        entry_prefix = '  ',
        multi_icon = '',
        file_sorter = require('telescope.sorters').get_fuzzy_file,
        generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
        set_env = { ['COLORTERM'] = 'truecolor' },
        results_title = false,
        color_devicons = true,
        preview = {
          treesitter = false,
        },
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
          vertical = {
            mirror = false,
          },
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
          '%.lock',
          '%.pdb',
          '%.so',
          '%.dll',
          '%.class',
          '%.exe',
          '%.cache',
          '%.pdf',
          '%.dylib',
          'dist/**',
          'build/**',
          '.git/**',
          '.next/**',
          '.undo/**',
          '.undo',
          'package%-lock.json',
          'yarn%-lock.json',
        },
        vimgrep_arguments = {
          'rg',
          '-L',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
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
            ['<Esc>'] = actions.close,
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
            ['<C-x>'] = actions.select_horizontal, -- open file in split horizontal
            ['<C-v>'] = actions.select_vertical, -- open file in split vertical
            ['<C-n>'] = actions.move_selection_next,
            ['<C-p>'] = actions.move_selection_previous,
            ['gg'] = actions.move_to_top,
            ['G'] = actions.move_to_bottom,
            ['<Esc>'] = actions.close,
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
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = 'ignore_case', -- or "ignore_case" or "respect_case", the default case_mode is "smart_case"
          hidden = true,
        },
        file_browser = {
          theme = 'ivy',
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            ['i'] = {
              -- your custom insert mode mappings
            },
            ['n'] = {
              -- your custom normal mode mappings
            },
          },
        },
      },
    })

    require('telescope').load_extension('file_browser')
    require('telescope').load_extension('fzf')
    require('telescope').load_extension('live_grep_args')
  end,
}
