Plug 'neomake/neomake'
autocmd VimEnter * call neomake#configure#automake('w', 500)
 let g:neomake_error_sign = {
     \ 'text': 'X',
     \ 'texthl': 'NeomakeErrorSign',
     \ }
 let g:neomake_warning_sign = {
     \   'text': '!!',
     \   'texthl': 'NeomakeWarningSign',
     \ }
 let g:neomake_message_sign = {
      \   'text': '>>',
      \   'texthl': 'NeomakeMessageSign',
      \ }
 let g:neomake_info_sign = {
      \ 'text': '@',
      \ 'texthl': 'NeomakeInfoSign'
      \ }
