" *****************************************************************************
"  Custom functions
" *****************************************************************************

function! ToggleRelativenumber()
    if (&relativenumber == 1)
        set relativenumber!
    else
        set relativenumber
    endif
endfunc


function! CheckSyntaxHighlightGroup()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
