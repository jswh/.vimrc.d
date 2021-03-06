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
set fdm=indent
set fml=3
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
"augroup FastEscape
"    autocmd!
"    au InsertEnter * set timeoutlen=150
"    au InsertLeave * set timeoutlen=100
"augroup END
" set path to started path
autocmd VimEnter * setlocal path=$PWD
filetype plugin indent on

augroup AutoSaveFolds
  autocmd!
  autocmd BufWrite *.* mkview
  autocmd BufRead *.* silent! loadview
augroup END
if (has("termguicolors"))
    set termguicolors
endif
"====================plugin start=========================
call plug#begin("~/.vim/bundle")
"====================theme plugin=========================
Plug 'Asheq/close-buffers.vim'

Plug 'junegunn/vim-emoji'
" A solid language color pack for Vim. (syntax, indent, ftplugin)
Plug 'sheerun/vim-polyglot'
    let g:polyglot_disabled = []

"Plug 'dracula/vim'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'itchyny/lightline.vim'


    set laststatus=2
    set noshowmode
    let g:lightline = {
        \ 'colorscheme': 'monokai_tasty',
        \ 'active': {
        \   'left': [
        \       ['mode', 'paste'],
        \       ['gitbranch'],
        \       ['readonly', 'absolutepath'],
        \   ],
        \   'right': [
        \       ['filetype','fileencoding'],
        \       ['cocstatus'],
        \   ]
        \ },
        \ 'inactive': {'right': []},
        \ 'component_function': {
        \   'giticon': 'GitIcon',
        \   'gitbranch': 'GitBranch',
        \   'filename': 'LightlineFilename',
        \   'session': 'SessionStatus',
        \   'cocstatus': 'coc#status',
        \   'readonly': 'LightlineReadonly',
        \ },
    \}

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
        return branch !=# '' ?  ' '.branch  : ' N/N'
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
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'scrooloose/nerdtree'
    let g:NERDTreeIgnore=['\.pyc$', '\.vim$', '\~$', '\.out']
    autocmd BufWinEnter * silent NERDTreeMirror
    nnoremap dir :NERDTreeToggle<CR>
    nnoremap dif :NERDTreeFind<CR>

    let g:NERDTreeDirArrowExpandable = '▶'
    let g:NERDTreeDirArrowCollapsible = '◿'
    let g:NERDTreeMouseMode = 2
    let g:NERDTreeAutoDeleteBuffer = 1
    let NERDTreeShowBookmarks =1
    let NERDTreeMinimalUI = 1
    let NERDTreeDirArrows = 1

" Plug 'vim-vdebug/vdebug'
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
" a fuzzy finder, use ctrl-p.
source ~/.vimrc.d/denite.vimrc
" enable project .vimrc
if getcwd() != expand('~') && filereadable(".vimrc")
    source .vimrc
    let g:NERDTreeBookmarksFile = $HOME . "/.vim/bundle/nerdtree/." . join(split(fnamemodify('.vimrc', ':p:h'), '/'), '.') . ".nerdtree-bookmarks"
    execute "silent !touch " . g:NERDTreeBookmarksFile
    autocmd VimEnter * echo expand("loaded project vimrc $PWD/.vimrc")
elseif filereadable("Cargo.toml")
    source ~/.vimrc.d/rust.vimrc
    autocmd VimEnter * echo expand("loaded language config: rust")
elseif filereadable('package.json')
    source ~/.vimrc.d/javascript.vimrc
    autocmd VimEnter * echo expand("loaded language config: javascript")
elseif filereadable("composer.json")
    source ~/.vimrc.d/php.vimrc
    autocmd VimEnter * echo expand("loaded language config: php")
endif
Plug 'Konfekt/FastFold'
Plug 'ryanoasis/vim-devicons'
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

call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])
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
let ignore=&wildignore . ',*.pyc,.git,.hg,.svn'
call denite#custom#var('file/rec', 'command',
\ ['scantree.py', '--path', ':directory',
\  '--ignore', ignore])
"===================keybinding=======================
"move window
nnoremap wh <c-w>h
nnoremap wj <c-w>j
nnoremap wk <c-w>k
nnoremap wl <c-w>l

"edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"mapping system copy/past
inoremap <leader>v <esc>"+pa
nnoremap <leader>v "+pa
vnoremap <leader>c "+y

autocmd BufWritePre * :%s/\s\+$//e
nnoremap <leader>q :bprevious<CR>:bdelete #<CR>

"===================theme settings=======================
colorscheme vim-monokai-tasty
hi Normal guibg=NONE ctermbg=NONE
hi Folded guibg=NONE ctermbg=NONE ctermfg=3 guifg=DarkCyan
hi VertSplit cterm=NONE gui=NONE ctermfg=61 ctermbg=NONE guifg=#6272A4 guibg=NONE

" WSL yank support
let s:clip = '/mnt/c/WINDOWS/system32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
nnoremap <leader>e :!notepad2 %<cr>
