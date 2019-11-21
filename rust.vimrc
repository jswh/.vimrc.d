source ~/.vimrc.d/ycm.vimrc
"======================rust==========================
autocmd! filetype rust nnoremap <F5> :call RustCompilerAndRun()<cr>
function! RustCompiler()
    execute "! cargo build"
endfunction
function! RustCompilerAndRun()
    execute "! cargo run"
endfunction
