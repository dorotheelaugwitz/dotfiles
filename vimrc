" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Make backspace work like backspace
set backspace=2

" Use one space, not two, after punctuation.
set nojoinspaces

" Make it obvious where 72 characters is
set textwidth=72
set colorcolumn=+1

" Numbers
set number
set numberwidth=5
