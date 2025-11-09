set nocompatible

let g:ale_completion_enabled = 1
let g:ale_linters_ignore = ["deno", "standard", "prettier", "tslint", "xo"]

call plug#begin()
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'leafgarland/typescript-vim'
Plug 'doums/darcula'
Plug 'ledger/vim-ledger'
Plug 'dense-analysis/ale'
" Plug 'gergap/vim-ollama'
call plug#end()

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

colorscheme darcula 
syntax on

if has("gui_running")
    if has("gui_gtk2")
        "    set guifont=Monospace\ 8
        set guifont=DejaVu\ Sans\ Mono\ 8
    elseif has("gui_win32")
        set guifont=Luxi_Mono:h12:cANSI
    elseif has("gui_macvim")
"        set guifont=Menlo\ Regular:h12
        set guifont=-monospace-:h12
    endif
    set guioptions-=T
    augroup TuneColors | au!
        highlight Cursor guifg=steelblue guibg=yellow
        highlight iCursor guifg=white guibg=steelblue
        set guicursor=n-v-c:block-Cursor
        set guicursor+=i:ver100-iCursor
        set guicursor+=n-v-c:blinkon0
        set guicursor+=i:blinkwait10
    augroup END
endif

let g:XkbSwitchEnabled = 1
if has('macunix')
    let g:XkbSwitchLib = '/usr/local/lib/libInputSourceSwitcher.dylib'
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

" ledger
let g:ledger_bin = '/opt/homebrew/bin/ledger'
let g:ledger_date_format = '%Y-%m-%d'
let g:ledger_commodity_before = 0
let g:ledger_commodity_sep = ' '
au FileType ledger inoremap <silent> <Tab> <C-r>=ledger#autocomplete_and_align()<CR>
au FileType ledger vnoremap <silent> <Tab> :LedgerAlign<CR>

" Attach *.i and *.swg files to swig filetype
au BufNewFile,BufRead *.i set filetype=swig
au BufNewFile,BufRead *.swg set filetype=swig

" Attach *.bsh files (BeanShell) to java filetype (because it is java ;-)
au BufNewFile,BufRead *.bsh set filetype=java

