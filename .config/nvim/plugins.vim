filetype off
call plug#begin()
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'ryanoasis/vim-devicons'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'ellisonleao/gruvbox.nvim'
  " Plug 'folke/tokyonight.nvim'
  Plug 'tpope/vim-surround'
  Plug 'nmac427/guess-indent.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'paopaol/telescope-git-diffs.nvim'
  Plug 'nvim-telescope/telescope-ui-select.nvim'
  Plug 'nvim-telescope/telescope-live-grep-args.nvim'
  Plug 'nvim-telescope/telescope-file-browser.nvim'
  Plug 'numToStr/Comment.nvim'
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
  Plug 'jdhao/better-escape.vim'
  Plug 'akinsho/bufferline.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'sindrets/diffview.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'dstein64/vim-startuptime'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'haya14busa/is.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'shumphrey/fugitive-gitlab.vim'
  Plug 'williamboman/mason.nvim', {'do': ':MasonUpdate'} 
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'jay-babu/mason-nvim-dap.nvim'
  Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'
  Plug 'hrsh7th/nvim-cmp'         
  Plug 'hrsh7th/cmp-nvim-lsp'     
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-nvim-lsp-document-symbol',
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'mfussenegger/nvim-dap'
  Plug 'rcarriga/nvim-dap-ui'
  Plug 'folke/neodev.nvim'
  Plug 'Pocco81/DAPInstall.nvim'
  Plug 'theHamsta/nvim-dap-virtual-text'
  Plug 'mhinz/vim-startify'
  Plug 'mxsdev/nvim-dap-vscode-js'
  Plug 'tpope/vim-dadbod'
  Plug 'kristijanhusak/vim-dadbod-ui'
  Plug 'kristijanhusak/vim-dadbod-completion'
  Plug 'goolord/alpha-nvim'
  Plug 'junegunn/gv.vim'
  Plug 'b0o/schemastore.nvim'
  Plug 'rest-nvim/rest.nvim'
  Plug 'jrop/mongo.nvim'
  Plug 'bgrohman/vim-bg-tables'
  Plug 'chrisbra/csv.vim'
  Plug 'mogelbrod/vim-jsonpath'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'jalvesaq/Nvim-R'
  " Plug 'jay-babu/mason-null-ls.nvim'
  Plug 'pmizio/typescript-tools.nvim'
  " Plug 'MunifTanjim/prettier.nvim'
  " Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'axkirillov/easypick.nvim'
  Plug 'mfussenegger/nvim-lint'
  Plug 'mhartington/formatter.nvim'
call plug#end()

" source $HOME/.config/nvim/plugconf/null-ls.vim
source $HOME/.config/nvim/plugconf/lsp.vim
source $HOME/.config/nvim/plugconf/lint.vim
source $HOME/.config/nvim/plugconf/formatter.vim
source $HOME/.config/nvim/plugconf/comment.vim
source $HOME/.config/nvim/plugconf/startify.vim
source $HOME/.config/nvim/plugconf/bufferline.vim
source $HOME/.config/nvim/plugconf/diffview.vim
source $HOME/.config/nvim/plugconf/treesitter.vim
source $HOME/.config/nvim/plugconf/gitsigns.vim
source $HOME/.config/nvim/plugconf/fugitive.vim
source $HOME/.config/nvim/plugconf/lualine.vim
source $HOME/.config/nvim/plugconf/nvim-tree.vim
source $HOME/.config/nvim/plugconf/better_scape.vim
source $HOME/.config/nvim/plugconf/mason.vim
source $HOME/.config/nvim/plugconf/dap.vim
source $HOME/.config/nvim/plugconf/dadbod.vim
source $HOME/.config/nvim/plugconf/rest.vim
source $HOME/.config/nvim/plugconf/json-path.vim
source $HOME/.config/nvim/plugconf/telescope.vim
source $HOME/.config/nvim/plugconf/r.vim
source $HOME/.config/nvim/plugconf/indent_blank_line.vim
