return {
  {
    'tpope/vim-fugitive',
    cmd = { 'G', 'Git', 'GBrowse', 'Gedit', 'Gdiffsplit', 'Gvdiffsplit' },
    keys = {
      { '<leader>ga', '<cmd>G add %<cr>', desc = '[G]it [A]dd' },
      { '<leader>gal', '<cmd>G add --all<cr>', desc = '[G]it [A]dd A[l]l' },
      { '<leader>gap', '<cmd>G add % -p<cr>', desc = '[G]it [A]dd [P]artial' },
      { '<leader>gbm', ':G branch -m ', desc = '[G]it [B]ranch [M]ove' },
      -- WARN: G commit --amend don't work with fugitive
      { '<leader>gca', '<cmd>vsplit<bar>term git commit --amend -v<cr>', desc = '[G]it [C]ommit [A]mend' },
      { '<leader>gcm', '<cmd>G commit -v<cr>', desc = '[G]it [C]o[M]mit' },
      { '<leader>gts', '<cmd>G<cr>', desc = '[G]it [S]tatus' },
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
      { '<leader>ge', ':Gedit :<cr>', desc = '[G]it [E]dit' },
      { '<leader>gb', ':GBrowse<cr>', desc = '[G]it [B]rowse' },
      { '<leader>gb', ':\'<,\'>GBrowse<cr>', mode = 'v', desc = '[G]it [B]rowse (visual)' },
      { '<leader>gv', '<cmd>vertical Git<cr>', desc = '[G]it [V]ertical' },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      attach_to_untracked = true,
      auto_attach = true,
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = { interval = 1000, follow_files = true },
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = true,
      },
      current_line_blame_formatter = '      <author>, <author_time:%R> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local gs = require('gitsigns')
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, {
            desc = 'git: ' .. desc,
            buffer = bufnr,
            silent = true,
            nowait = true,
          })
        end

        -- Navigation
        vim.keymap.set('n', ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.nav_hunk('next')
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'git: next hunk' })

        vim.keymap.set('n', '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.nav_hunk('prev')
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'git: prev hunk' })

        -- Actions
        map('n', '<leader>hs', '<cmd>Gitsigns stage_hunk<cr>', 'Stage Hunk')
        map('n', '<leader>hr', '<cmd>Gitsigns reset_hunk<cr>', 'Reset Hunk')
        map('v', '<leader>hs', ':Gitsigns stage_hunk<cr>', 'Stage Hunk (visual)')
        map('v', '<leader>hr', ':Gitsigns reset_hunk<cr>', 'Reset Hunk (visual)')
        map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<cr>', 'Stage Buffer')
        map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<cr>', 'Reset Buffer')
        map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<cr>', 'Undo Stage Hunk')
        map('n', '<leader>hU', '<cmd>Gitsigns reset_buffer_index<cr>', 'Reset Buffer Index')
        map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<cr>', 'Preview Hunk')
        map('n', '<leader>hb', function()
          gs.blame_line({ full = true })
        end, 'Blame Line')
        map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<cr>', 'Toggle Line Blame')
        map('n', '<leader>gd', gs.diffthis, 'Diff This')
        map('n', '<leader>gD', function()
          gs.diffthis('~')
        end, 'Diff This ~')

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<cr>', 'Select Hunk')
      end,
    },
  },
}
