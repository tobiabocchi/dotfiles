syntax on

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
" set nowrap
set smartcase
set noswapfile
set nobackup
set undofile
set incsearch
set nohlsearch
set hidden
set termguicolors
set scrolloff=8
set noshowmode
set relativenumber
set visualbell

if empty(glob($HOME . '/.vim/undodir'))
    call mkdir($HOME . '/.vim/undodir', 'p')
endif

set undodir=~/.vim/undodir

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'stevearc/vim-arduino'

call plug#end()

colorscheme gruvbox

let mapleader=" "

" Disable Arrow keys in Normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

