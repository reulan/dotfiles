"Start Pathogen
"call pathogen#infect()
"filetype plugin indent on

"Enable syntax highlighting
syntax enable

"Show line numbers
set number

"Show cursor indicator
set cursorline

"Color
set t_Co=256

"Automatically indent
set autoindent

"Show the matching part of the pair for [] {} and ()
set showmatch

"Python Development (PEP8 styling)
set tabstop=4
set shiftwidth=4
set textwidth=79
set backspace=2
"4 spaces instead of a tab
set expandtab
"Enable all Python syntax highlighting features
let python_highlight_all = 1
