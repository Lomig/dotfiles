" .vimrc / config/plugins.vimrc


for f in split(glob('$HOME/.config/nvim/config/plugins/*.vimrc'), '\n')
    exe 'source' f
endfor


" Add devicons to Vim
Plug 'ryanoasis/vim-devicons'

" Insert or delete parenthesis, brackets, quotes, ... in pairs
Plug 'jiangmiao/auto-pairs'

" Tmux Integration for Vim
Plug 'benmills/vimux'

" Support for .editorconfig
Plug 'editorconfig/editorconfig-vim'

" Single/multi line code handler:
" gS - split one line into multiple
" gJ - combine multiple lines into one
Plug 'AndrewRadev/splitjoin.vim'

" Add end, endif, etc. automatically
Plug 'tpope/vim-endwise'

" Detect indent style (tabs vs. spaces)
Plug 'tpope/vim-sleuth'

" Context-aware pasting
Plug 'sickill/vim-pasta'

Plug 'sheerun/vim-polyglot'
let g:vim_json_syntax_conceal = 0
