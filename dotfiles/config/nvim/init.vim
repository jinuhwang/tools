set path+=**

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu

" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

source ~/.config/nvim/plug.vim

" Adding local modules
" let &runtimepath.=',' . expand("$HOME") . '/personal/nvim-treesitter-context'
" let &runtimepath.=',' . expand("$HOME") . '/personal/tree-navigation'

" let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]

lua require("jinu")
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1
let mapleader = " "

" nnoremap <silent> Q <nop>
" nnoremap <silent> <C-f> :silent !tmux neww tmux-sessionizer<CR>

" nnoremap <leader>vwh :h <C-R>=expand("<cword>")<CR><CR>
" nnoremap <leader>bs /<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>
" nnoremap <leader>u :UndotreeShow<CR>
" nnoremap <leader>pv :Ex<CR>
" nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
" nnoremap <Leader>+ :vertical resize +5<CR>
" nnoremap <Leader>- :vertical resize -5<CR>
" nnoremap <Leader>rp :resize 100<CR>
" nnoremap <Leader>ee oif err != nil {<CR>return nil, err<CR>}<CR><esc>kkI<esc>
" nnoremap <Leader>cpu a%" PRIu64 "<esc>
" nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
" nnoremap <leader>gt <Plug>PlenaryTestFile
" nnoremap <leader>vwm :lua require("vim-with-me").init()<CR>
" nnoremap <leader>dwm :lua require("vim-with-me").disconnect()<CR>
" nnoremap <leader>gll :let g:_search_term = expand("%")<CR><bar>:Gclog -- %<CR>:call search(g:_search_term)<CR>
" nnoremap <leader>gln :cnext<CR>:call search(_search_term)<CR>
" nnoremap <leader>glp :cprev<CR>:call search(_search_term)<CR>
" nnoremap <leader>nf :!./scripts/format.py %

" nnoremap <leader>x :silent !chmod +x %<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" nnoremap Y yg$
" nnoremap n nzzzv
" nnoremap N Nzzzv
" nnoremap J mzJ`z

" Replace with yanked buffer
xnoremap <leader>p "_dP

" Copy to OS clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nmap <leader>Y "+Y

" Remove without effecting register
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" vim TODO
nmap <Leader>tu <Plug>BujoChecknormal
nmap <Leader>th <Plug>BujoAddnormal
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

" nnoremap <Leader>ww ofunction wait(ms: number): Promise<void> {<CR>return new Promise(res => setTimeout(res, ms));<CR>}<esc>k=i{<CR>

" ES
" com! W w

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup THE_PRIMEAGEN
    autocmd!
    " autocmd BufWritePre *.lua Neoformat
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END

nnoremap <space> <Nop>
let mapleader = " "

nnoremap <c-f> :NERDTreeFind<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
