"j+h to normal mode
inoremap jh <Esc>
vnoremap p "_dP

"line numbers
set number relativenumber

"syntax highlighting
syntax on

"cursor changes in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

"tabs are 4 spaces long
set tabstop=4
set shiftwidth=4
set expandtab

"tab completion
set wildmode=longest,list,full
set wildmenu

"copy and paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa
