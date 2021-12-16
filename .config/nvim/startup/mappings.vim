" Rebind <Leader> key
let mapleader="-"

" Easier moving between tabs
nnoremap <C-t> :bn<CR>

" Moving between splits (and tmux)
if exists('$TMUX')
    let g:tmux_navigator_no_mappings = 1
    nnoremap <A-h> :TmuxNavigateLeft<cr>
    nnoremap <A-j> :TmuxNavigateDown<cr>
    nnoremap <A-k> :TmuxNavigateUp<cr>
    nnoremap <A-l> :TmuxNavigateRight<cr>
else
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l
endif

" Disable arrow movement, resize splits instead.
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

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
" functionality. I tried <C-j> and <C-k> but for some reason you can't easily
" map these key combinations, therefore I will use <C-m> to go up and leave
" <C-u> to go up.
nnoremap <C-m> <C-d>

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


" Denite shorcuts
"   <Leader>f; - Browser currently open buffers
"   <leader>ff - Browse list of files in current directory
"   <leader>fg - Search current directory for occurences of given term and
"                close window if no results
"   <leader>fh - Search current directory for occurences of word under cursor
nmap <Leader>f; :Denite buffer<CR>
nmap <leader>ff :DeniteProjectDir file/rec<CR>
nnoremap <leader>fg :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>fh :<C-u>DeniteCursorWord grep:.<CR>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
endfunction


" junegunn/fzf.vim
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fr :Rg<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fh :History:<CR>
inoremap <expr> <leader>ff fzf#vim#complete#path(
    \ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
    \ fzf#wrap({'dir': expand('%:p:h')}))
if has('nvim')
    au! TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
    au! FileType fzf tunmap <buffer> <Esc>
endif

