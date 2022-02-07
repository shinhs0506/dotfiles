"custom remaps
let mapleader=" "
filetype plugin indent on

set hidden
set cmdheight=2
set updatetime=300
set tabstop=4
"set softtabstop=4
set shiftwidth=4
set expandtab
set number
set relativenumber
set cc=80
set cursorline
set noswapfile
set noerrorbells
set splitright
set splitbelow

"Plugins
call plug#begin("~/.vim/plugged")

"gruvbox
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'

"icons
Plug 'ryanoasis/vim-devicons'

"file trees
Plug 'scrooloose/nerdtree'

"comments
Plug 'preservim/nerdcommenter'

"pairs
Plug 'jiangmiao/auto-pairs'

"status line
Plug 'nvim-lualine/lualine.nvim'

"finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"syntax highlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
call plug#end()


if has('termguicolors')
  set termguicolors
endif
set background=dark
let g:gruvbox_material_diagnostic_text_highlight = 1
let g:gruvbox_material_diagnostic_virtual_text = 1
let g:gruvbox_material_background = 'medium'
colorscheme gruvbox-material

"indents
vnoremap < <gv
vnoremap > >gv

"window resize
nnoremap <leader>wh :vertical resize -5<CR>
nnoremap <leader>wl :vertical resize +5<CR>
nnoremap <leader>wj :resize -5<CR>
nnoremap <leader>wk :resize +5<CR>

"diable highlight after search with enter
nnoremap <CR> :noh<CR>
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

"windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

"NERDTree
nnoremap <leader>n :NERDTreeVCS<CR> 
nnoremap <leader>nt :NERDTreeToggleVCS<CR>
nnoremap <leader>nf :NERDTreeFind<CR> 
nnoremap <leader>nr :NERDTreeRefresh<CR> 

"NERDTree setting
if argc() > 0
    autocmd VimEnter * NERDTreeVCS | execute 'NERDTreeFind' argv()[0] | wincmd p
else
    autocmd VimEnter * NERDTreeVCS | NERDTreeFind | wincmd p
endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
            \ quit | endif
let NERDTreeShowHidden = 1

"Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

"Treesitter
lua << EOF
require'nvim-treesitter.configs'.setup { highlight = { enable = true } }
EOF

"lualine stuff
lua << EOF
require('lualine').setup {
    options = {
        theme = 'gruvbox-material'
    }
}
EOF

"Coc nvim
"tab and s-tab to navigate completion and arguments
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
let g:coc_snippet_next = '<tab>'

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" confirms selection if any or just break line if none
function! EnterSelect()
    " if the popup is visible and an option is not selected
    if pumvisible() && complete_info()["selected"] == -1
        return "\<C-y>\<CR>"

    " if the pum is visible and an option is selected
    elseif pumvisible()
        return coc#_select_confirm()

    " if the pum is not visible
    else
        return "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    endif
endfunction

" makes <CR> confirm selection if any or just break line if none
inoremap <silent><expr> <cr> EnterSelect()

"go to prev and next diagnostic
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"rename
nmap <silent> gn <Plug>(coc-rename)

"hover
nnoremap <silent> gh :call CocActionAsync('doHover')<cr>

"markdown preview
nnoremap <leader> mp :CocCommand markdown-preview-enhanced.openPreview<cr>

"signature
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
