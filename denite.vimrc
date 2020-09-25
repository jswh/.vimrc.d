Plug 'Shougo/denite.nvim'
" denite trigger mapping, can be changed in project vimrc
nnoremap <c-p> :Denite buffer file/rec -split=floating<cr>
nnoremap <A-p> :Denite buffer file -split=floating<cr>
nnoremap <D-p> :Denite buffer file -split=floating<cr>
nnoremap <A-f> :Denite line -split=floating<cr>
nnoremap <D-f> :Denite line -split=floating<cr>
" grep source uses ripgrep which respect the .gitignore and automatically skip hidden files/directories and binary files
nnoremap <A-h> :Denite grep:::! -split=floating<cr>
nnoremap <D-h> :Denite grep:::! -split=floating<cr>

inoremap <c-p> <esc>:Denite buffer file/rec -split=floating<cr>
inoremap <A-p> <esc>:Denite buffer -split=floating<cr>
inoremap <D-p> <esc>:Denite buffer -split=floating<cr>
