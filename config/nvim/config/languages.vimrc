" .vimrc / languages.vimrc
" Language-specific settings for Vim

""""""""""""""""""""""""""""""""""""""""
" All Languages
""""""""""""""""""""""""""""""""""""""""

Plug 'sheerun/vim-polyglot'
let g:vim_json_syntax_conceal = 0


""""""""""""""""""""""""""""""""""""""""
" CSS 3
""""""""""""""""""""""""""""""""""""""""

" Plug 'hail2u/vim-css3-syntax'


""""""""""""""""""""""""""""""""""""""""
" Ruby and Rails
""""""""""""""""""""""""""""""""""""""""

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'vim-utils/vim-ruby-fold'


""""""""""""""""""""""""""""""""""""""""
" JSON
""""""""""""""""""""""""""""""""""""""""

Plug 'elzr/vim-json'

au! BufRead,BufNewFile *.json set filetype=json


""""""""""""""""""""""""""""""""""""""""
" Ocaml
""""""""""""""""""""""""""""""""""""""""

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
" let s:opam_share_dir = system("opam config var share")
" let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

" let s:opam_configuration = {}

" function! OpamConfOcpIndent()
"   execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
" endfunction
" let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

" function! OpamConfOcpIndex()
"   execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
" endfunction
" let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

" function! OpamConfMerlin()
"   let l:dir = s:opam_share_dir . "/merlin/vim"
"   execute "set rtp+=" . l:dir
" endfunction
" let s:opam_configuration['merlin'] = function('OpamConfMerlin')

" let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
" let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
" let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
" for tool in s:opam_packages
"   " Respect package order (merlin should be after ocp-index)
"   if count(s:opam_available_tools, tool) > 0
"     call s:opam_configuration[tool]()
"   endif
" endfor
" " ## end of OPAM user-setup addition for vim / base ## keep this line

" " ## added by OPAM user-setup for vim / ocp-indent ## 6db7403beacb05e3857f1f9797577afa ## you can edit, but keep this line
" if count(s:opam_available_tools,"ocp-indent") == 0
"   source "/Users/lomig/.opam/default/share/ocp-indent/vim/indent/ocaml.vim"
" endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
