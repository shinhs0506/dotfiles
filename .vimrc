" my vimrc file

" using plugged
call plug#begin('~/.vim/plugged')

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" colourscheme
Plug 'morhetz/gruvbox'

" YCM
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }

" Auto pairs
Plug 'jiangmiao/auto-pairs'

" NerdCommeter
Plug 'preservim/nerdcommenter'

" Tree
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'

" React 
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

" Fugitive
Plug 'tpope/vim-fugitive'

call plug#end()

" default setting
set background=dark
colorscheme gruvbox

set encoding=UTF-8
filetype plugin on

set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set noerrorbells
set nowrap
set noswapfile
set smartcase
set incsearch
set scrolloff=10
set splitright
set splitbelow

" custom remaps
let mapleader = " "

" indents
vnoremap < <gv
vnoremap > >gv

" windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" fzf
nnoremap <leader>f :Files<CR>
nnoremap <leader>pf :GFiles<CR>

" YCM
nnoremap <leader>gd :YcmCompleter GoTo<CR>
nnoremap <leader>gf :YcmCompleter FixIt<CR>
nnoremap <leader>rr :YcmCompleter RefactorRename

" YCM settings
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_key_list_stop_completion= [ '<CR>' ]

" NERDTree
nnoremap <leader>n :NERDTreeVCS<CR> 
nnoremap <leader>nt :NERDTreeToggleVCS<CR>
nnoremap <leader>nf :NERDTreeFind<CR> 

"NERDTree setting
autocmd VimEnter * NERDTreeVCS | NERDTreeFind | wincmd p
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
let NERDTreeShowHidden = 1

" Powerline Config
set laststatus=2

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
