" .vimrc / config/plugins/git.vimrc
" Plugins helping with Git usage

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin — Signify
" Show the differences from master in the left margin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'mhinz/vim-signify'

let g:signify_vcs_list = [ 'git' ]
let g:signify_sign_add               = '┃'
let g:signify_sign_delete            = '-'
let g:signify_sign_delete_first_line = '_'
let g:signify_sign_change = '┃'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin - Vim-Fugitive
" Vim GIT Wrapper
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " hub extension for fugitive
Plug 'junegunn/gv.vim'
Plug 'sodapopcan/vim-twiggy'

nmap <silent> <leader>gs :Gstatus<cr>
nmap <leader>ge :Gedit<cr>
nmap <silent><leader>gr :Gread<cr>
nmap <silent><leader>gb :Gblame<cr>
