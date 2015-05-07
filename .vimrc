"Enable syntax highlighting
syntax enable

"Loads colorscheme ~/.vim/colors/jellybeans.vim
colorscheme jellybeans

"Show line numbers
set number

"Show a horizontal line indicator under the cursor
"set cursorline

"Enable some sort of color
set t_Co=256

"Automatically indent
"set autoindent

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
