source ~/.vimrc.d/coc.vimrc
source ~/.vimrc.d/snippets.vimrc
Plug 'neoclide/coc-tabnine', {'do': 'yarn install --frozen-lockfile'}
autocmd VimEnter * call coc#config('ignore_all_lsp', "true")
" Don't use the PHP syntax folding
setlocal foldmethod=manual

highlight link phpDocMark CocListFgBlue
augroup phpcmd
    autocmd FileType php setlocal isk+=$
    autocmd FileType php syn match phpDocMark /@\w*/ containedin=phpDocComment
augroup END
