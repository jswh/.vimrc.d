"gcc
autocmd! filetype c nnoremap <F5> :call CCompilerAndRun()<cr>
function! CCompiler()
    execute "! gcc % -o %:t:r"
endfunction
function! CCompilerAndRun()
    execute "! gcc % -o %:t:r;./%:t:r"
endfunction
