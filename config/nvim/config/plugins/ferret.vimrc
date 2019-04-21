" .vimrc / config/plugins/ferret.vimrc

" :Ack {pattern} {options}         -> Search across multiple files
" :Back {pattern} {options}        -> Search across multiple buffers
" :Quack {pattern} {options}       -> Search across files in QuickList
" :Acks /{pattern}/{replacement}/  -> Substitute across files in QuickList


Plug 'wincent/ferret'
let g:FerretMap = 0 " No mapping of Ferret commands on <leader> shortcuts
