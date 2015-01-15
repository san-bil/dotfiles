set nocompatible
set virtualedit=onemore
set backspace=indent,eol,start
set cm=blowfish
set ff=unix
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set number
set updatetime=100
set cursorline
set smartcase
set title
set confirm
set pastetoggle=<F10>


:hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

colorscheme molokai
let g:rehash256 = 1

