local actions = require('telescope.actions')
local transform_mod = require('telescope.actions.mt').transform_mod
local actions_layout = require('telescope.actions.layout') -- 自定义 key mapping 用
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

require('telescope').setup({
  defaults = {
    theme = 'dropdown',
    prompt_prefix = ' ❯ ',
    color_devicons = true,
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
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'descending',
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = {
      '__pycache__/',
      '__pycache__/*',
      'build/',
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
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    layout_strategy = 'horizontal',
    preview = {
      treesitter = false,
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
    pickers = {
      find_files = {
        hidden = true,
        find_command = {
          'rg',
          '--files',
          '--iglob',
          '!.git',
          '--hidden',
          '!{**/.git/*,**/node_modules/*,**/package-lock.json,**/yarn.lock}',
        },
        theme = 'dropdown',
      },
      live_grep = {
        theme = 'dropdown',
        preview = {
          treesitter = false,
        },
        additional_args = function(opts)
          return { '--hidden' }
        end,
      },
    },
    grep_string = {
      additional_args = { '--hidden' },
    },
    live_grep = {
      additional_args = { '--hidden' },
    },
    commands = {
      theme = 'dropdown',
      sort_mru = true,
      sort_lastused = true,
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = 'smart_case', -- or "ignore_case" or "respect_case", the default case_mode is "smart_case"
        hidden = true,
      },
      file_browser = {
        theme = 'ivy',
        hidden = true,
        respect_gitignore = false,
        select_buffer = true,
        grouped = true,
        auto_depth = true,
        cwd_to_path = true,
        path = '%:p:h',
        prompt_path = true,
        hijack_netrw = true,
      },
      git_diffs = {
        git_command = { 'git', 'log', '--oneline', '--decorate', '--all', '.' }, -- list result
      },
    },
  },
})

require('telescope').load_extension('fzy_native')
require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')
require('telescope').load_extension('file_browser')
