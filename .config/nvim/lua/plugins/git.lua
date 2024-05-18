return {
  {
    'kdheepak/lazygit.nvim',
    lazy = false,
    config = function()
      vim.g.lazygit_floating_window_scaling_factor = 1.0
    end,
  },
  {
    'tpope/vim-fugitive',
    lazy = false,
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
      { '<Leader>gb', ":'<,'>GBrowse<CR>", mode = 'v' },
      { '<leader>gv', '<cmd>vertical Git<CR>', { desc = 'fugitive' } },
      {
        '<leader>gg',
        function()
          Util.terminal({ 'lazygit' }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false })
        end,
        { desc = 'Lazygit (root dir)' },
      },
      {
        '<leader>gG',
        function()
          Util.terminal({ 'lazygit' }, { esc_esc = false, ctrl_hjkl = false })
        end,
        { desc = 'Lazygit (cwd)' },
      },
    },
  },
  { 'akinsho/git-conflict.nvim', version = '*', config = true, lazy = false },
  {
    'NeogitOrg/neogit',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration
      'nvim-telescope/telescope.nvim', -- optional
    },
    config = true,
  },
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

        vim.keymap.set('v', '<space>hr', ':Gitsigns reset_hunk<CR>', opts('ResetHunk (Visual)'))
        vim.keymap.set('v', '<space>hs', ':Gitsigns stage_hunk<CR>', opts('StageHunk (Visual)'))
        vim.keymap.set('n', '<leader>gd', gitsigns.diffthis)
        vim.keymap.set('n', '<leader>gD', function()
          gitsigns.diffthis('~')
        end)
      end

      gitsigns.setup({
        signs = {
          add = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
          change = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
          delete = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
          topdelete = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
          changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        },
        signcolumn = true,
        attach_to_untracked = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        on_attach = gitsigns_keymap_attach,
      })
    end,
  },
}
