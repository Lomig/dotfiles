" .vimrc / config/plugins.vimrc


for f in split(glob('$HOME/.config/nvim/config/plugins/*.vimrc'), '\n')
    exe 'source' f
endfor


" Add devicons to Vim
Plug 'ryanoasis/vim-devicons'

" Tmux Integration for Vim
Plug 'benmills/vimux'

" Support for .editorconfig
Plug 'editorconfig/editorconfig-vim'

" Single/multi line code handler:
" gS - split one line into multiple
" gJ - combine multiple lines into one
Plug 'AndrewRadev/splitjoin.vim'

" Detect indent style (tabs vs. spaces)
Plug 'tpope/vim-sleuth'

" Context-aware pasting
Plug 'sickill/vim-pasta'
