" vim:foldmethod=marker:fen:
scriptencoding utf-8

" Load Once {{{
if exists('g:loaded_quickey') && g:loaded_quickey
    finish
endif
let g:loaded_quickey = 1
" }}}
" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}


function! s:def(varname, default_value) "{{{
    if !exists(a:varname)
        let {a:varname} = a:default_value
    endif
endfunction "}}}
function! s:init_vars() "{{{
    call s:def('g:quickey_no_default_all_keymappings', 0)
    for [varname, value] in [
    \   ['g:quickey_no_default_tabwinmerge_keymappings', 0],
    \   ['g:quickey_no_default_swap_window_keymappings', 0],
    \   ['g:quickey_no_default_merge_window_keymappings', 0],
    \   ['g:quickey_no_default_split_keymappings', 0],
    \   ['g:quickey_no_default_new_keymappings', 0],
    \]
        " Currently, 0 is default values to all "no default" variables.
        call s:def(varname, g:quickey_no_default_all_keymappings ? 1 : value)
    endfor
endfunction "}}}


call s:init_vars()

delfunc s:def
delfunc s:init_vars



" tabwinmerge {{{
nnoremap
\   <Plug>(quickey:tabwinmerge:tab:to-left)
\   :<C-u>call quickey#tabwinmerge#tab_to_tab(tabpagenr(), tabpagenr() - 1)<CR>
nnoremap
\   <Plug>(quickey:tabwinmerge:tab:to-right)
\   :<C-u>call quickey#tabwinmerge#tab_to_tab(tabpagenr(), tabpagenr() + 1)<CR>
nnoremap
\   <Plug>(quickey:tabwinmerge:tab:to-input-nr)
\   :<C-u>call quickey#tabwinmerge#tab_to_tab(tabpagenr(), str2nr(input('tab number:')))<CR>

nnoremap
\   <Plug>(quickey:tabwinmerge:win:to-left)
\   :<C-u>call quickey#tabwinmerge#win_to_tab(winnr(), tabpagenr() - 1)<CR>
nnoremap
\   <Plug>(quickey:tabwinmerge:win:to-right)
\   :<C-u>call quickey#tabwinmerge#win_to_tab(winnr(), tabpagenr() + 1)<CR>
nnoremap
\   <Plug>(quickey:tabwinmerge:win:to-input-nr)
\   :<C-u>call quickey#tabwinmerge#win_to_tab(winnr(), str2nr(input('tab number:')))<CR>

if !g:quickey_no_default_tabwinmerge_keymappings
    nmap <Space>mh <Plug>(quickey:tabwinmerge:win:to-left)
    nmap <Space>ml <Plug>(quickey:tabwinmerge:win:to-right)
    nmap <Space>m  <Plug>(quickey:tabwinmerge:win:to-input-nr)
endif
" }}}

" swap-window {{{
nnoremap <silent>
\   <Plug>(quickey:swap-window:to-next)
\   :<C-u>call quickey#swap_window#swap_with_count(v:count1)<CR>
nnoremap <silent>
\   <Plug>(quickey:swap-window:to-prev)
\   :<C-u>call quickey#swap_window#swap_with_count(-v:count1)<CR>
nnoremap <silent>
\   <Plug>(quickey:swap-window:to-down)
\   :<C-u>call quickey#swap_window#swap_with_wincmd(v:count1, 'j')<CR>
nnoremap <silent>
\   <Plug>(quickey:swap-window:to-up)
\   :<C-u>call quickey#swap_window#swap_with_wincmd(v:count1, 'k')<CR>
nnoremap <silent>
\   <Plug>(quickey:swap-window:to-left)
\   :<C-u>call quickey#swap_window#swap_with_wincmd(v:count1, 'h')<CR>
nnoremap <silent>
\   <Plug>(quickey:swap-window:to-right)
\   :<C-u>call quickey#swap_window#swap_with_wincmd(v:count1, 'l')<CR>
nnoremap <silent>
\   <Plug>(quickey:swap-window:to-top)
\   :<C-u>call quickey#swap_window#swap_with_wincmd(v:count1, 't')<CR>
nnoremap <silent>
\   <Plug>(quickey:swap-window:to-bottom)
\   :<C-u>call quickey#swap_window#swap_with_wincmd(v:count1, 'b')<CR>

