" General vim/nvim settings
set nocompatible            " Not compatible with vi
filetype plugin indent on   " Enable filetype plugins
syntax enable               " Enable syntax highlighting

" Display options
set number                  " Show line numbers
set relativenumber          " Show relative line numbers
set cursorline              " Highlight current line
set cursorcolumn            " Highlight current column
set colorcolumn=88          " Highlight column 88 (Python PEP8)
set textwidth=88            " Set text width
set linebreak               " Wrap lines at word boundaries
set showmatch               " Show matching brackets
set showcmd                 " Show partial command in status line
set wildmenu                " Command line completion
set laststatus=2            " Always show status line
set scrolloff=3             " Keep 3 lines visible when scrolling

" Indentation
set autoindent              " Auto indent
set smartindent             " Smart indent
set expandtab               " Use spaces instead of tabs
set tabstop=4               " Number of spaces per tab
set softtabstop=4           " Number of spaces when editing
set shiftwidth=4            " Number of spaces for indent
set shiftround              " Round indent to multiple of shiftwidth

" Search options
set ignorecase              " Ignore case in search
set smartcase               " But become case-sensitive if uppercase
set hlsearch                " Highlight search results
set incsearch               " Incremental search
set showmatch               " Show matching bracket

" Backup and history
set undodir=~/.vim/undo     " Undo directory
set backupdir=~/.vim/backup " Backup directory
set directory=~/.vim/swap   " Swap directory
set undofile                " Persistent undo
set history=1000            " Command history size

" Behavior
set backspace=indent,eol,start  " Allow backspace over everything
set mouse=a                 " Enable mouse support
set clipboard=unnamedplus   " Use system clipboard
set hidden                  " Allow hidden buffers
set splitbelow              " Split below
set splitright              " Split right
set autowrite               " Auto save on certain commands
set confirm                 " Confirm on unsaved changes

" Performance
set ttyfast                 " Fast terminal
set lazyredraw              " Don't redraw during macros
set encoding=utf-8          " Use UTF-8

" Colors
set background=dark
set termguicolors
colorscheme desert          " Use desert colorscheme (built-in)

" Key mappings
let mapleader = "\<Space>"  " Set space as leader key

" Navigate between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Buffer navigation
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprev<CR>
nnoremap <leader>d :bdelete<CR>

" Save with leader-s
nnoremap <leader>s :w<CR>

" Exit with leader-q
nnoremap <leader>q :q<CR>

" Clear search highlighting
nnoremap <leader>h :noh<CR>

" Toggle relative line numbers
nnoremap <leader>r :set relativenumber!<CR>

" Faster escape
inoremap jk <Esc>

" Create directories if they don't exist
if !isdirectory(expand('~/.vim/undo'))
  call mkdir(expand('~/.vim/undo'), 'p')
endif
if !isdirectory(expand('~/.vim/backup'))
  call mkdir(expand('~/.vim/backup'), 'p')
endif
if !isdirectory(expand('~/.vim/swap'))
  call mkdir(expand('~/.vim/swap'), 'p')
endif

" Language specific settings
autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType json setlocal tabstop=2 softtabstop=2 shiftwidth=2
