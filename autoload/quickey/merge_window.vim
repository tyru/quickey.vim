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



function! quickey#merge_window#merge(jump_cmd, layout_cmd, vertical) "{{{
    " Save global options.
    "
    " NOTE: These are global options but
    " I think "l:" should be attached
    " when I assign value to option value.
    " because newer Vim may support them
    " as local options.
    let save_ei = &eventignore
    let save_hidden = &hidden
    let &l:eventignore = 'all'
    let &l:hidden = 0

    try
        let curbuf = bufnr('%')
        let i = 0
        while i < v:count1
            let curwin = winnr()
            execute 'wincmd' a:jump_cmd
            let nextgroupwin = winnr()

            if curwin ==# nextgroupwin
                " No more next group. Create new group.
                execute 'wincmd' a:layout_cmd
            else
                wincmd p
                " Close `curwin` window.
                let save_buftype = &l:buftype
                setlocal bufhidden=
                hide
                " Back to `nextgroupwin` window.
                wincmd p

                execute (a:vertical ? 'vsplit' : 'split')
            endif

            let i += 1
        endwhile
        let &l:eventignore = save_ei    " to detect `curbuf` buffer filetype.
        silent execute curbuf 'buffer'
    finally
        let &l:eventignore = save_ei
        let &l:hidden = save_hidden
    endtry
endfunction "}}}



" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
