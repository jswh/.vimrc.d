source ~/.vimrc.d/coc.vimrc
source ~/.vimrc.d/snippets.vimrc
autocmd! filetype python nnoremap <F5> :call PythonRun()<cr>
" use $PWD for django module import
autocmd VimEnter * call coc#config('python.analysis.extraPaths', [$PWD])
autocmd VimEnter * call coc#config('python.venvPath', "")
autocmd VimEnter * call coc#config('python.pythonPath', "")
function! PythonRun()
    execute "! python %"
endfunction

set wildignore=*.pyc
set fdm=indent

