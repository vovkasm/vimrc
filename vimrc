filetype off
call pathogen#infect()
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
"    set guifont=Monospace\ 8
    set guifont=DejaVu\ Sans\ Mono\ 8
    set guioptions-=T
endif

set tags=tags;

" perl-syntax
let perl_fold = 1

" web-indent
" let g:js_indent_log = 0

" tidy
command -range=% -nargs=* Tidy <line1>,<line2>!perltidy

fun DoTidy()
    let Pos = line2byte( line( "." ) )
    :Tidy
    exe "goto " . Pos
endfun

" ctags
let ctags_exe = executable("exctags") == 1 ? "exctags" : "ctags"

command Ctags execute '!find . -type f -name "*.p[ml]" -print0 | xargs -0 ' . ctags_exe . ' --fields=+iaS --extra=+q .'

function SetupPerl()
  " включаем все самое умное что есть в perl :)
  setlocal expandtab autoindent smartindent

  " F2 - отформатировать код с помощью perltidy
  nmap <F2> :call DoTidy()<CR>
  vmap <F2> :Tidy<CR>

  " Генерим сtags файл по нажатию F6
  imap <F6> :Ctags<CR>
  nmap <F6> :Ctags<CR>

  " устанавливаем ограничение на длину строки в 100 символов
  setlocal textwidth=100

endfunction 

augroup FileSettings
autocmd!
" setting up for Perl
autocmd FileType perl call SetupPerl()
augroup END
