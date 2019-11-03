" .vimrc / config/plugins/ale.vimrc
" Linting Tool

Plug 'w0rp/ale' " Asynchonous linting engine
let g:ale_set_highlights = 0
let g:ale_change_sign_column_color = 0
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_echo_msg_error_str = '✖'
let g:ale_echo_msg_warning_str = '⚠'
let g:ale_echo_msg_format = '%severity% %s% [%linter%% code%]'
" let g:ale_completion_enabled = 1

let g:ale_linters = {
\   'ruby':['rubocop'],
\   'javascript': ['eslint'],
\   'typescript': ['tsserver', 'tslint'],
\   'typescript.tsx': ['tsserver', 'tslint'],
\   'html': []
\}
let g:ale_fixers = {}
let g:ale_fixers['ruby'] = ['standardrb']
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['typescript'] = ['prettier', 'tslint']
let g:ale_fixers['json'] = ['prettier']
let g:ale_fixers['css'] = ['prettier']
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_fix_on_save = 1
nmap <silent><leader>af :ALEFix<cr>

