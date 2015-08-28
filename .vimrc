" General settings {{{
set nocompatible            "Use vim settings instead of vi
set encoding=utf-8          "Enables utf-8 encoding
"set title	                "Change the terminal's title

set history=500	            "Remember more commands and search history
set undolevels=500	        "You can make 500 mistakes.
set wildmenu                "A menu with autocomplete options

set so=7                    "Moves 7 lines vertically

"Nobackup - most info is stored in git anyways
set nobackup
set nowritebackup
set noswapfile 
"}}}/*}}}*/

"File layout, cursor, coloring and sounds{{{
set number                  "Show line numbers
set numberwidth=3
set ruler

set cursorline              "Highlight line number of where cursor currently is

"set background=dark        "Makes background opaque black
set t_Co=256                "256 color allowed
try
    colorscheme jellybeans      "Loads ~/.vim/colorscheme/jellybeans.vim
catch
endtry

"Remove annoying bell sound on errors
set noerrorbells
set novisualbell
set tm=500
set t_vb=
" }}}

"""Searching the file {{{
set incsearch               "Allows matching while word is being typed
set hlsearch                "Highlight matches - :noh to clear
set laststatus=2            "Always display the status line
set smartcase               "Ignore case if patter is all lowercase, otherwise its case sensitive
set matchpairs+=<:>         "Useful for HTML/XML editing

set showmatch               "Show the matching part of the pair for parenthesis
set mat=1                   "Blink (in tenth of seconds) when matching brackets
" }}}

"Text and indentation {{{
syntax enable               "Enable syntax highlighting
set shiftround              "Call shiftwidth mutlple times when indenting
set nowrap                  "No need to worry about fixing autowrapped text

"Python Development (PEP8 styling)
set autoindent
set shiftround
set shiftwidth=4            "Spaces used when indenting
set tabstop=4               "Tab will span four paces
set softtabstop=4           "Tab spacing while editing, works with bksp
"set textwidth=79           "Wraps line of text after 79 chars
set backspace=2
set expandtab               "Breaks tab character into multiple spaces
let python_highlight_all = 1 "Enable Python syntax highlighting
" }}}

""" Keybindings {{{
" Leader Mappings
"map <Space> <leader>

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

"Unbind arrow keys in normal and insert mode
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

"Allow indenting code in visual mode
vmap <tab> >gv
vmap <s-tab> <gv

" Relative number line keybinding
nmap <leader>R :set rnu<cr>
"Plugin settings {{{
"Powerline settings
" needs powerline installed, pip install powerline-status
let g:Powerline_symbols = 'fancy'

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
" }}}

""" Settings and keybindings going through testing {{{
"" tmux settings
"Allow set correct terminal paramater for tmux
if exists('$TMUX')
    set term=screen-256color
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"i
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Correct cursor shape for iTerm in tmux
if exists('$ITERM_PROFILE')
    if exists('$TMUX')
        let &t_SI = "\<Esc>[3 q"
        let &t_EI = "\<Esc>[0 q"
    else
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
end

"" NERDTree stuff
" Automatically open NERDTree upon entering vim
"autocmd vimenter * NERDTree
" Toggle nerdtree with F10
"map <F10> :NERDTreeToggle<CR>
" Current file in nerdtree
"map <F9> :NERDTreeFind<CR>
"let NERDTreeDirArrows=0

"" Folding
set foldenable          "Enables folding
set foldlevelstart=10   "Opens most folds by default
set foldnestmax=10      "Delves 10 nests deep
set foldmethod=indent   "Folds based on indent level

"" Movement and keybindings taken from Doug Black's A Good Vimrc
"Rebinds moving beginning of WORD to beginning of line
nnoremap B ^
"Rebinds moving end of WORD to end of line
nnoremap E $            
nnoremap $ <nop>
nnoremap ^ <nop>

"Highlights last inserted text
nnoremap gV `[v`]

"jk inherits the Esc function while in insert mode
inoremap jk <esc>

" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" save session
nnoremap <leader>s :mksession<CR>

""Getting organized in vim
set modelines=1

" Folding keybinds
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
" }}}
" vim:foldmethod=marker:foldlevel=0
