"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

"====================theme setting=========================
set nocompatible
set mouse=a
set encoding=utf-8
set t_Co=256
set ff=unix

set textwidth=0 wrapmargin=0
set nu ruler
set list listchars=tab:┆\ ,trail:·
set tabstop=4 shiftwidth=4 expandtab
set completeopt-=preview
syntax on
" insert mode - line
let &t_SI .= "\<Esc>[5 q"
"replace mode - underline
let &t_SR .= "\<Esc>[3 q"
"common - block
let &t_EI .= "\<Esc>[1 q"
"====================edit setting=========================
let mapleader = "\\"

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

set autoindent autoread autowrite autowriteall
set ignorecase smartcase
set splitbelow splitright


set ttimeoutlen=1
augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=250
    au InsertLeave * set timeoutlen=200
augroup END
" set path to started path
autocmd VimEnter * setlocal path=$PWD/**
filetype plugin indent on

augroup AutoSaveFolds
  autocmd!
  autocmd BufWrite *.* mkview
  autocmd BufRead *.* silent! loadview
augroup END
"====================plugin start=========================
call plug#begin("~/.vim/bundle")
"====================theme plugin=========================
Plug 'ayu-theme/ayu-vim' " or other package manager
    set termguicolors     " enable true colors support
    "let ayucolor="light"  " for light version of theme
    let ayucolor="mirage" " for mirage version of theme
    "let ayucolor="dark"   " for dark version of theme
    colorscheme ayu
    highlight Normal guifg=#D9D7CE guibg=#2d2d2d

Plug 'junegunn/vim-emoji'
" A solid language color pack for Vim. (syntax, indent, ftplugin)
Plug 'sheerun/vim-polyglot'
    let g:polyglot_disabled = []

Plug 'itchyny/lightline.vim'
    set laststatus=2
    set noshowmode
    let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'active': {
        \   'left': [
        \       ['mode', 'paste'],
        \       ['readonly', 'absolutepath'],
        \   ],
        \   'right': [
        \       ['gitbranch'],
        \       ['filetype','fileencoding'],
        \       ['cocstatus'],
        \   ]
        \ },
        \ 'inactive': {'right': []},
        \ 'component_function': {
        \   'gitbranch': 'GitBranch',
        \   'filename': 'LightlineFilename',
        \   'session': 'SessionStatus',
        \   'cocstatus': 'coc#status',
        \   'readonly': 'LightlineReadonly',
        \ },
    \}

    let g:lightline.separator = { 'left': '', 'right': '' }
    let g:lightline.subseparator = { 'left': '', 'right': '' }
    let g:lightline#onedark#disable_bold_style=1
    function! SessionStatus()
        let s = ObsessionStatus()
        let mapping = {'[$]':' ▶ ', '[S]':' ⏸ '}
        return s !=# '' ? get(mapping, s) : ' ⏺ '
    endfunction
    function! LightlineReadonly()
        return &readonly && &filetype !=# 'help' ? '🔒' : ''
    endfunction

    function! GitBranch()
        let branch = fugitive#head()
        return branch !=# '' ? ' ' . branch : 'N/N'
    endfunction

    function! LightlineFilename()
        let filename = expand('%:t') !=# '' ? expand('%:t') : '[N/N]'
        let modified = &modified ? ' +' : ''
        return filename . modified
    endfunction
"====================basic plugin=========================

" git wraper plugin, user G*** command like Gstatus,Gcommit
Plug 'tpope/vim-fugitive'
" nerdtree: user `dir` to open file tree
" nerdtree-git-plugin show git status of file in nerdtree
" nerdtree-tabs keep nerdtree status as the same in all tabs
Plug 'jistr/vim-nerdtree-tabs' | Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'scrooloose/nerdtree'
    let g:NERDTreeIgnore=['\.pyc$', '\.vim$', '\~$', '\.out']
    nnoremap dir :NERDTreeTabsToggle<cr>
    nnoremap dif :NERDTreeTabsFind<cr>

    let g:NERDTreeDirArrowExpandable = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'
    let g:NERDTreeMouseMode = 2
    let g:NERDTreeAutoDeleteBuffer = 1
" show git status of line in status column
Plug 'airblade/vim-gitgutter'
" autoclose of <> {} '' etc
Plug 'Raimondi/delimitMate'
" align text, use :Tab /=
Plug 'godlygeek/tabular'
" run command in vim async mode
Plug 'skywind3000/asyncrun.vim'
" use .sync file to do sync task
Plug 'eshion/vim-sync'
    autocmd BufWritePost * :call SyncUploadFile()
" a fuzzy finder, use ctrl-p
source ~/.vimrc.d/denite.vimrc
" enable project .vimrc
if filereadable(expand("$PWD/.vimrc"))
    source $PWD/.vimrc
    autocmd VimEnter * echo expand("loaded project vimrc $PWD/.vimrc")
endif
call plug#end()
"===================plugin end=======================
" denite buffer mapping not change for project
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> <esc> denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <esc> <Plug>(denite_filter_quit)
endfunction
" Ripgrep command on grep source
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
        \ ['-i', '--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
"===================keybinding=======================
" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"move window
nnoremap wh <c-w>h
nnoremap wj <c-w>j
nnoremap wk <c-w>k
nnoremap wl <c-w>l

"edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

autocmd BufWritePre * :%s/\s\+$//e

