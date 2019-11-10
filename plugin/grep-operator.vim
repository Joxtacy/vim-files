nnoremap <Leader>g :set operatorfunc=<SID>GrepOperator<CR>g@
vnoremap <Leader>g :<C-u>call <SID>GrepOperator(visualmode())<CR>

" This function assumes that ripgrep is set as the grep command.
" https://vi.stackexchange.com/questions/8855/how-can-i-change-the-default-grep-call-grepprg-to-exclude-directories
function! s:GrepOperator(type)
    let savedUnnamedRegister = @@

    if a:type ==# 'v'
        normal! `<y`>
    elseif a:type ==# 'char'
        normal! `[y`]
    else
        return
    endif

    silent execute "grep! " . shellescape(@@) . " ."
    copen

    let @@ = savedUnnamedRegister
endfunction

