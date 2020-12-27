" Automatic reloading of .vimrc
augroup relaod_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" *****************************************************************************
"  Load my custom settings
" *****************************************************************************

source $XDG_CONFIG_HOME/nvim/startup/settings.vim
source $XDG_CONFIG_HOME/nvim/startup/functions.vim
source $XDG_CONFIG_HOME/nvim/startup/mappings.vim

