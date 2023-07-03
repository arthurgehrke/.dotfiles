syntax on

call plug#begin()
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-lualine/lualine.nvim'
  " Plug 'ellisonleao/gruvbox.nvim'
  Plug 'EdenEast/nightfox.nvim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'tpope/vim-surround'
  Plug 'numToStr/Comment.nvim'
  " Plug 'windwp/nvim-autopairs'
  Plug 'jdhao/better-escape.vim'
  Plug 'akinsho/bufferline.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'sindrets/diffview.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'dstein64/vim-startuptime'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
  Plug 'haya14busa/is.vim'
  Plug 'haya14busa/incsearch.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'shumphrey/fugitive-gitlab.vim'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'jay-babu/mason-null-ls.nvim'
  Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'
  Plug 'jay-babu/mason-nvim-dap.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'jose-elias-alvarez/typescript.nvim'
  Plug 'samoshkin/vim-mergetool'
  Plug 'airblade/vim-gitgutter'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'amarakon/nvim-cmp-buffer-lines'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
  Plug 'nmac427/guess-indent.nvim'
  Plug 'mfussenegger/nvim-dap'
  Plug 'mxsdev/nvim-dap-vscode-js'
  Plug 'rcarriga/nvim-dap-ui'
  Plug 'Pocco81/DAPInstall.nvim'
  Plug 'theHamsta/nvim-dap-virtual-text'
  " Plug 'mhinz/vim-startify'
  Plug 'mxsdev/nvim-dap-vscode-js'
  Plug 'rhysd/git-messenger.vim'
  Plug 'tpope/vim-dadbod'
  Plug 'kristijanhusak/vim-dadbod-ui'
  Plug 'kristijanhusak/vim-dadbod-completion'
  Plug 'tpope/vim-dotenv'
  Plug 'goolord/alpha-nvim'
  Plug 'junegunn/gv.vim'
call plug#end()

source $HOME/.config/nvim/plugconf/lsp.vim
source $HOME/.config/nvim/plugconf/comment.vim
" source $HOME/.config/nvim/plugconf/startify.vim
source $HOME/.config/nvim/plugconf/alpha.vim
source $HOME/.config/nvim/plugconf/bufferline.vim
source $HOME/.config/nvim/plugconf/diffview.vim
source $HOME/.config/nvim/plugconf/toggle_lsp_diagnostics.vim
source $HOME/.config/nvim/plugconf/nvim_treesitter.vim
source $HOME/.config/nvim/plugconf/gitsigns.vim
source $HOME/.config/nvim/plugconf/git-messenger.vim
source $HOME/.config/nvim/plugconf/fugitive.vim
source $HOME/.config/nvim/plugconf/lualine.vim
source $HOME/.config/nvim/plugconf/indent_blankline.vim
source $HOME/.config/nvim/plugconf/nvim_tree.vim
source $HOME/.config/nvim/plugconf/better_scape.vim
source $HOME/.config/nvim/plugconf/fzf.vim
source $HOME/.config/nvim/plugconf/incsearch.vim
source $HOME/.config/nvim/plugconf/gitgutter.vim
source $HOME/.config/nvim/plugconf/guess-indent.vim
source $HOME/.config/nvim/plugconf/mason.vim
source $HOME/.config/nvim/plugconf/dap.vim
source $HOME/.config/nvim/plugconf/dadbod.vim
" source $HOME/.config/nvim/plugconf/dotenv.vim
