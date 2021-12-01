call plug#begin()
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'majutsushi/tagbar'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  
  Plug 'mhartington/oceanic-next'
  Plug 'joshdick/onedark.vim'
  Plug 'morhetz/gruvbox'
  Plug 'arcticicestudio/nord-vim'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'ayu-theme/ayu-vim'

  Plug 'mhinz/vim-startify'
  Plug 'tjdevries/train.nvim'

  Plug 'kazhala/close-buffers.nvim'
  
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'junegunn/vim-peekaboo'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'cohama/lexima.vim'
  Plug 'jdhao/better-escape.vim'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  Plug 'nvim-lua/plenary.nvim'
  Plug 'lewis6991/gitsigns.nvim'

  Plug 'haorenW1025/completion-nvim'
  Plug 'neovim/nvim-lspconfig'
call plug#end()

source $HOME/.config/nvim/plugconf/vimcommentary.vim
source $HOME/.config/nvim/plugconf/fzfvim.vim
source $HOME/.config/nvim/plugconf/tagbar.vim
source $HOME/.config/nvim/plugconf/lsp.vim
source $HOME/.config/nvim/plugconf/gitsigns.vim
source $HOME/.config/nvim/plugconf/lualine.vim
source $HOME/.config/nvim/plugconf/airline.vim
source $HOME/.config/nvim/plugconf/indent_blankline.vim
source $HOME/.config/nvim/plugconf/better_whitespace.vim
source $HOME/.config/nvim/plugconf/nvim_tree.vim
source $HOME/.config/nvim/plugconf/better_scape.vim
source $HOME/.config/nvim/plugconf/telescope.vim

