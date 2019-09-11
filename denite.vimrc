Plug 'Shougo/denite.nvim'
" denite trigger mapping, can be changed in project vimrc
nnoremap <c-p> :Denite buffer file/rec<cr>
nnoremap <a-p> :Denite buffer file<cr>
nnoremap <a-f> :Denite line<cr>
" grep source uses ripgrep which respect the .gitignore and automatically skip hidden files/directories and binary files
nnoremap <a-h> :Denite grep:::!<cr>

inoremap <c-p> <esc>:Denite buffer file/rec<cr>
inoremap <a-p> <esc>:Denite buffer<cr>
