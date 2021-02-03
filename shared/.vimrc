" =========================================
" General Settings
" =========================================
syntax on

set nocompatible            "Use vim settings instead of vi behavior
set encoding=utf-8          "Enables utf-8 encoding
"set title	                "Change the terminal's title

set history=5000	        "Remember more commands and search history

set undolevels=5000	        "You can make 500 mistakes.
set wildmenu                "A menu with autocomplete options

set so=7                    "Moves 7 lines vertically

" Nobackup - most info is stored in git anyways
set nobackup
set nowritebackup
set noswapfile 

" Line numbers
set number                  "Show line numbers
set numberwidth=3
set scrolloff=5

" File layout, cursor, sounds
set ruler
set autochdir
set ttyfast                 "Fast terminal 
set hidden                  "Hidden buffers, not closed 
"set cursorline              "Underline current line where cursor is

" Autorefresh file
set autoread

" =========================================
" Colorscheme
" =========================================
set t_Co=256               "256 color allowed
set t_ut=                  "Fix background color weirdness when using xterm-kitty
set background=dark        "Makes background opaque black

"colorscheme jellybeans      "Loads ~/.vim/colorscheme/jellybeans.vim <3 <3 <3
colorscheme dim               "Loads Default IMproved - a 4-bit 16 color scheme

" set guifont=Monaco:h10 noanti

" =========================================
" Sound
" =========================================
set noerrorbells
set novisualbell
set tm=500
set t_vb=

" =========================================
" File configuration
" =========================================

" Pick up on the same line where you left off when editing a file 'perpetual cursor location'
if has("autocmd")
    augroup perpetual 
    autocmd!
    autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif
    augroup END
endif

"Searching the file 
set ignorecase              " Search ignoring case
set incsearch               "Allows matching while word is being typed
set hlsearch                "Highlight matches - :noh to clear
set laststatus=2            "Always display the status line
set smartcase               "Ignore case if patter is all lowercase, otherwise its case sensitive
set matchpairs+=<:>         "Useful for HTML/XML editing
set mat=1                   "Blink (in tenth of seconds) when matching brackets
set more                      

"Show all the tings
set showmatch               "Show the matching part of the pair for parenthesis
set showcmd                 "Show current command in bottom right
set showmode
set wildmenu
set display+=lastline

" Text and indentation 
syntax enable               "Enable syntax highlighting
set shiftround              "Call shiftwidth mutlple times when indenting
set nowrap                  "No need to worry about fixing autowrapped text
set diffopt=filler,iwhite   " Ignore all whitespace and sync

" Filetype configuration
filetype on                 " Enable filetype detection
filetype indent on          " Enable filetype-specific indenting
filetype plugin on          " Enable filetype-specific plugins

" =========================================
" Syntax configuration 
" =========================================

" Python Development (PEP8 styling)
"set autoindent             "Automatically indent lines, bad for copying existing code
set shiftround
set shiftwidth=4            "Spaces used when indenting
set tabstop=4               "Tab will span four paces
set softtabstop=4           "Tab spacing while editing, works with bksp
"set textwidth=79           "Wraps line of text after 79 chars
set textwidth=170           "Wraps line of text after 170 chars
set backspace=2
set expandtab               "Breaks tab character into multiple spaces
let python_highlight_all = 1 "Enable Python syntax highlighting
"
" Getting organized in vim???
set modelines=1

" =========================================
" Keybindings
" =========================================
" Leader Mappings
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Unbind arrow keys in normal and insert mode
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

" Allow indenting code in visual mode <3 <3 <3
vmap <tab> >gv
vmap <s-tab> <gv

" Relative number line keybinding
nmap <leader>R :set rnu<cr>

" Highlights last inserted text
nnoremap gV `[v`]

" jk inherits the Esc function while in insert mode
inoremap jk <esc>

"edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Save session
nnoremap <leader>s :mksession<CR>

