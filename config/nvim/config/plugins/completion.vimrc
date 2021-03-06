" .vimrc / config/plugins/completion.vimrc
" Plugins linked to auto completion and snippets


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snippets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'honza/vim-snippets'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'neoclide/coc.nvim', {'branch': 'release'}

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

let g:coc_global_extensions = ['coc-json', 'coc-snippets', 'coc-solargraph', 'coc-highlight', 'coc-emmet', 'coc-yaml', 'coc-css', 'coc-html', 'coc-bootstrap-classname', 'coc-highlight', 'coc-eslint', 'coc-json', 'coc-tailwindcss', 'coc-tsserver']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Generalist mods
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Add end, endif, etc. automatically
Plug 'tpope/vim-endwise'

" Insert or delete parenthesis, brackets, quotes, ... in pairs
Plug 'jiangmiao/auto-pairs'
au FileType eruby let b:AutoPairs = AutoPairsDefine({'<%' : '%>', '<%=': '=%>'})


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ruby
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load/evaluate code to provide better completion
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

" String interpolation completion
Plug 'p0deje/vim-ruby-interpolation'
