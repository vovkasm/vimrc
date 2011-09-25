filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on
set nocompatible

set dir=~/.vimswap//,/var/tmp//,/tmp//,.
set undodir=~/.vimswap//,/var/tmp//,/tmp//,.

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set undofile

colo molokai
syntax on

if has("gui_running")
    set guifont=Monospace\ 8
endif

" perl-syntax
let perl_fold = 1

" web-indent
" let g:js_indent_log = 0
