call plug#begin('~/.vim/pluggers')

" Themes
Plug 'dikiaap/minimalist'
Plug 'wdhg/dragon-energy'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'crusoexia/vim-monokai'

" Plugins
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " './install --bin' to only have fzf in vim
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-gitgutter'
" Plug 'plasticboy/vim-markdown'
Plug 'evanleck/vim-svelte'

call plug#end()

" Custom functions ----------------------------- {{{
" Indents file and puts the cursor back to where it was
function! IndentFile()
    normal! gg=G
    normal! ``
endfunction
" }}}

" Basic settings ------------------------------- {{{
syntax on

set updatetime=100

" Highlight searchresults
set hlsearch

" Set incremental search
set incsearch

" Show line numbers
set number

" Shows line number relative to cursor
set relativenumber

" Show matching parenthesis
set showmatch

" Scroll offset
set scrolloff=7

" Set height of the command row
set cmdheight=1

" Always show status line
set laststatus=2

" Colors and stuff
set background=dark
colorscheme gruvbox

" Show existing tab with 4 spaces width
set tabstop=4

" When indenting with '>', use 4 spaces
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab

" Highligh groups
highlight TodoGroup ctermfg=yellow

" Set grep program to ripgrep
set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m
" }}}

" Key mappings --------------------------------- {{{
" Remap <space> to fold and unfold
nnoremap <Space> za

" Remap - to move line one below
nnoremap <Leader>- ddp

" Remap _ to move line one up
nnoremap <Leader>_ dd2kp

" Mapping to open .vimrc
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>

" Mapping to source .vimrc
nnoremap <Leader>sv :source $MYVIMRC<CR>

" Open previous buffer to the right in vertical split
nnoremap <Leader>spb :<C-u>execute "rightbelow vsplit " . bufname("#")<CR>

" Mapping to wrap selection in double quotes
vnoremap <Leader>" <ESC>`>a"<ESC>`<i"<ESC>lel

" Mapping to wrap selection in single quotes
vnoremap <Leader>' <ESC>`>a'<ESC>`<i'<ESC>lel

" Motion to select inside next {} block
onoremap in{ :<C-u>execute "normal! \/\{\r:noh\rvi{"<CR>
omap in} in{

" Motion to select around next {} block
onoremap an{ :<C-u>execute "normal! \/\{\r:noh\rva{"<CR>
omap an} an{

" Motion to select next email
onoremap in@ :<C-u>execute "normal! /\\S\\+@\\S\\+\r:noh\rviW"<CR>

" Arrow keys are forbidden!
noremap <Left> <NOP>
inoremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
inoremap <Up> <NOP>
noremap <Down> <NOP>
inoremap <Down> <NOP>

nnoremap <BS> :noh<CR>
" }}}

" Random abbreviations ------------------------- {{{
iabbrev shrug ¯\_(ツ)_/¯
iabbrev teh the
iabbrev @@ jesper.hasselquist@gmail.com
iabbrev ssig Best regards,<CR>Jesper Hasselquist<CR>jesper.hasselquist@gmail.com<CR>UwU
" }}}

" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    " Clear autocmds in this group
    autocmd!

    autocmd FileType vim setlocal foldmethod=marker

    " Comment
    autocmd FileType vim nnoremap <buffer> <LocalLeader>c I" <ESC>
augroup END
" }}}

" Markdown file settings ----------------------- {{{
augroup filetype_markdown
    " Clear autocmds in this group
    autocmd!
    " Motion to select heading of paragraph in markdown including == or -- heading
    " markers
    autocmd FileType markdown onoremap ah :<C-u>execute "normal! ?^==\\+$\\\|^--\\+$\r:nohlsearch\rg_vk0"<CR>
augroup END
" }}}

" Javascript file settings --------------------- {{{
augroup filetype_javascript
    " Clear autocmds in this group
    autocmd!
    " Comment
    autocmd FileType javascript nnoremap <buffer> <LocalLeader>c I//<ESC>
    " Autoindent
    autocmd BufWritePre *.js call IndentFile()

    " Highlight TODOs
    autocmd FileType javascript match TodoGroup /\vTODO.*/

    " Highlight trailing whitespace
    autocmd FileType javascript match Error /\v +$/

    " Set fold method to syntax when file syntax is javascript
    autocmd Syntax javascript setlocal foldmethod=syntax
    " Open all folds on syntax javascript
    autocmd Syntax javascript normal zR

    " Not that useful, but hey. ¯\_(ツ)_/¯
    autocmd FileType javascript :iabbrev <buffer> iff if () {<CR>}<C-o>k<C-o>f)
    autocmd FileType javascript :iabbrev <buffer> func function ()
augroup END
" }}}

" JSON file setting ---------------------------- {{{
augroup filetype_json
    " Clear autocmds in this group
    autocmd!

    " Highlight trailing whitespace
    autocmd FileType json match Error /\v +$/

    " Set fold method to syntax when file syntax is json
    autocmd Syntax json setlocal foldmethod=syntax
    " Open all folds on syntax json
    autocmd Syntax json normal zR

    " Show existing tab with 2 spaces width
    autocmd FileType json set tabstop=2

    " When indenting with '>', use 2 spaces
    autocmd FileType json set shiftwidth=2

    " On pressing tab, insert 2 spaces
    autocmd FileType json set expandtab
augroup END
" }}}

" Html file settings --------------------------- {{{
augroup filetype_html
    " Clear autocmds in this group
    autocmd!
    " Autoindent
    autocmd BufWritePre *.html normal gg=G
    " Comment
    autocmd FileType html nnoremap <buffer> <LocalLeader>c I<!-- <ESC>A --><ESC>
    " Create fold on current tag
    autocmd FileType html nnoremap <buffer> <LocalLeader>f Vatzf
augroup END
" }}}

" Python file settings ------------------------- {{{
augroup filetype_python
    " Clear autocmds in this group
    autocmd!
    " Comment
    autocmd FileType python nnoremap <buffer> <LocalLeader>c I#<ESC>
augroup END
" }}}

" Statusline customization --------------------- {{{
set statusline=%f       " Relative file path
set statusline+=\       " Separator <space>
set statusline+=%y      " FileType
set statusline+=%=      " Shift to right side
set statusline+=%l      " Current line
set statusline+=/       " Separator
set statusline+=%L      " Total lines
" }}}

" fzf configuration ---------------------------- {{{
nnoremap <C-p> :Files<CR>
nnoremap <Leader>t :Tags<CR>
" }}}

" Gutentags configuration ---------------------- {{{
set statusline+=%{gutentags#statusline()}
let g:gutentags_cache_dir='~/gutentags'
" }}}

" Coc configuration ---------------------------- {{{
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()
" }}}

" Gitgutter configuration ---------------------- {{{
let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn
highlight GitGutterAdd ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1
highlight GitGutterChangeDelete ctermfg=4
" }}}

" vim-svelte configuration --------------------- {{{
let g:svelte_indent_script = 0
let g:svelte_indent_style = 0
" }}}

