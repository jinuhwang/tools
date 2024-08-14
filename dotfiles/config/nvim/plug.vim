call plug#begin('~/.vim/plugged')

" lsp Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim' " Completion pictogram
Plug 'nvim-lua/lsp_extensions.nvim'

Plug 'glepnir/lspsaga.nvim'
Plug 'simrat39/symbols-outline.nvim' " Tree shaped simbols

" Neovim Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'

" Debugger Plugins
Plug 'mfussenegger/nvim-dap'
Plug 'Pocco81/dap-buddy.nvim' " Installer
Plug 'szw/vim-maximizer'

" Snippets
Plug 'L3MON4D3/LuaSnip'
" Plug 'rafamadriz/friendly-snippets' " C, python

Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " Extension for GitHub
Plug 'junegunn/gv.vim' " Git browser
" Plug 'mbbill/undotree'
Plug 'tpope/vim-dispatch' " Better compile tools
Plug 'gruvbox-community/gruvbox'
Plug 'luisiacc/gruvbox-baby'
" Plug 'tpope/vim-projectionist' " Project configuration
Plug 'vuciv/vim-bujo' " Vim TODO
" Plug 'vim-utils/vim-man'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'


" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim' " lua function helper
Plug 'nvim-telescope/telescope.nvim' " Picker, sorter, previewer
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'flazz/vim-colorschemes' " colorschemes shop

" prettier
Plug 'sbdchd/neoformat' " Formatter

" should I try another status bar???
"  Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
" Plug 'hoob3rt/lualine.nvim'

call plug#end()
