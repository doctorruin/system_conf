set nocompatible              " required
filetype off                  " required


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"split designation
set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" add line above and below using Enter and Shift+Enter
map <Enter> o<ESC>
map <S-Enter> O<ESC>

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
"" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse-=a		" Enable mouse usage (all modes) reopening a file

" SimpylFold
Plugin 'tmhedberg/SimpylFold'

" PEP 8 Indentation
au BufNewFile, BufRead *.py
    \ set tabstop=4
    \  softtabstop=4
    \  shiftwidth=4
    \  textwidth=79
    \  expandtab
    \  autoindent
    \  fileformat=unix

" Other dev
au BufNewFile, BufRead *.js, *.html, *.css
    \ set tabstop=2
    \  softtabstop=2
    \  shiftwidth=2

" Auto Indent
Plugin 'vim-scripts/indentpython.vim'

" Unecessary whitespace
 au BufRead, BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Set encoding UTF-8
set encoding=utf-8

" Auto Complete
Bundle 'Valloric/YouCompleteMe'

" Auto Complete customizations
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"python with virtualenv support
python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" Syntax Plugins
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1

let python_highlight_all=1
syntax on

" Color Schemes
" dracula
Plugin 'dracula/vim', { 'name': 'dracula' }


" File Browsing
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
let NERDTreeShowHidden=1
nmap <F6> :NERDTreeToggle<CR>
"  autocmd vimenter * NERDTree

"Super Searching
Plugin 'kien/ctrlp.vim'

" Set Numbers
set nu

" Git integration
Plugin 'tpope/vim-fugitive'

" Powerline for more info
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" jedi 
Plugin 'davidhalter/jedi-vim'

