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

Plug 'dracula/vim'
"Plug 'patstockwell/vim-monokai-tasty'
Plug 'itchyny/lightline.vim'
    set laststatus=2
    set noshowmode
    let g:lightline = {
        \ 'colorscheme': 'dracula',
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

Plug 'kyazdani42/nvim-web-devicons' | Plug 'kyazdani42/nvim-tree.lua'
    let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache', 'vendor', '.pyc' ]
    let g:nvim_tree_gitignore = 1
    let g:nvim_tree_auto_open = 1
    let g:nvim_tree_auto_close = 1
    let g:nvim_tree_auto_ignore_ft = [ 'startify', 'dashboard' ]
    let g:nvim_tree_follow = 1
    let g:nvim_tree_indent_markers = 1
    let g:nvim_tree_highlight_opened_files = 1
    let g:nvim_tree_add_trailing = 1

    nnoremap dir :NvimTreeToggle<CR>
    nnoremap dif :NvimTreeFindFile<CR>

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
"source ~/.vimrc.d/denite.vimrc
source ~/.vimrc.d/telescope.vimrc
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
elseif filereadable("requirements")
    source ~/.vimrc.d/python.vimrc
    autocmd VimEnter * echo expand("loaded language config: python")
endif
Plug 'Konfekt/FastFold'
Plug 'ryanoasis/vim-devicons'
call plug#end()
"===================plugin end=======================
lua << EOF
require("telescope").setup {
  defaults = {
    -- Your defaults config goes in here
  },
  pickers = {
    -- Your special builtin config goes in here
    buffers = {
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
          -- Right hand side can also be the name of the action as a string
          ["<c-d>"] = "delete_buffer",
        },
        n = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
        }
      }
    },
    find_files = {
      theme = "dropdown"
    }
  },
  prompt_prefix = "🔍 ",
  extensions = {
    -- Your extension config goes in here
  }
}
EOF
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
"colorscheme vim-monokai-tasty
colorscheme dracula
hi Normal guibg=NONE ctermbg=NONE
hi Folded guibg=NONE ctermbg=NONE ctermfg=3 guifg=DarkCyan
hi VertSplit cterm=NONE gui=NONE ctermfg=61 ctermbg=NONE guifg=#6272A4 guibg=NONE
