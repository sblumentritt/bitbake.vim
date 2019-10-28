" --------------------------------------
" bitbake filetype configurations
" --------------------------------------
" avoid executing the plugin twice
if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

" save old value of cpoptions and allow line-continuation
let s:save_cpo = &cpoptions
set cpoptions&vim

" update options
" --------------------------------------
setlocal expandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal commentstring=#\ %s
setlocal suffixesadd+=.bb,.bbclass

" cleanup
" --------------------------------------
"  reset options on filetype change
let b:undo_ftplugin =
            \           'setlocal tabstop<'
            \ . ' | ' . 'setlocal expandtab<'
            \ . ' | ' . 'setlocal shiftwidth<'
            \ . ' | ' . 'setlocal softtabstop<'
            \ . ' | ' . 'setlocal suffixesadd<'
            \ . ' | ' . 'setlocal commentstring<'

" restore old value of cpoptions
let &cpoptions = s:save_cpo
unlet s:save_cpo
