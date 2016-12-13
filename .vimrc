call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'elmcast/elm-vim'
Plug 'scrooloose/nerdtree'
Plug 'jszakmeister/vim-togglecursor'
Plug 'Shougo/neocomplete'
call plug#end()

" General
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
set fillchars+=vert:\ 
set number
set relativenumber
set ignorecase
set noswapfile
set completeopt=longest,menuone
let mapleader = "\<SPACE>"

" Movement
" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gt

" move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" easy escape
inoremap <special> jk <ESC>
inoremap <special> kj <ESC>

" save like Gui
nnoremap <c-s> :w<cr>
inoremap <c-s> <Esc>:w<cr>
vnoremap <c-s> <Esc>:w<cr>

" Gruvbox
set background=dark
colorscheme gruvbox

" Airline
let g:airline_left_sep= '░'
let g:airline_right_sep= '░'

" NerdTree
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>

let NERDTreeShowBookmarks=0
let g:NERDTreeWinSize = 24
let g:NERDTreeMinimalUI = 1
autocmd VimEnter * if (0 == argc()) | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:airline#extensions#syntastic#enabled = 0

" Elm
let g:polyglot_disabled = ['elm']
let g:elm_detailed_complete = 1
let g:elm_format_autosave = 1
let g:elm_syntastic_show_warnings = 1
let g:elm_format_autosave = 1

" Markdown
autocmd BufNewFile,BufRead *.md set spell | set lbr | set nonu
let g:markdown_fenced_languages = ['html', 'json', 'css', 'javascript', 'elm', 'vim']

" NeoComplete
call neocomplete#util#set_default_dictionary('g:neocomplete#sources#omni#input_patterns', 'elm', '\.')
