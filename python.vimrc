source ~/.vimrc.d/ycm.vimrc
source ~/.vimrc.d/neomake.vimrc

autocmd! filetype python nnoremap <F5> :call PythonRun()<cr>
function! PythonRun()
    execute "! python %"
endfunction
