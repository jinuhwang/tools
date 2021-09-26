call plug#begin('~/.vim/plugged')
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
call plug#end()
lua require'nvim_lsp'.rust_analyzer.setup{on_attach=require'completion'.on_attach}
" au Filetype lua setl omnifunc=v:lua.vim.lsp.omnifunc
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

