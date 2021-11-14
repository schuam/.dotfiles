" *****************************************************************************
"  XDG settings
" *****************************************************************************

"set undodir=$XDG_DATA_HOME/vim/undo
"set directory=$XDG_DATA_HOME/vim/swap
"set backupdir=$XDG_DATA_HOME/vim/backup
"set viewdir=$XDG_DATA_HOME/vim/view
"set viminfo+='1000,n$XDG_DATA_HOME/vim/viminfo
"set packpath+=$XDG_CONFIG_HOME/vim
"set runtimepath=$XDG_CONFIG_HOME/vim,$VIMRUNTIME


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


" Denite
" -----------------------------------------------------------------------------

" Wrap in try/catch to avoid errors on initial install before plugin is available
try
" === Denite setup ==="
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height
"                             automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below
"                             current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
\ 'split': 'horizontal',
\ 'start_filter': 1,
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'prompt': 'λ ',
\ 'winrow': 1,
\ 'vertical_preview': 1
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry


"  powerline
" -----------------------------------------------------------------------------

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_alt_sep=''


" python
" -----------------------------------------------------------------------------

let g:python3_host_prog='/usr/bin/python'


" orgmode
" -----------------------------------------------------------------------------

lua << EOF
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'main',
    files = {'src/parser.c', 'src/scanner.cc'},
  },
  filetype = 'org',
}

require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
  org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/Dropbox/org/refile.org',
})
EOF

