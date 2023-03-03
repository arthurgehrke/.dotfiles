syntax on

call plug#begin()
  Plug 'folke/lsp-colors.nvim'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'windwp/nvim-autopairs'

  Plug 'lewis6991/gitsigns.nvim'
  Plug 'akinsho/git-conflict.nvim'
  Plug 'tpope/vim-rhubarb'
  Plug 'andrewradev/linediff.vim'

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'galooshi/vim-import-js'
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'vim-scripts/lastpos.vim'

  Plug 'euclidianace/betterlua.vim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
  Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
  Plug 'haya14busa/is.vim'
  Plug 'haya14busa/incsearch.vim'
call plug#end()

source $HOME/.config/nvim/plugconf/vimcommentary.vim
source $HOME/.config/nvim/plugconf/prettier.vim
source $HOME/.config/nvim/plugconf/diffview.lua
source $HOME/.config/nvim/plugconf/startify.lua
source $HOME/.config/nvim/plugconf/bufferline.lua
source $HOME/.config/nvim/plugconf/git-conflict.vim
source $HOME/.config/nvim/plugconf/lsp.lua
source $HOME/.config/nvim/plugconf/null-ls.lua
source $HOME/.config/nvim/plugconf/toggle_lsp_diagnostics.vim
source $HOME/.config/nvim/plugconf/treesitter.lua
source $HOME/.config/nvim/plugconf/gitsigns.vim
source $HOME/.config/nvim/plugconf/lualine.lua
source $HOME/.config/nvim/plugconf/indent_blankline.vim
source $HOME/.config/nvim/plugconf/nvim_tree.lua
source $HOME/.config/nvim/plugconf/better_scape.lua
source $HOME/.config/nvim/plugconf/fzf.vim
source $HOME/.config/nvim/plugconf/incsearch.vim
source $HOME/.config/nvim/plugconf/ale.vim
source $HOME/.config/nvim/plugconf/vim_import_js.vim
source $HOME/.config/nvim/plugconf/nvim-autopairs.lua
