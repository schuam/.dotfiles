" *****************************************************************************
"  XDG settings
" *****************************************************************************

set undodir=$XDG_DATA_HOME/vim/undo
set directory=$XDG_DATA_HOME/vim/swap
set backupdir=$XDG_DATA_HOME/vim/backup
set viewdir=$XDG_DATA_HOME/vim/view
set viminfo+='1000,n$XDG_DATA_HOME/vim/viminfo
set packpath+=$XDG_CONFIG_HOME/vim
set runtimepath=$XDG_CONFIG_HOME/vim,$VIMRUNTIME


" *****************************************************************************
"  General settings
" *****************************************************************************

set cursorline             " Highlights line the cursor is on
set cursorcolumn           " Highlights the column tht cursor is in
set colorcolumn=80         " Highlights column 80
set showcmd                " Show commmands as they are typed
set ruler                  " Enables the ruler in the lower right corner
set wildmenu               " Enables the wild menu for command completion
set incsearch              " Shows next match while typing a search string
set hlsearch               " Highlights all search results
set number                 " Shows current line number
set relativenumber         " Shows relative numbers
set mouse=a                " Enables the use of the mouse to navigate
set ttymouse=sgr           " Enable the use of the mouse in alacritty
set clipboard=unnamedplus  " When text is yanked, put it in the unnamed
                           " register, this way it can be copied into other
                           " applications.
set laststatus=2           " allways show statusline
set nrformats=             " Otherwise numbers with a leading zero will be
                           " treaded as if in octal notation.
set wildmode=list:longest,full  " When <tab> is pressed in Ex mode, the longest
                           " matching part of a possible command and a list
                           " with possible commands is displayed.
set spelllang=de_de        " set German default language for spell checking
set splitbelow             " new splits below the current one
set splitright             " new splits to the right of the current one
set encoding=utf-8         " the encoding displayed
set fileencoding=utf-8     " the encoding written to file


"  wrapping
" -----------------------------------------------------------------------------

set wrap                   " Enables wrapping
set linebreak              " Makes sure that there is no linebreak within a
                           " word
" nolist not needed when textwidth is set.
" set nolist               " list option prevents linebreak option
set textwidth=79           " Hardwrap at 79 characters (80 will be the
                           " linebreak)
set formatoptions=tcr      " use :help fo-table to see options

" Auto completion
" -----------------------------------------------------------------------------

filetype plugin indent on
set omnifunc=syntaxcomplete#Complete    " Enable omni completion


"  indentation
" -----------------------------------------------------------------------------

set expandtab              " not \t as indentation
set shiftwidth=4           " 4 spaces back/forth when pressine '<<', '>>',
                           " or '=='
set tabstop=4              " Tabstop width equals 4 spaces
set softtabstop=4          " 4 four spaces instead of one <tab>
set autoindent             " copy indentation of previous line
set shiftround             " moves text to the next indentation level
" In case problems arise when pasting text from other applications think
" about using the pastetoggle option.


"  highlight certain characters
" -----------------------------------------------------------------------------
set listchars=tab:>~,nbsp:_,trail:.,eol:¬
set list


" color
" -----------------------------------------------------------------------------

syntax enable              " Enables syntax highlighting
set t_Co=256               " Enables 256 colors
set background=dark        " Sets dark backgournd color
colorscheme schuam         " Sets colorscheme


" Options for vim-markdown-preview
" -----------------------------------------------------------------------------

let vim_markdown_preview_browser='firefox'
let vim_markdown_preview_github=1


" vim-pandoc options
" -----------------------------------------------------------------------------

let g:pandoc#modules#disabled = ["folding", "spell"]
let g:pandoc#toc#position= "left"
let g:pandoc#filetypes#pandoc_markdown=0


" markdown
" -----------------------------------------------------------------------------

au BufRead,BufNewFile *.md set filetype=markdown    " treat *.md as markdwon
                                                    " for syntax highlighting


" pymode setting
" ---------------------------------------------------------------------------

let g:pymode_folding=0               " By default: disable folding
let g:pymode_python='python3'        " Use python 3 if possible.


" NERD Commenter
" ----------------------------------------------------------------------------

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'start'
let g:NERDAltDelims_c = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1


" DoxygenToolkit
" -----------------------------------------------------------------------------

let g:DoxygenToolkit_commentType = "C++"
let g:DoxygenToolkit_blockHeader="----------------------------------------------------------------------------"
let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="Andreas Schuster"


" UltiSnips
" -----------------------------------------------------------------------------

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEnableSnipMate=0

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.dotfiles/.config/vim/startup/schuam_snippets', 'UltiSnips']

" Vimwiki
" -----------------------------------------------------------------------------

let g:vimwiki_list = [{'path': '~/referenzmaterial/vimwiki/',
                     \ 'path_html': '~/referenzmaterial/vimwiki/html/',
                     \ 'auto_toc': 1,
                     \ 'index': 'main',
                     \ 'ext': '.md'}]
