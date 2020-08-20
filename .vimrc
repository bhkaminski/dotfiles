"NeoBundle Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

set runtimepath+=/home/brooks/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('/home/brooks/.vim/bundle'))

" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Groovy Syntax: 
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'modille/groovy.vim'

" Required:
call neobundle#end()
filetype plugin indent on

NeoBundleCheck
"End NeoBundle Scripts-------------------------


let hostname = substitute(system("hostname -s"), '\n', '', '')

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set guifont=Hack-Regular:h14
endif
colorscheme solarized

set colorcolumn=+0

" Install missing bundles
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " For all git commit messages, set 'textwidth' to 72 characters.
  autocmd FileType gitcommit setlocal textwidth=72

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  " Python files should get PEP8 white space settings
  autocmd BufNewFile,BufEnter,BufRead *.py set filetype=python
  autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab|setlocal textwidth=80

  " Python 80 line color column
  autocmd FileType python set colorcolumn=78
  autocmd FileType python highlight Colorcolumn ctermbg=6

  " C files should get our white space settings
  autocmd BufNewFile,BufEnter,BufRead *.c set filetype=c
  autocmd BufNewFile,BufEnter,BufRead *.h set filetype=c
  autocmd FileType c set tabstop=4|set shiftwidth=4|set expandtab

  " Markdown not Modula-2...
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
  autocmd FileType markdown set tabstop=4|set shiftwidth=4|set expandtab

  " Html tag files
  autocmd FileType html set tabstop=4|set shiftwidth=4|set expandtab
  autocmd FileType htmldjango set tabstop=4|set shiftwidth=4|set expandtab

  " Highlight trailing whitespace
  highlight ExtraWhitespace ctermbg=red guibg=red
  autocmd InsertEnter * match ExtraWhitespace /\s\+%#\@<!$/
  autocmd InsertLeave,BufWinEnter * match ExtraWhitespace /\s\+$/

  " Json tab-twiddler
  autocmd FileType json set tabstop=2|set shiftwidth=2|set expandtab

  " Javascript tab-twiddler
  autocmd FileType javascript set tabstop=2|set shiftwidth=2|set expandtab

  " Rust files
  autocmd FileType rust setlocal makeprg=cargo|setlocal errorformat=%f:%l:%c:%m


  " autocmd StdinReadPre * let s:std_in=1
  " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Terminals should always be dark. The light is blinding!
set bg=dark

" 4 space tabs FTW
set sw=4
set ts=4

set modeline
set modelines=5

" Use relative line numbering
set number
set relativenumber

set exrc   " enables per-directory .vimrc files
set secure " disables unsafe commands in local .vimrc files

