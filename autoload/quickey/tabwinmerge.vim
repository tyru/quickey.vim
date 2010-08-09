" vim:foldmethod=marker:fen:
scriptencoding utf-8

" Load Once {{{
if exists('s:loaded') && s:loaded
    finish
endif
let s:loaded = 1
" }}}
" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}



function! quickey#tabwinmerge#tab_to_tab(from_tabpagenr, to_tabpagenr, ...) "{{{
    let create_tab = a:0 ? a:1 : 1

    if a:from_tabpagenr ==# a:to_tabpagenr
        return
    endif
    let from_exists = s:exists_tab(a:from_tabpagenr)
    if !from_exists
        return
    endif
    let to_exists = s:exists_tab(a:to_tabpagenr)
    if !create_tab && !to_exists
        return
    endif


    execute 'tabnext' a:to_tabpagenr

    for bufnr in tabpagebuflist(a:from_tabpagenr)
        split
        execute bufnr 'buffer'
    endfor

    execute 'tabclose' a:from_tabpagenr
endfunction "}}}

" TODO
function! quickey#tabwinmerge#win_to_tab() "{{{
endfunction "}}}



function! s:exists_tab(tabpagenr) "{{{
    return 1 <= a:tabpagenr && a:tabpagenr <= tabpagenr('$')
endfunction "}}}



" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
