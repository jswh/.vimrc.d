source ~/.vimrc.d/coc.vimrc
source ~/.vimrc.d/snippets.vimrc
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-vetur', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
"======================typescript&javascript==========================
autocmd BufNewFile,BufRead *.ts,*.tsx,*.js,*.jsx setlocal tabstop=2 shiftwidth=2

