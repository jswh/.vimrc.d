Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile && yarn build'}
source ~/.vimrc.d/coc.vimrc
source ~/.vimrc.d/snippets.vimrc
"======================rust==========================
autocmd! filetype rust nnoremap <F5> :call RustCompilerAndRun()<cr>
function! RustCompiler()
    execute "! cargo build"
endfunction
function! RustCompilerAndRun()
    execute "! cargo run"
endfunction
