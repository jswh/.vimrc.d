source ~/.vimrc.d/coc.vimrc
source ~/.vimrc.d/snippets.vimrc
Plug 'tobyS/pdv' | Plug 'tobyS/vmustache'
Plug 'marlonfan/coc-phpls', {'do': 'yarn install --frozen-lockfile && yarn build'}
"Plug 'StanAngeloff/php.vim'
"Plug 'rayburgemeestre/phpfolding.vim'

Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile && yarn build'}

let g:php_version_id = 74300

" Don't use the PHP syntax folding
setlocal foldmethod=manual

highlight link phpDocMark CocListFgBlue
augroup phpcmd
    autocmd FileType php setlocal isk+=$
    autocmd FileType php syn match phpDocMark /@\w*/ containedin=phpDocComment
augroup END
