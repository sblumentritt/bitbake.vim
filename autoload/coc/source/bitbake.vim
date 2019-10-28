" --------------------------------------
" coc related functions
" --------------------------------------
function! coc#source#bitbake#init() abort
    " only populate the completion list on source init and save results in
    " global variable because the completion list cannot change at runtime
    let g:coc#source#bitbake#completion_results = []
    call extend(g:coc#source#bitbake#completion_results, bitbake#gather_candidates('task'))
    call extend(g:coc#source#bitbake#completion_results, bitbake#gather_candidates('variable'))
    call extend(g:coc#source#bitbake#completion_results, bitbake#gather_candidates('varflag'))

    " options of current source
    return
          \ {
          \     'shortcut': 'bitbake',
          \     'filetypes': ['bitbake'],
          \     'priority': 3,
          \ }
endfunction

function! coc#source#bitbake#complete(opt, cb) abort
    call a:cb(g:coc#source#bitbake#completion_results)
endfunction
