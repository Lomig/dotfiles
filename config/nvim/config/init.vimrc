" .vimrc / config/init.vimrc
" Initialize vim-plug
" Load colorschemes

" vim-plug installation / call
call functions#PlugLoad()
call plug#begin('~/.config/nvim/plugged')

" Colorschemes
Plug 'chriskempson/base16-vim'
Plug 'joshdick/onedark.vim'

