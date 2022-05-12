filetype plugin indent on

call plug#begin()
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'folke/lsp-colors.nvim'
  Plug 'joshdick/onedark.vim'
  Plug 'morhetz/gruvbox'
  Plug 'arcticicestudio/nord-vim'
  Plug 'chriskempson/base16-vim'
  Plug 'tyrannicaltoucan/vim-deep-space'
  Plug 'jpo/vim-railscasts-theme'
  Plug 'drewtempelmeyer/palenight.vim'

  Plug 'glepnir/dashboard-nvim'
  " Plug 'mhinz/vim-startify'
  Plug 'tjdevries/train.nvim'

  Plug 'asheq/close-buffers.vim'

  Plug 'nvim-lua/popup.nvim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'junegunn/vim-peekaboo'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'cohama/lexima.vim'
  Plug 'jdhao/better-escape.vim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'bkad/camelcasemotion'
  Plug 'roxma/vim-paste-easy'

  Plug 'lewis6991/gitsigns.nvim'
  Plug 'rhysd/git-messenger.vim'
  Plug 'tpope/vim-fugitive'

  Plug 'haya14busa/is.vim'
  Plug 'haya14busa/incsearch.vim'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'folke/trouble.nvim'
  Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'dense-analysis/ale'
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
  Plug 'jose-elias-alvarez/null-ls.nvim'
call plug#end()

source $HOME/.config/nvim/plugconf/vimcommentary.vim
source $HOME/.config/nvim/plugconf/lsp.vim
source $HOME/.config/nvim/plugconf/lsp_config.vim
source $HOME/.config/nvim/plugconf/nvim_lsp_installer.vim
source $HOME/.config/nvim/plugconf/nvim_lsp_ts_utils.vim
source $HOME/.config/nvim/plugconf/toggle_lsp_diagnostics.vim
source $HOME/.config/nvim/plugconf/trouble.vim
source $HOME/.config/nvim/plugconf/nvim_treesitter.vim
source $HOME/.config/nvim/plugconf/gitsigns.vim
source $HOME/.config/nvim/plugconf/lualine.vim
source $HOME/.config/nvim/plugconf/airline.vim
source $HOME/.config/nvim/plugconf/indent_blankline.vim
source $HOME/.config/nvim/plugconf/nvim_tree.vim
source $HOME/.config/nvim/plugconf/better_scape.vim
source $HOME/.config/nvim/plugconf/fzf.vim
source $HOME/.config/nvim/plugconf/camel_case_motion.vim
source $HOME/.config/nvim/plugconf/git_messenger.vim
source $HOME/.config/nvim/plugconf/fugitive.vim
source $HOME/.config/nvim/plugconf/incsearch.vim
source $HOME/.config/nvim/plugconf/ale.vim
