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

function! quickey#tabwinmerge#win_to_tab(from_winnr, to_tabpagenr, ...) "{{{
    let create_tab = a:0 ? a:1 : 0

    if !s:exists_win(a:from_winnr)
        return
    endif
    if a:to_tabpagenr <= 0
        return
    endif
    if !create_tab && !s:exists_tab(a:to_tabpagenr)
        return
    endif


    let from_tabpagenr = tabpagenr()
    let buflist = tabpagebuflist(from_tabpagenr)
    if winnr('$') == 1
        return call('quickey#tabwinmerge#tab_to_tab', [from_tabpagenr, a:to_tabpagenr] + a:000)
    endif

    call s:close_win(a:from_winnr)
    execute 'tabnext' a:to_tabpagenr

    split
    execute buflist[a:from_winnr - 1] 'buffer'
endfunction "}}}



function! s:exists_tab(tabpagenr) "{{{
    return 1 <= a:tabpagenr && a:tabpagenr <= tabpagenr('$')
endfunction "}}}

function! s:exists_win(winnr) "{{{
    return 1 <= a:winnr && a:winnr <= winnr('$')
endfunction "}}}

function! s:close_win(winnr) "{{{
    let curwinnr = winnr()
    call s:jump_to_win(a:winnr)
    close
    call s:jump_to_win(curwinnr)
endfunction "}}}

function! s:jump_to_win(winnr) "{{{
    if winnr() != a:winnr
        execute a:winnr 'wincmd w'
    endif
endfunction "}}}



" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
