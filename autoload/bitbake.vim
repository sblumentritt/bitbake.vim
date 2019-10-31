" --------------------------------------
" public functions
" --------------------------------------
function! bitbake#gather_candidates(type) abort
    let l:bitbake_candidates = []

    if a:type !=# 'task' && a:type !=# 'variable' && a:type !=# 'varflag'
        throw 'Invalid type specified!'
    endif

    for item in readfile(s:get_plugin_path() . '/assets/' . a:type . '_bitbake')
        call add(l:bitbake_candidates, {'word': item, 'kind': a:type})
    endfor

    return l:bitbake_candidates
endfunction

" --------------------------------------
" helper functions
" --------------------------------------
function! s:get_plugin_path() abort
    for ppath in split(&runtimepath, ',')
        if ppath =~# 'bitbake.vim'
            return ppath
        endif
    endfor
endfunction
