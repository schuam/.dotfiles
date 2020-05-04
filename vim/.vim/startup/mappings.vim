" Rebind <Leader> key
let mapleader="-"

" Easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" Easier moving between splits
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <Esc>h :TmuxNavigateLeft<cr>
nnoremap <silent> <Esc>j :TmuxNavigateDown<cr>
nnoremap <silent> <Esc>k :TmuxNavigateUp<cr>
nnoremap <silent> <Esc>l :TmuxNavigateRight<cr>
nnoremap <silent> <Esc>\ :TmuxNavigatePrevious<cr>

"map sort function to a key
vnoremap <Leader>s :sort<CR>
vnoremap <Leader>sr :sort!<CR>

" makes indenation of code blocks easier
vnoremap < <gv
vnoremap > >gv

" Turns off search highlight
nnoremap <Leader><space> :nohlsearch<cr>
vnoremap <Leader><space> :nohlsearch<cr>

" Save file on ctrl-s
nnoremap <C-s> :w<cr>
inoremap <C-s> <ESC>:w<cr>i
vnoremap <C-s> <ESC>:w<cr>gv

" Center things like search results, etc.
noremap G Gzz
noremap n nzz
noremap N Nzz
noremap } }zz
noremap { {zz
noremap ( (zz
noremap ) )zz
noremap ]s ]szz
noremap [s [szz

" Toggles the relative line numbering
nnoremap <C-n> :call ToggleRelativenumber()<cr>

" Toggle NERDTree window
noremap <Leader>l :NERDTreeToggle<CR>


" Shows the syntax highlight gourp
nnoremap <C-q> :call CheckSyntaxHighlightGroup()<cr>


" Inserts timestamps
nnoremap <Leader>td a<C-R>=strftime("%F")<CR><Esc>
nnoremap <Leader>tt a<C-R>=strftime("%T")<CR><Esc>
nnoremap <Leader>tdt a<C-R>=strftime("%FT%T%z")<CR><Esc>

inoremap <Leader>td <C-R>=strftime("%F")<CR>
inoremap <Leader>tt <C-R>=strftime("%T")<CR>
inoremap <Leader>tdt <C-R>=strftime("%FT%T%z")<CR>

" Since I want to use <C-d> to quit, I need to remap the scrolling
" functionality. While at it move <C-u> to <C-k>.
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>

" Quit vim like a terminal window
nnoremap <C-d> :q<CR>


" Insert empty line without going into inser mode.
nnoremap <Leader>jj o<Esc>k
nnoremap <Leader>kk O<Esc>j


" Rotate splits
nnoremap <Leader>r <C-w><C-r>


" DoxygenToolkit
nnoremap <Leader>dfu :Dox<CR>
nnoremap <Leader>dfi :DoxAuthor<CR>

" Toggle spell check enable
nnoremap <Leader>sd :set spell spelllang=de_de<CR>
nnoremap <Leader>se :set spell spelllang=en_us<CR>
nnoremap <Leader>s<space> :set spell!<CR>

