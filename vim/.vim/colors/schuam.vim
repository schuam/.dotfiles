" -----------------------------------------------------------------------------
" Name:     schuam vim colorscheme
" Author:   Andreas Schuster <andreas.michael.schuster@gmail.com>
" Created:  2016-09-04
" Modified: 2020-04-12
"
" Note:     The way this colorscheme is set up was mainly inspired be the
"           Solarized vim colorscheme by Ethon Schoonover
"           (http://ethanschoonover.com/solarized)
"           At the end of this file are still some left overs from solarized
"           that I might use for further inspiration to adjust some more syntax
"           highlighting.
" -----------------------------------------------------------------------------


" -----------------------------------------------------------------------------
" Colorscheme initialization
" -----------------------------------------------------------------------------
hi clear
if exists("syntax_on")
  syntax reset
endif
let colors_name = "schuam"


" -----------------------------------------------------------------------------
" Set colors
" -----------------------------------------------------------------------------

let s:vmode            = "cterm"

let s:light_bg         = "000"
let s:dark_red         = "001"
let s:dark_green       = "002"
let s:dark_yellow      = "003"
let s:dark_blue        = "004"
let s:dark_magenta     = "005"
let s:dark_cyan        = "006"
let s:fg               = "007"
let s:intense_light_bg = "008"
let s:light_red        = "009"
let s:light_green      = "010"
let s:light_yellow     = "011"
let s:light_blue       = "012"
let s:light_magenta    = "013"
let s:light_cyan       = "014"
let s:intense_fg       = "015"


