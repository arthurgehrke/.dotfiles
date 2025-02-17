return {
  {
    'tpope/vim-fugitive',
    lazy = true,
    event = 'VeryLazy',
    keys = {
      { '<leader>ga', '<cmd>G add %<cr>', desc = '[G]it [A]dd' },
      { '<leader>gal', '<cmd>G add --all<cr>', desc = '[G]it [A]dd A[l]l' },
      { '<leader>gap', '<cmd>G add % -p<cr>', desc = '[G]it [A]dd [P]artial' },
      { '<leader>gbm', ':G branch -m ', desc = '[G]it [B]ranch [M]ove' },
      -- WARN: G commit --amend don't work with fugitive
      { '<leader>gca', '<cmd>vsplit<bar>term git commit --amend -v<cr>', desc = '[G]it [C]ommit [A]mend' },
      { '<leader>gcm', '<cmd>G commit -v<cr>', desc = '[G]it [C]o[M]mit' },
      { '<leader>g', '<cmd>:G<cr>', desc = '[G]it' },
      { '<leader>gfa', '<cmd>G fetch --all -p<cr>', desc = '[G]it [F]etch [A]ll' },
      { '<leader>gi', '<cmd>G init<cr>', desc = '[G]it [I]nit' },
      { '<leader>gma', '<cmd>G merge --abort<cr>', desc = '[G]it [M]erge [A]bort' },
      { '<leader>gm', ':G merge --no-ff --no-edit ', desc = '[G]it [M]erge' },
      { '<leader>gp', '<cmd>G push<cr>', desc = '[G]it [P]ush' },
      { '<leader>gpf', '<cmd>G push origin -f HEAD<cr>', desc = '[G]it [P]ush origin [F]orce' },
      { '<leader>gpl', '<cmd>G pull<cr>', desc = '[G]it [P]u[l]l' },
      { '<leader>gpo', '<cmd>G push origin -u HEAD<cr>', desc = '[G]it [P]ush [O]rigin' },
      { '<leader>gu', ':G reset --soft HEAD~1', desc = '[G]it [U]ndo' },
      { '<leader>sum', ':G stash -um ', desc = 'Git [S]tash [UM]' },
      { '<Leader>ge', ':Gedit :<CR>' },
      { '<Leader>gb', ':GBrowse<CR>' },
      { '<Leader>gb', ':\'<,\'>GBrowse<CR>', mode = 'v' },
      { '<leader>gv', '<cmd>vertical Git<CR>', { desc = 'fugitive' } },
    },
  },
  { 'akinsho/git-conflict.nvim', version = '*', config = true, lazy = true, event = 'VeryLazy' },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local gitsigns = require('gitsigns')

      local function gitsigns_keymap_attach(bufnr)
        local function opts(desc)
          return { desc = 'git: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        vim.keymap.set('n', ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gitsigns.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })

        vim.keymap.set('n', '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gitsigns.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })

        vim.keymap.set('n', '<space>hr', '<cmd>Gitsigns reset_hunk<CR>', opts('Reset Hunk'))
        vim.keymap.set('n', '<space>hR', '<cmd>Gitsigns reset_buffer<CR>', opts('Reset Buffer'))
        vim.keymap.set('n', '<space>hp', '<cmd>Gitsigns preview_hunk<CR>', opts('Preview Hunk'))
        vim.keymap.set('n', '<space>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', opts('Blame Line'))
        vim.keymap.set('n', '<space>hs', '<cmd>Gitsigns stage_hunk<CR>', opts('Stage Hunk'))
        vim.keymap.set('n', '<space>hS', '<cmd>Gitsigns stage_buffer<CR>', opts('Stage Buffer'))
        vim.keymap.set('n', '<space>hU', '<cmd>Gitsigns reset_buffer_index<CR>', opts('Reset Buffer Index'))
        vim.keymap.set('n', '<space>hu', '<cmd>Gitsigns undo_stage_hunk<CR>', opts('Undo Staging Hunk'))
        vim.keymap.set('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>', opts('Toggle Current Line Blame'))

        vim.keymap.set({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

        vim.keymap.set('v', '<space>hr', ':Gitsigns reset_hunk<CR>', opts('ResetHunk (Visual)'))
        vim.keymap.set('v', '<space>hs', ':Gitsigns stage_hunk<CR>', opts('StageHunk (Visual)'))
        vim.keymap.set('n', '<leader>gd', gitsigns.diffthis)
        vim.keymap.set('n', '<leader>gD', function()
          gitsigns.diffthis('~')
        end)
      end

      gitsigns.setup({
        signs = {
          add = { text = '│' },
          change = { text = '│' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
          untracked = { text = '┆' },
        },
        -- signcolumn = true,
        -- numhl = false,
        -- linehl = false,
        -- word_diff = false,
        -- update_debounce = 50,
        -- watch_gitdir = {
        --   interval = 1000,
        --   follow_files = true,
        -- },
        attach_to_untracked = true,
        auto_attach = true,
        on_attach = gitsigns_keymap_attach,
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = { interval = 1000, follow_files = true },
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = true,
        },
        current_line_blame_formatter = '      <author>, <author_time:%R> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000,
        preview_config = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1,
        },
      })
    end,
  },
}
