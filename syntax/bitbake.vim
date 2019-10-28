" --------------------------------------
" bitbake syntax highlighting
" --------------------------------------
" avoid loading syntax twice
if exists('b:current_syntax')
    finish
endif

" save old value of cpoptions and allow line-continuation
let s:save_cpo = &cpoptions
set cpoptions&vim

" include related syntax files
" --------------------------------------
syntax include @shell syntax/sh.vim
if exists('b:current_syntax') | unlet b:current_syntax | endif

syntax include @python syntax/python.vim
if exists('b:current_syntax') | unlet b:current_syntax | endif

" define keywords/regions/matches
" --------------------------------------
" matching case
syntax case match

" indicates the error when nothing is matched
syntax match bbUnmatched "."

" comments
syntax keyword bbTodo TODO FIXME NOTE XXX contained
syntax match bbComment "#.*$" contains=bbTodo,@Spell

" string helpers
syntax match bbQuote +['"]+ contained
syntax match bbDelimiter "[(){}=]" contained
syntax match bbArrayBrackets "[\[\]]" contained

" bitbake strings
syntax match bbContinue "\\$"
syntax region bbString matchgroup=bbQuote start=+"+ skip=+\\$+ end=+"+ contained
            \ contains=bbTodo,bbContinue,bbVarDeref,bbVarPyValue,@Spell
syntax region bbString matchgroup=bbQuote start=+'+ skip=+\\$+ end=+'+ contained
            \ contains=bbTodo,bbContinue,bbVarDeref,bbVarPyValue,@Spell

" vars definition
syntax keyword bbExportFlag export contained nextgroup=bbIdentifier skipwhite

syntax match bbExport "^export" nextgroup=bbIdentifier skipwhite
syntax match bbIdentifier "[a-zA-Z0-9\-_\.\/\+]\+" display contained
syntax match bbVarDeref "${[a-zA-Z0-9\-_\.\/\+]\+}" contained
syntax match bbVarEq "\(:=\|+=\|=+\|\.=\|=\.\|?=\|??=\|=\)" contained nextgroup=bbVarValue
syntax match bbVarDef "^\(export\s*\)\?\([a-zA-Z0-9\-_\.\/\+]\+\(_[${}a-zA-Z0-9\-_\.\/\+]\+\)\?\)\s*\(:=\|+=\|=+\|\.=\|=\.\|?=\|??=\|=\)\@="
            \ contains=bbExportFlag,bbIdentifier,bbVarDeref nextgroup=bbVarEq
syntax match bbVarValue ".*$" contained contains=bbString,bbVarDeref,bbVarPyValue

syntax region bbVarPyValue start=+${@+ skip=+\\$+ end=+}+ contained contains=@python

" vars metadata flags
syntax match bbVarFlagDef "^\([a-zA-Z0-9\-_\.]\+\)\(\[[a-zA-Z0-9\-_\.+]\+\]\)\@="
            \ contains=bbIdentifier nextgroup=bbVarFlagFlag
syntax region bbVarFlagFlag start="\[" end="\]\s*\(:=\|=\|.=\|=.|+=\|=+\|?=\)\@="
            \ matchgroup=bbArrayBrackets contained contains=bbIdentifier nextgroup=bbVarEq

" includes and requires
syntax keyword bbInclude inherit include require contained
syntax match bbIncludeRest ".*$" contained contains=bbString,bbVarDeref
syntax match bbIncludeLine "^\(inherit\|include\|require\)\s\+"
            \ contains=bbInclude nextgroup=bbIncludeRest

" add taks and similar
syntax keyword bbStatement addtask deltask addhandler after before EXPORT_FUNCTIONS contained
syntax match bbStatementRest ".*$" skipwhite contained contains=bbStatement
syntax match bbStatementLine "^\(addtask\|deltask\|addhandler\|after\|before\|EXPORT_FUNCTIONS\)\s\+"
            \ contains=bbStatement nextgroup=bbStatementRest

" oe important functions
syntax keyword bbOEFunctions do_fetch do_unpack do_patch do_configure do_compile do_stage do_install do_package contained

" generic functions
syntax match bbFunction "\h[0-9A-Za-z_\-\.]*" display contained contains=bbOEFunctions

syntax keyword bbShFakeRootFlag fakeroot contained
syntax match bbShFuncDef "^\(fakeroot\s*\)\?\([\.0-9A-Za-z_${}\-\.]\+\)\(python\)\@<!\(\s*()\s*\)\({\)\@="
            \ contains=bbShFakeRootFlag,bbFunction,bbVarDeref,bbDelimiter
            \ nextgroup=bbShFuncRegion skipwhite
syntax region bbShFuncRegion matchgroup=bbDelimiter start="{\s*$" end="^}\s*$" contained contains=@shell

" python value inside shell functions
syntax region shDeref start=+${@+ skip=+\\$+ excludenl end=+}+ contained contains=@python

" bitbake python metadata
syntax keyword bbPyFlag python contained
syntax match bbPyFuncDef "^\(fakeroot\s*\)\?\(python\)\(\s\+[0-9A-Za-z_${}\-\.]\+\)\?\(\s*()\s*\)\({\)\@="
            \ contains=bbShFakeRootFlag,bbPyFlag,bbFunction,bbVarDeref,bbDelimiter
            \ nextgroup=bbPyFuncRegion skipwhite
syntax region bbPyFuncRegion matchgroup=bbDelimiter start="{\s*$" end="^}\s*$" contained contains=@python

" bitbake 'def'd python functions
syntax keyword bbPyDef def contained
syntax region bbPyDefRegion start='^\(def\s\+\)\([0-9A-Za-z_-]\+\)\(\s*(.*)\s*\):\s*$' end='^\(\s\|$\)\@!'
            \ contains=@python

" define highlight links
" --------------------------------------
highlight default link bbUnmatched      Error
highlight default link bbInclude        Include
highlight default link bbTodo           Todo
highlight default link bbComment        Comment
highlight default link bbQuote          String
highlight default link bbString         String
highlight default link bbDelimiter      Keyword
highlight default link bbArrayBrackets  Statement
highlight default link bbContinue       Special
highlight default link bbExport         Type
highlight default link bbExportFlag     Type
highlight default link bbIdentifier     Identifier
highlight default link bbVarDeref       PreProc
highlight default link bbVarDef         Identifier
highlight default link bbVarValue       String
highlight default link bbShFakeRootFlag Type
highlight default link bbFunction       Function
highlight default link bbPyFlag         Type
highlight default link bbPyDef          Statement
highlight default link bbStatement      Statement
highlight default link bbStatementRest  Identifier
highlight default link bbOEFunctions    Function
highlight default link bbVarPyValue     PreProc

" cleanup
" --------------------------------------
let b:current_syntax = 'bitbake'

" restore old value of cpoptions
let &cpoptions = s:save_cpo
unlet s:save_cpo