if !g:quickey_no_default_swap_window_keymappings
    nmap <Space><C-n> <Plug>(quickey:swap-window:to-next)
    nmap <Space><C-p> <Plug>(quickey:swap-window:to-prev)
    nmap <Space><C-j> <Plug>(quickey:swap-window:to-down)
    nmap <Space><C-k> <Plug>(quickey:swap-window:to-up)
    nmap <Space><C-h> <Plug>(quickey:swap-window:to-left)
    nmap <Space><C-l> <Plug>(quickey:swap-window:to-right)
endif
" }}}

" merge-window {{{
nnoremap <silent>
\   <Plug>(quickey:merge-window:to-down)
\   :<C-u>call quickey#merge_window#merge('j', 'J', 1)<CR>
nnoremap <silent>
\   <Plug>(quickey:merge-window:to-up)
\   :<C-u>call quickey#merge_window#merge('k', 'K', 1)<CR>
nnoremap <silent>
\   <Plug>(quickey:merge-window:to-left)
\   :<C-u>call quickey#merge_window#merge('h', 'H', 0)<CR>
nnoremap <silent>
\   <Plug>(quickey:merge-window:to-right)
\   :<C-u>call quickey#merge_window#merge('l', 'L', 0)<CR>

if !g:quickey_no_default_merge_window_keymappings
    nmap <Space>J <Plug>(quickey:merge-window:to-down)
    nmap <Space>K <Plug>(quickey:merge-window:to-up)
    nmap <Space>H <Plug>(quickey:merge-window:to-left)
    nmap <Space>L <Plug>(quickey:merge-window:to-right)
endif
" }}}

" split {{{
    nnoremap <silent>
    \   <Plug>(quickey:split:to-down)
    \   :<C-u>execute 'belowright' (v:count == 0 ? '' : v:count) 'split'<CR>
    nnoremap <silent>
    \   <Plug>(quickey:split:to-up)
    \   :<C-u>execute 'aboveleft' (v:count == 0 ? '' : v:count) 'split'<CR>
    nnoremap <silent>
    \   <Plug>(quickey:split:to-left)
    \   :<C-u>execute 'aboveleft' (v:count == 0 ? '' : v:count) 'vsplit'<CR>
    nnoremap <silent>
    \   <Plug>(quickey:split:to-right)
    \   :<C-u>execute 'belowright' (v:count == 0 ? '' : v:count) 'vsplit'<CR>

if !g:quickey_no_default_split_keymappings
    nmap <Space>sj <Plug>(quickey:split:to-down)
    nmap <Space>sk <Plug>(quickey:split:to-up)
    nmap <Space>sh <Plug>(quickey:split:to-left)
    nmap <Space>sl <Plug>(quickey:split:to-right)
endif
" }}}

" new {{{
    nnoremap <silent>
    \   <Plug>(quickey:new:to-down)
    \   :<C-u>execute 'belowright' (v:count == 0 ? '' : v:count) 'new'<CR>
    nnoremap <silent>
    \   <Plug>(quickey:new:to-up)
    \   :<C-u>execute 'aboveleft' (v:count == 0 ? '' : v:count) 'new'<CR>
    nnoremap <silent>
    \   <Plug>(quickey:new:to-left)
    \   :<C-u>execute 'aboveleft' (v:count == 0 ? '' : v:count) 'vnew'<CR>
    nnoremap <silent>
    \   <Plug>(quickey:new:to-right)
    \   :<C-u>execute 'belowright' (v:count == 0 ? '' : v:count) 'vnew'<CR>

if !g:quickey_no_default_new_keymappings
    nmap <Space>ej <Plug>(quickey:new:to-down)
    nmap <Space>ek <Plug>(quickey:new:to-up)
    nmap <Space>eh <Plug>(quickey:new:to-left)
    nmap <Space>el <Plug>(quickey:new:to-right)
endif
" }}}



" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
" }}}
