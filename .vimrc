"be iMproved
set nocompatible
set title	                " change the terminal's title
"Enable syntax highlighting
syntax enable

set background=dark
set t_Co=256
"Loads colorscheme ~/.vim/colors/jellybeans.vim
colorscheme jellybeans

"Show line numbers
set number
set numberwidth=3

"Show a horizontal line indicator under the cursor
"set cursorline
set ruler

"Ignore case if patter is all lowercase, otherwise its case sensitive
set smartcase
"Highlight matches
set hlsearch
"Show search matches while typing
set incsearch
set laststatus=2		" always display the status line

"Automatically indent
"set autoindent
"set smartindent
"set wrap
"Don't wrap lines
set nowrap

"Show the matching part of the pair for parenthesis
set showmatch
set mat=2 "blink when matching brackets

"Python Development (PEP8 styling)
set tabstop=4 "Tab should span four spaces
set shiftwidth=4 "Spaces used when autoindenting
set textwidth=79
set backspace=2
set expandtab "Breaks tab character into multiple spaces
let python_highlight_all = 1 "Enable Python syntax highlighting

set history=1000	        " remember more commands and search history
set undolevels=1000	        " use many more levels of undo

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

" Setup powerline within vim
" set rtp+=/usr/lib/python2.7/site-packages/powerline/bindings/vim/
set showcmd
set listchars=tab:▸.,eol:¬ "  " Use the same symbols as TextMate for tabstops and EOLs

map <F2> :NERDTreeToggle<CR>
let NERDTreeDirArrows=0
