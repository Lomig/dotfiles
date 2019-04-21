" .vimrc / config/plugins/vim-commentary.vimrc

" gcc         -> Comments / Uncomments a line — it can take a count
" gc{motion}  -> Comments the text targeted by the motion
" to add a custom comment string for a file type:
" autocmd FileType apache setlocal commentstring=#\ %s

Plug 'tpope/vim-commentary'
