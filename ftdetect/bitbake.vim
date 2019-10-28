" --------------------------------------
" bitbake file detection
" --------------------------------------
" save old value of cpoptions and allow line-continuation
let s:save_cpo = &cpoptions
set cpoptions&vim

" autocommands
" --------------------------------------
augroup set_bitbake_filetype
    autocmd!
    autocmd BufNewFile,BufRead *.{bb,bbappend,bbclass,inc} set filetype=bitbake
augroup END

" cleanup
" --------------------------------------
" restore old value of cpoptions
let &cpoptions = s:save_cpo
unlet s:save_cpo
