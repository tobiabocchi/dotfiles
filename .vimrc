syntax on

set nocompatible
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set number
set nu
set smartcase
set noswapfile
set nobackup
set undofile
set incsearch
set nohlsearch
set hidden
set scrolloff=8
set relativenumber
set visualbell
set path+=**
set wildmenu

command! MakeTags !ctags -R

if empty(glob($HOME . '/.vim/undodir'))
    call mkdir($HOME . '/.vim/undodir', 'p')
endif

set undodir=~/.vim/undodir

" Delete empty space from the end of lines on every save
autocmd BufWritePre * :%s/\s\+$//e

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'gruvbox-community/gruvbox'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'stevearc/vim-arduino'
Plug 'tpope/vim-fugitive'
Plug 'luochen1990/rainbow'

call plug#end()

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

colorscheme gruvbox
set background=dark

let mapleader=" "

" Easier movement between split windows CTRL + {h, j, k, l}
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Save shortcut
nnoremap <silent><leader>w :w<CR>
nnoremap <silent><leader>q :q<CR>

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

