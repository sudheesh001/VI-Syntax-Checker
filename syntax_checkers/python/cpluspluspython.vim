"============================================================================
"File:        cpluspluspython.vim
"Description: Syntax checking plugin for syntastic.vim
"Author:      Sudheesh Singanamalla <sudheesh1995 at outlook dot com>
"
" `errorformat` derived from:
" http://www.vim.org/scripts/download_script.php?src_id=1392
"
"============================================================================
if exists("g:loaded_syntastic_python_cpluspluspython_checker")
    finish
endif
let g:loaded_syntastic_python_cpluspluspython_checker=1

function! SyntaxCheckers_python_cpluspluspython_IsAvailable()
    return executable('cpluspluspython')
endfunction

function! SyntaxCheckers_python_cpluspluspython_GetLocList()
    let fname = "'" . escape(expand('%'), "\\'") . "'"

    let makeprg = syntastic#makeprg#build({
        \ 'exe': 'python',
        \ 'args': '-c',
        \ 'fname': syntastic#util#shescape("compile(open(" . fname . ").read(), " . fname . ", 'exec')"),
        \ 'filetype': 'python',
        \ 'subchecker': 'cpluspluspython' })

    let errorformat =
        \ '%E  File "%f"\, line %l,' .
        \ '%C    %p^,' .
        \ '%C    %.%#,' .
        \ '%Z%m,' .
        \ '%-G%.%#'

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'python',
    \ 'name': 'python'})