" NERDTree settings
"Switch between different windows by their direction`
nnoremap <leader>j <C-w>j|
nnoremap <leader>k <C-w>k|
nnoremap <leader>l <C-w>l|
nnoremap <leader>h <C-w>h|
nnoremap <leader>nt :NERDTree<CR>

" Powerline
" =========================================
" needs powerline installed, pip install powerline-status
"let g:Powerline_symbols = 'fancy'

" jedi-vim
" =========================================
let g:jedi#auto_initialization = 1
let g:jedi#auto_vim_configuration = 1
let g:jedi#use_tabs_not_buffers = 1
"let g:jedi#use_splits_not_buffers = "left"
let g:jedi#popup_select_first = 0

" vim-terraform
" =========================================
let g:terraform_fmt_on_save = 1
let g:terraform_align = 1
let g:terraform_fold_sections = 0
let g:terraform_remap_spacebar = 1

" limelight.vim
" =========================================
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = '#777777' " GUI color
let g:limelight_priority = -1 " boldness? - default 10

" goyo.vim
" =========================================
let g:goyo_width  = 80
let g:goyo_height = 100
let g:goyo_linenr = 0

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
noremap <leader>gy :Goyo<cr>

" NERDTree
" =========================================
"autocmd vimenter * NERDTree "Autoload NERDTree on vim enter
"autocmd StdinReadPre * let s:std_in=1 
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif "

" TypeScript
" =========================================
" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
" light-grey
hi tsxTypeBraces guifg=#999999
" dark-grey
hi tsxTypes guifg=#666666
hi ReactState guifg=#C176A7
hi ReactProps guifg=#D19A66
hi ApolloGraphQL guifg=#CB886B
hi Events ctermfg=204 guifg=#56B6C2
hi ReduxKeywords ctermfg=204 guifg=#C678DD
hi ReduxHooksKeywords ctermfg=204 guifg=#C176A7
hi WebBrowser ctermfg=204 guifg=#56B6C2
hi ReactLifeCycleMethods ctermfg=204 guifg=#D19A66

" ale + gopls
" =========================================
" Ale [General]
let g:ale_fix_on_save = 1

let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = "🔥 "

" Ale [Keybindings]
" shows information about word under cursor
nnoremap K :ALEHover<CR> 
" find all references of word under cursor 
nnoremap <silent> gK :ALEFindReferences<CR>
" rename word under cursor
nnoremap <leader>rn :ALERename<CR>
" get missing imports / (extract code to function or method???)
nnoremap <leader>qf :ALECodeAction<CR>
vnoremap <leader>qf :ALECodeAction<CR>

" Ale [Go]
let g:ale_linters = {
	\ 'go': ['gopls'],
	\}

" Ale [Typescript]
let js_fixers = ['prettier', 'eslint']
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': js_fixers,
\   'javascript.jsx': js_fixers,
\   'typescript': js_fixers,
\   'typescriptreact': js_fixers,
\   'css': ['prettier'],
\   'json': ['prettier'],
\}

" deoplete
" =========================================
"call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
"let g:deoplete#enable_at_startup = 1
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1


" Use ALE and also some plugin 'foobar' as completion sources for all code.
"call deoplete#custom#option('sources', {'_': ['ale', 'foobar']})

" =========================================
" Vim Plugin management via vim-plug
" https://github.com/junegunn/vim-plug
" =========================================
" call plug#begin('~/.config/nvim/plugged')
call plug#begin('~/.vim/plugged')
"Plug 'preservim/nerdtree'
"Plug 'vim-airline/vim-airline'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'cloudhead/neovim-fuzzy'
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'francoiscabrol/ranger.vim'
Plug 'frazrepo/vim-rainbow'
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-terraform'
Plug 'jreybert/vimagit'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'mitsuhiko/vim-jinja'
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'peitalin/vim-jsx-typescript'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-emoji'
call plug#end()

" To install new plugins!
" :source %
" :PlugInstall
" Source Vim configuration file and install plugins
nnoremap <silent><leader>1 :source ~/.vimrc \| :PlugInstall<CR>
