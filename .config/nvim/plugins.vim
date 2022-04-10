filetype plugin indent on

call plug#begin()
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'majutsushi/tagbar'
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

  Plug 'junegunn/fzf.vim'
  Plug 'pechorin/any-jump.vim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope-file-browser.nvim'
  Plug 'junegunn/vim-peekaboo'
  Plug 'ntpeters/vim-better-whitespace'
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

  Plug 'folke/trouble.nvim'
  Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'dense-analysis/ale'
  Plug 'haorenW1025/completion-nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'
call plug#end()

source $HOME/.config/nvim/plugconf/vimcommentary.vim
source $HOME/.config/nvim/plugconf/tagbar.vim
source $HOME/.config/nvim/plugconf/lsp.vim
source $HOME/.config/nvim/plugconf/lsp_config.vim
source $HOME/.config/nvim/plugconf/nvim_lsp_installer.vim
source $HOME/.config/nvim/plugconf/toggle_lsp_diagnostics.vim
source $HOME/.config/nvim/plugconf/nvim_treesitter.vim
source $HOME/.config/nvim/plugconf/gitsigns.vim
source $HOME/.config/nvim/plugconf/lualine.vim
source $HOME/.config/nvim/plugconf/airline.vim
source $HOME/.config/nvim/plugconf/indent_blankline.vim
source $HOME/.config/nvim/plugconf/better_whitespace.vim
source $HOME/.config/nvim/plugconf/nvim_tree.vim
source $HOME/.config/nvim/plugconf/better_scape.vim
source $HOME/.config/nvim/plugconf/telescope.vim
source $HOME/.config/nvim/plugconf/fzf.vim
source $HOME/.config/nvim/plugconf/camel_case_motion.vim
source $HOME/.config/nvim/plugconf/git_messenger.vim
source $HOME/.config/nvim/plugconf/fugitive.vim
source $HOME/.config/nvim/plugconf/any_jump.vim
source $HOME/.config/nvim/plugconf/ale.vim
