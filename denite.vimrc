Plug 'Shougo/denite.nvim'
" denite trigger mapping, can be changed in project vimrc
nnoremap <c-p> :Denite buffer file/rec -split=floating<cr>
nnoremap <a-p> :Denite buffer file -split=floating<cr>
nnoremap <a-f> :Denite line -split=floating<cr>
" grep source uses ripgrep which respect the .gitignore and automatically skip hidden files/directories and binary files
nnoremap <a-h> :Denite grep:::! -split=floating<cr>

inoremap <c-p> <esc>:Denite buffer file/rec -split=floating<cr>
inoremap <a-p> <esc>:Denite buffer -split=floating<cr>
