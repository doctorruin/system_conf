""""""""""""""""""" Initial Settings """"""""""""""""""
set nocompatible              " required
filetype off                  " required
filetype plugin indent on    " required

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
"" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"split designation
set splitbelow
set splitright

" Set Relative Numbers
set rnu

" Enable folding
set foldmethod=indent
set foldlevel=99

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
set noshowmode

""""""""""""""""" Plugin Customizations """"""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

 " let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)
"
" Git
Plugin 'tpope/vim-fugitive'

" SimpylFold
Plugin 'tmhedberg/SimpylFold'

" Auto Indent
Plugin 'vim-scripts/indentpython.vim'

" Light line for more info
Plugin 'itchyny/lightline.vim'

" File Browsing
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'

" Color Schemes
" dracula
Plugin 'dracula/vim', { 'name': 'dracula' }

" linting
Plugin 'dense-analysis/ale'
Plugin 'nvie/vim-flake8'
Plugin 'gryf/pylint-vim'
Plugin 'tell-k/vim-autopep8'

" All of your Plugins must be added before the following line
call vundle#end()            " required


""""""""""""""""" Light Line Customizations """"""""""""""""
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'filetype', 'combo', 'charvaluehex' ] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '%B',
      \   'combo': '%{&fileencoding}[%{&fileformat}]'
      \ },
      \  'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }


""""""""""""""""" Mapping Customizations """"""""""""""""

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding with the spacebar
nnoremap <space> za

" add line above and below using Enter and Shift+Enter
noremap <Enter> o<ESC>
noremap <BS> O<ESC>

""""""""""""""""" Programming Customizations """"""""""""""""
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


" Unecessary whitespace
"  au BufRead, BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Set encoding UTF-8
set encoding=utf-8

" kite customizations
let g:kite_tab_complete=1
set completeopt+=menuone   " show the popup menu even when there is only 1 match
set completeopt+=noinsert  " don't insert any text until user chooses a match
set completeopt-=longest   " don't insert the longest common text
autocmd CompleteDone * if !pumvisible() | pclose | endif
set statusline=%<%f\ %h%m%r%{kite#statusline()}%=%-14.(%l,%c%V%)\ %P
set laststatus=2  " always display the status line

" Check Python files with flake8 and pylint.
"let b:ale_linters = ['flake8', 'pylint']
" Fix Python files with autopep8 and yapf.
"let b:ale_fixers = ['autopep8']
" Disable warnings about trailing whitespace for Python files.
"let b:ale_warn_about_trailing_whitespace = 0

"python with virtualenv support
python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" NERDtree customizations
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
let NERDTreeShowHidden=1
let NERDTreeMapOpenInTab='\r'
nmap <F6> :NERDTreeToggle<CR>
"  autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='.  a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'.  a:extension .'$#'
endfunction

"   call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
"   call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow',
"   '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
"   call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
"   call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
