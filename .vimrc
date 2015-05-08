"Enable syntax highlighting
syntax enable

"Loads colorscheme ~/.vim/colors/jellybeans.vim
colorscheme jellybeans

"Show line numbers
set number

"Show a horizontal line indicator under the cursor
"set cursorline

"Automatically indent
"set autoindent
"set smartindent
"set wrap

"Show the matching part of the pair for [] {} and ()
set showmatch

"Python Development (PEP8 styling)
set tabstop=4
set shiftwidth=4
set textwidth=79
set backspace=2
set expandtab "4 spaces instead of a tab
let python_highlight_all = 1 "Enable highlighting on Python syntax

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

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Setup powerline within vim
set rtp+=/usr/lib/python2.7/site-packages/powerline/bindings/vim/
