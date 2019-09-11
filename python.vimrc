autocmd! filetype python nnoremap <F5> :call PythonRun()<cr>
function! PythonRun()
    execute "! python %"
endfunction
