" Do this in lua?? maybe...
" vim.o is short for something teej thinks makes sense.
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

lua << EOF
local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'
-- lspconfig.pyright.setup{}
lspconfig.clangd.setup{}

lspconfig.jedi_language_server.setup{}
lspconfig.rust_analyzer.setup{
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}


-- vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
--     if err ~= nil or result == nil then
--         return
--     end
--     if not vim.api.nvim_buf_get_option(bufnr, "modified") then
--         local view = vim.fn.winsaveview()
--         vim.lsp.util.apply_text_edits(result, bufnr)
--         vim.fn.winrestview(view)
--         if bufnr == vim.api.nvim_get_current_buf() then
--             vim.api.nvim_command("noautocmd :update")
--         end
--     end
-- end
--
-- local on_attach = function(client)
--     if client.resolved_capabilities.document_formatting then
--         vim.api.nvim_command [[augroup Format]]
--         vim.api.nvim_command [[autocmd! * <buffer>]]
--         vim.api.nvim_command [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
--         vim.api.nvim_command [[augroup END]]
--     end
-- end

lspconfig.efm.setup{
    filetypes = {'python', 'yaml', 'markdown'},
    init_options = {documentFormatting = true},
    settings = {
        rootMarkers = {".git/"},
    }
}
EOF

autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

fun! LspLocationList()
    lua vim.lsp.diagnostic.set_loclist({open_loclist = false})
endfun

nnoremap gd :lua vim.lsp.buf.definition()<CR>
nnoremap gi :lua vim.lsp.buf.implementation()<CR>
nnoremap gr :lua vim.lsp.buf.references()<CR>
nnoremap ]g :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap [g :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap K :lua vim.lsp.buf.hover()<CR>

nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vsd :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <leader>vll :call LspLocationList()<CR>

