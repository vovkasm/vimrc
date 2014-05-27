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
"set listchars=tab:→\ ,trail:·
set listchars=tab:├┈,trail:·

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
    if has("gui_gtk2")
        "    set guifont=Monospace\ 8
        set guifont=DejaVu\ Sans\ Mono\ 8
    elseif has("gui_win32")
        set guifont=Luxi_Mono:h12:cANSI
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h9
    endif
    set guioptions-=T
endif

set tags=tags;

" perl-syntax
let perl_fold = 1

" web-indent
" let g:js_indent_log = 0

" tidy
com! -range=% -nargs=* Tidy <line1>,<line2>!perltidy

fu! DoTidy()
    let Pos = line2byte( line( "." ) )
    :Tidy
    exe "goto " . Pos
endfunc

" ctags
let ctags_exe = executable("exctags") == 1 ? "exctags" : "ctags"

com! Ctags execute '!find . -type f -name "*.p[ml]" -print0 | xargs -0 ' . ctags_exe . ' --fields=+iaS --extra=+q .'

fu! SetupPerl()
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
endfunc

augroup FileSettings
autocmd!
" setting up for Perl
autocmd FileType perl call SetupPerl()
augroup END

" Attach *.i and *.swg files to swig filetype
au BufNewFile,BufRead *.i set filetype=swig
au BufNewFile,BufRead *.swg set filetype=swig

" Attach *.bsh files (BeanShell) to java filetype (because it is java ;-)
au BufNewFile,BufRead *.bsh set filetype=java
