nnoremap <Leader>g :set operatorfunc=<SID>GrepOperator<CR>g@
vnoremap <Leader>g :<C-u>call <SID>GrepOperator(visualmode())<CR>

function! s:GrepOperator(type)
    let savedUnnamedRegister = @@

    if a:type ==# 'v'
        normal! `<y`>
    elseif a:type ==# 'char'
        normal! `[y`]
    else
        return
    endif

    silent execute "grep! -R " . shellescape(@@) . " ."
    copen

    let @@ = savedUnnamedRegister
endfunction

