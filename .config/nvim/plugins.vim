syntax on

call plug#begin()
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'ellisonleao/gruvbox.nvim'
  Plug 'mhinz/vim-startify'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  " Plug 'windwp/nvim-autopairs'
  Plug 'jdhao/better-escape.vim'
  Plug 'akinsho/bufferline.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'sindrets/diffview.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'dense-analysis/ale'
  Plug 'galooshi/vim-import-js'
  Plug 'vim-scripts/lastpos.vim'
  Plug 'dstein64/vim-startuptime'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
  Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
  Plug 'haya14busa/is.vim'
  Plug 'haya14busa/incsearch.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'shumphrey/fugitive-gitlab.vim'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'jose-elias-alvarez/typescript.nvim'
  Plug 'mhartington/formatter.nvim'
  Plug 'samoshkin/vim-mergetool'
call plug#end()

source $HOME/.config/nvim/plugconf/lsp.vim
source $HOME/.config/nvim/plugconf/startify.vim
source $HOME/.config/nvim/plugconf/vimcommentary.vim
source $HOME/.config/nvim/plugconf/prettier.vim
source $HOME/.config/nvim/plugconf/bufferline.vim
source $HOME/.config/nvim/plugconf/diffview.vim
source $HOME/.config/nvim/plugconf/toggle_lsp_diagnostics.vim
source $HOME/.config/nvim/plugconf/nvim_treesitter.vim
source $HOME/.config/nvim/plugconf/gitsigns.vim
source $HOME/.config/nvim/plugconf/fugitive.vim
source $HOME/.config/nvim/plugconf/lualine.vim
source $HOME/.config/nvim/plugconf/indent_blankline.vim
source $HOME/.config/nvim/plugconf/nvim_tree.vim
source $HOME/.config/nvim/plugconf/better_scape.vim
source $HOME/.config/nvim/plugconf/fzf.vim
source $HOME/.config/nvim/plugconf/incsearch.vim
source $HOME/.config/nvim/plugconf/ale.vim
source $HOME/.config/nvim/plugconf/vim_import_js.vim
" source $HOME/.config/nvim/plugconf/nvim-autopairs.vim
