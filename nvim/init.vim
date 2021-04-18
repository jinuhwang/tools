set path+=**
set wildmenu

" Ignore files
set wildignore+=*.pyc
set wildignore+=.git/*
set nu rnu

call plug#begin('~/.vim/plugged')

Plug 'ambv/black'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/lsp_extensions.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'rust-lang/rust.vim'

" Plug 'junegunn/gv.vim'
" Plug 'vim-utils/vim-man'
" Plug 'mbbill/undotree'
Plug 'vuciv/vim-bujo'
" Plug 'tpope/vim-dispatch'
" Plug 'theprimeagen/vim-be-good'
" Plug '/home/theprimeagen/personal/af-pluth-pluth'
Plug 'gruvbox-community/gruvbox'
" Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'tpope/vim-projectionist'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'colepeters/spacemacs-theme.vim'

Plug 'sainnhe/gruvbox-material'
Plug 'phanviet/vim-monokai-pro'
Plug 'flazz/vim-colorschemes'
Plug 'chriskempson/base16-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
" Plug '/home/mpaulson/personal/VimDeathmatch/client'

" Plug 'ThePrimeagen/neovim-irc-ui'

" prettier
Plug 'sbdchd/neoformat'

Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
" Plug 'bling/vim-bufferline'
" Plug 'vim-airline/vim-airline'
" Plug 'edkolev/tmuxline.vim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

Plug 'preservim/nerdtree'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'wellle/context.vim'
" Plug 'rust-lang/rust.vim'
" Plug 'morhetz/gruvbox'

" Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
" Plug 'SirVer/ultisnips'
" Plug 'dense-analysis/ale'

call plug#end()            " required

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

nnoremap <space> <Nop>
let mapleader = " "

nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>bs /<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>
" nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :Ex<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" greatest remap ever
vnoremap <leader>p "_dP

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <leader>d "_d
vnoremap <leader>d "_d

" vim TODO
nmap <Leader>tu <Plug>BujoChecknormal
nmap <Leader>th <Plug>BujoAddnormal
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

nnoremap <c-f> :NERDTreeFind<CR>
nnoremap <leader>n :NERDTreeToggle<CR>

inoremap <C-c> <esc>

fun! EmptyRegisters()
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
        call setreg(r, [])
    endfor
endfun

" ES
com! W w

nmap <leader>nn :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup JINU
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END
