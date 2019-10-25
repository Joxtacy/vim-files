nnoremap <leader>f :call <SID>FoldColumnToggle()<CR>

function! s:FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=4
    endif
endfunction