" -----------------------------------------------------------------------------
" Formatting options and null values for passthrough effect "{{{
" ---------------------------------------------------------------------

let s:none = "NONE"
let s:c    = ",undercurl"
let s:r    = ",reverse"
let s:s    = ",standout"
let s:ou   = ""
let s:ob   = ""
let s:back = "NONE"
let s:b    = ",bold"
let s:bb   = ""
let s:u    = "underline"
let s:i    = ""


" -----------------------------------------------------------------------------
" Highlighting primitives
" -----------------------------------------------------------------------------

exe "let s:bg_none               = ' ".s:vmode."bg=".s:none               ."'"
exe "let s:bg_back               = ' ".s:vmode."bg=".s:back               ."'"
exe "let s:bg_light_bg           = ' ".s:vmode."bg=".s:light_bg           ."'"
exe "let s:bg_fg                 = ' ".s:vmode."bg=".s:fg                 ."'"
exe "let s:bg_intense_light_bg   = ' ".s:vmode."bg=".s:intense_light_bg   ."'"
exe "let s:bg_intense_fg         = ' ".s:vmode."bg=".s:intense_fg         ."'"

exe "let s:fg_none               = ' ".s:vmode."fg=".s:none               ."'"
exe "let s:fg_back               = ' ".s:vmode."fg=".s:back               ."'"
exe "let s:fg_light_bg           = ' ".s:vmode."fg=".s:light_bg           ."'"
exe "let s:fg_fg                 = ' ".s:vmode."fg=".s:fg                 ."'"
exe "let s:fg_dark_blue          = ' ".s:vmode."fg=".s:dark_blue          ."'"
exe "let s:fg_dark_cyan          = ' ".s:vmode."fg=".s:dark_cyan          ."'"
exe "let s:fg_dark_green         = ' ".s:vmode."fg=".s:dark_green         ."'"
exe "let s:fg_dark_magenta       = ' ".s:vmode."fg=".s:dark_magenta       ."'"
exe "let s:fg_dark_red           = ' ".s:vmode."fg=".s:dark_red           ."'"
exe "let s:fg_dark_yellow        = ' ".s:vmode."fg=".s:dark_yellow        ."'"
exe "let s:fg_intense_light_bg   = ' ".s:vmode."fg=".s:intense_light_bg   ."'"
exe "let s:fg_light_blue         = ' ".s:vmode."fg=".s:light_blue         ."'"
exe "let s:fg_light_cyan         = ' ".s:vmode."fg=".s:light_cyan         ."'"
exe "let s:fg_light_green        = ' ".s:vmode."fg=".s:light_green        ."'"
exe "let s:fg_light_magenta      = ' ".s:vmode."fg=".s:light_magenta      ."'"
exe "let s:fg_light_red          = ' ".s:vmode."fg=".s:light_red          ."'"
exe "let s:fg_light_yellow       = ' ".s:vmode."fg=".s:light_yellow       ."'"
exe "let s:fg_intense_fg         = ' ".s:vmode."fg=".s:intense_fg         ."'"

exe "let s:fmt_none              = ' ".s:vmode."=NONE".             " term=NONE"             ."'"
exe "let s:fmt_bold              = ' ".s:vmode."=NONE".s:b.         " term=NONE".s:b         ."'"
exe "let s:fmt_bldi              = ' ".s:vmode."=NONE".s:b.         " term=NONE".s:b         ."'"
exe "let s:fmt_undr              = ' ".s:vmode."=NONE".s:u.         " term=NONE".s:u         ."'"
exe "let s:fmt_undb              = ' ".s:vmode."=NONE".s:u.s:b.     " term=NONE".s:u.s:b     ."'"
exe "let s:fmt_undi              = ' ".s:vmode."=NONE".s:u.         " term=NONE".s:u         ."'"
exe "let s:fmt_uopt              = ' ".s:vmode."=NONE".s:ou.        " term=NONE".s:ou        ."'"
exe "let s:fmt_curl              = ' ".s:vmode."=NONE".s:c.         " term=NONE".s:c         ."'"
exe "let s:fmt_ital              = ' ".s:vmode."=NONE".s:i.         " term=NONE".s:i         ."'"
exe "let s:fmt_stnd              = ' ".s:vmode."=NONE".s:s.         " term=NONE".s:s         ."'"
exe "let s:fmt_revr              = ' ".s:vmode."=NONE".s:r.         " term=NONE".s:r         ."'"
exe "let s:fmt_revb              = ' ".s:vmode."=NONE".s:r.s:b.     " term=NONE".s:r.s:b     ."'"
exe "let s:fmt_revbb             = ' ".s:vmode."=NONE".s:r.s:bb.    " term=NONE".s:r.s:bb    ."'"
exe "let s:fmt_revbbu            = ' ".s:vmode."=NONE".s:r.s:bb.s:u." term=NONE".s:r.s:bb.s:u."'"


" -----------------------------------------------------------------------------
" The acutal highlighting
" -----------------------------------------------------------------------------


exe "hi! Normal"         .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! Comment"        .s:fg_dark_cyan        .s:bg_none             .s:fmt_none
exe "hi! CursorLine"     .s:fg_none             .s:bg_light_bg         .s:fmt_none
exe "hi! CursorColumn"   .s:fg_none             .s:bg_light_bg         .s:fmt_none
exe "hi! ColorColumn"    .s:fg_none             .s:bg_light_bg         .s:fmt_none
exe "hi! LineNr"         .s:fg_none             .s:bg_light_bg         .s:fmt_none
exe "hi! NonText"        .s:fg_none             .s:bg_none             .s:fmt_none

exe "hi! Boolean"        .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! Character"      .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! Number"         .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! String"         .s:fg_dark_blue        .s:bg_none             .s:fmt_none
exe "hi! Conditional"    .s:fg_dark_yellow      .s:bg_none             .s:fmt_none
exe "hi! Constant"       .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! Cursor"         .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! Debug"          .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! Define"         .s:fg_dark_magenta     .s:bg_none             .s:fmt_none
exe "hi! Delimiter"      .s:fg_none             .s:bg_none             .s:fmt_none

exe "hi! DiffAdd"        .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! DiffChange"     .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! DiffDelete"     .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! DiffText"       .s:fg_none             .s:bg_none             .s:fmt_none

exe "hi! Directory"      .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! Error"          .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! ErrorMsg"       .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! Exception"      .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! Float"          .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! FoldColumn"     .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! Folded"         .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! Function"       .s:fg_intense_fg       .s:bg_none             .s:fmt_none
exe "hi! Identifier"     .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! Ignore"         .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! IncSearch"      .s:fg_none             .s:bg_none             .s:fmt_revbbu
exe "hi! Keyword"        .s:fg_dark_magenta     .s:bg_none             .s:fmt_none
exe "hi! Label"          .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! Macro"          .s:fg_dark_magenta     .s:bg_none             .s:fmt_none
exe "hi! SpecialKey"     .s:fg_none             .s:bg_none             .s:fmt_none

exe "hi! MatchParen"     .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! ModeMsg"        .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! MoreMsg"        .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! Operator"       .s:fg_dark_magenta     .s:bg_none             .s:fmt_none

" !complete menu
exe "hi! Pmenu"          .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! PmenuSel"       .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! PmenuSbar"      .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! PmenuThumb"     .s:fg_none             .s:bg_none             .s:fmt_none

exe "hi! PreCondit"      .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! PreProc"        .s:fg_dark_magenta     .s:bg_none             .s:fmt_none
exe "hi! Question"       .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! Repeat"         .s:fg_dark_yellow      .s:bg_none             .s:fmt_none
exe "hi! Search"         .s:fg_none             .s:bg_none             .s:fmt_revbbu


" !marks column
exe "hi! SignColumn"     .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! SpecialChar"    .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! SpecialComment" .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! Special"        .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! SpecialKey"     .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! SpellBad"       .s:fg_light_red        .s:bg_none             .s:fmt_undr

exe "hi! Statement"      .s:fg_dark_magenta     .s:bg_none             .s:fmt_none
exe "hi! StatusLine"     .s:fg_light_bg         .s:bg_fg               .s:fmt_none
exe "hi! StatusLineNC"   .s:fg_light_bg         .s:bg_fg               .s:fmt_none
exe "hi! StorageClass"   .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! Structure"      .s:fg_dark_magenta     .s:bg_none             .s:fmt_none
exe "hi! Tag"            .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! Title"          .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! Todo"           .s:fg_light_cyan       .s:bg_none             .s:fmt_none

exe "hi! Typedef"        .s:fg_dark_magenta     .s:bg_none             .s:fmt_none
exe "hi! Type"           .s:fg_dark_magenta     .s:bg_none             .s:fmt_none
exe "hi! Underlined"     .s:fg_none             .s:bg_none             .s:fmt_none

exe "hi! VertSplit"      .s:fg_intense_light_bg .s:bg_fg               .s:fmt_none
exe "hi! VisualNOS"      .s:fg_none             .s:bg_intense_light_bg .s:fmt_none
exe "hi! Visual"         .s:fg_none             .s:bg_intense_light_bg .s:fmt_none
exe "hi! WarningMsg"     .s:fg_none             .s:bg_none             .s:fmt_none
exe "hi! WildMenu"       .s:fg_none             .s:bg_none             .s:fmt_none


" -----------------------------------------------------------------------------
" tex highlighting
" -----------------------------------------------------------------------------

exe "hi! texSection"     .s:fg_dark_magenta .s:bg_none .s:fmt_none
exe "hi! texDelimiter"   .s:fg_dark_magenta .s:bg_none .s:fmt_none


" -----------------------------------------------------------------------------
" vim highlighting
" -----------------------------------------------------------------------------

exe "hi! vimCommand"     .s:fg_dark_magenta  .s:bg_none .s:fmt_none
exe "hi! vimOption"      .s:fg_light_blue    .s:bg_none .s:fmt_none
exe "hi! diffAdded"      .s:fg_light_green   .s:bg_none .s:fmt_none
exe "hi! diffRemoved"    .s:fg_light_red     .s:bg_none .s:fmt_none


" -----------------------------------------------------------------------------
" markdown highlighting
" -----------------------------------------------------------------------------

exe "hi! markdownH1"               .s:fg_dark_yellow   .s:bg_none .s:fmt_none
exe "hi! markdownH2"               .s:fg_dark_yellow   .s:bg_none .s:fmt_none
exe "hi! markdownH3"               .s:fg_dark_yellow   .s:bg_none .s:fmt_none
exe "hi! markdownH4"               .s:fg_dark_yellow   .s:bg_none .s:fmt_none
exe "hi! markdownH5"               .s:fg_dark_yellow   .s:bg_none .s:fmt_none
exe "hi! markdownH6"               .s:fg_dark_yellow   .s:bg_none .s:fmt_none
exe "hi! markdownHeadingDelimiter" .s:fg_dark_yellow   .s:bg_none .s:fmt_none
exe "hi! markdownListMarker"       .s:fg_dark_magenta  .s:bg_none .s:fmt_none
exe "hi! markdownHeadingRule"      .s:fg_dark_yellow   .s:bg_none .s:fmt_none

