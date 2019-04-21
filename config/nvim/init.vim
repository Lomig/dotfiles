" .vimrc / init.vim
" The following vim/neovim configuration works for both Vim and NeoVim

source $HOME/.config/nvim/config/init.vimrc
source $HOME/.config/nvim/config/abbreviations.vimrc
source $HOME/.config/nvim/config/general.vimrc
source $HOME/.config/nvim/config/statusline.vimrc
source $HOME/.config/nvim/config/mapping.vimrc
source $HOME/.config/nvim/config/autogroups.vimrc
source $HOME/.config/nvim/config/plugins.vimrc

call plug#end()

" Colorscheme and final setup {{{
    " This call must happen after the plug#end() call to ensure
    " that the colorschemes have been loaded
    if filereadable(expand("~/.vimrc_background"))
        let base16colorspace=256
        source ~/.vimrc_background
    else
        let g:onedark_termcolors=16
        let g:onedark_terminal_italics=1
        colorscheme onedark
    endif
    syntax on
    filetype plugin indent on
    " make the highlighting of tabs and other non-text less annoying
    " highlight SpecialKey ctermfg=19 guifg=#333333
    " highlight NonText ctermfg=19 guifg=#333333

    " make comments and HTML attributes italic
    highlight Comment cterm=italic term=italic gui=italic
    highlight htmlArg cterm=italic term=italic gui=italic
    highlight xmlAttrib cterm=italic term=italic gui=italic
    " highlight Type cterm=italic term=italic gui=italic
    highlight Normal ctermbg=none

" }}}

" vim:set foldmethod=marker foldlevel=0
