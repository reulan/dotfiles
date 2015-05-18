"Use vim settings instead of vi
set nocompatible
set title	                " change the terminal's title
"Enable syntax highlighting
syntax enable

set background=dark
set t_Co=256
"Loads colorscheme ~/.vim/colors/jellybeans.vim
colorscheme jellybeans
set encoding=utf-8

"Show line numbers
set number
set numberwidth=3

"Show a horizontal line indicator under the cursor
"set cursorline
set ruler
" Highlight line number of where cursor currently is
hi CursorLineNr guifg=#050505

"Ignore case if patter is all lowercase, otherwise its case sensitive
set smartcase
"Highlight matches
set hlsearch
"Show search matches while typing
set incsearch
set laststatus=2		" always display the status line
set shiftround "Call shiftwidth mutlple times when indenting

"Automatically indent
"set autoindent
"set smartindent
"set wrap
"Don't wrap lines
set nowrap

"Show the matching part of the pair for parenthesis
set showmatch
set mat=2 "blink when matching brackets
"Show command
set showcmd
"Python Development (PEP8 styling)
set tabstop=4 "Tab should span four spaces
set shiftwidth=4 "Spaces used when indenting
set textwidth=79
set backspace=2
set expandtab "Breaks tab character into multiple spaces
let python_highlight_all = 1 "Enable Python syntax highlighting

set history=500	        " remember more commands and search history
set undolevels=500	        "You can make 500 mistakes.

""" Keybindings
" Leader Mappings
"map <Space> <leader>

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

"Unbind arrow keys in normal mode
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>

"Unbind arrow keys in insert mode
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

"Allow indenting code in visual mode
vmap <tab> >gv
vmap <s-tab> <gv

"No annoying sound on errors
set noerrorbells
set novisualbell
set tm=500
set t_vb=

" Setup powerline within vim
" set rtp+=/usr/lib/python2.7/site-packages/powerline/bindings/vim/
set listchars=tab:▸.,eol:¬ "  " Use the same symbols as TextMate for tabstops and EOLs

" Toggle nerdtree with F10
map <F10> :NERDTreeToggle<CR>
" Current file in nerdtree
map <F9> :NERDTreeFind<CR>
let NERDTreeDirArrows=0
