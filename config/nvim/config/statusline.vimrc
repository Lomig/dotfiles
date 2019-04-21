" .vimrc / config/statusline.vimrc
" Configuration for Vim Status Line


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'itchyny/lightline.vim'
Plug 'nicknisi/vim-base16-lightline'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
 \   'colorscheme': 'base16',
 \   'active': {
 \       'left': [ [ 'mode', 'paste' ],
 \               [ 'gitbranch' ],
 \               [ 'readonly', 'filetype', 'filename' ]],
 \       'right': [ [ 'percent' ], [ 'lineinfo' ],
 \               [ 'fileformat', 'fileencoding' ],
 \               [ 'linter_errors', 'linter_warnings' ]]
 \   },
 \   'component_expand': {
 \       'linter': 'LightlineLinter',
 \       'linter_warnings': 'LightlineLinterWarnings',
 \       'linter_errors': 'LightlineLinterErrors',
 \       'linter_ok': 'LightlineLinterOk'
 \   },
 \   'component_type': {
 \       'readonly': 'error',
 \       'linter_warnings': 'warning',
 \       'linter_errors': 'error'
 \   },
 \   'component_function': {
 \       'mode': 'LightlineMode',
 \       'fileencoding': 'LightlineFileEncoding',
 \       'filename': 'LightlineFileName',
 \       'fileformat': 'LightlineFileFormat',
 \       'filetype': 'LightlineFileType',
 \       'gitbranch': 'LightlineGitBranch'
 \   },
 \   'tabline': {
 \       'left': [ [ 'tabs' ] ],
 \       'right': [ [ 'close' ] ]
 \   },
 \   'tab': {
 \       'active': [ 'filename', 'modified' ],
 \       'inactive': [ 'filename', 'modified' ],
 \   },
 \   'mode_map': {
 \     'NORMAL': 'N', 'INSERT': 'I', 'REPLACE': 'R', 'VISUAL': 'V', 'V-LINE': 'v', 'V-BLOCK': "\<C-v>",
 \     'COMMAND': 'C', 'SELECT': 's', 'S-LINE': 'S', 'S-BLOCK': "\<C-s>",  'TERMINAL': 'T'
 \   },
 \   'separator': { 'left': "\ue0c0 ", 'right': "\ue0c2 " },
 \   'subseparator': { 'left': '', 'right': '' }
 \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Function to change the name of the mode
function! LightlineMode() abort
    if len(expand('%:t')) <  winwidth(0) - 50
        return lightline#mode()
    else
        return get(g:lightline.mode_map, lightline#mode(), lightline#mode())
    endif
endfunction

" Function to get the file name of the buffer
function! LightlineFileName() abort
    let filename = len(expand('%')) < winwidth(0) - 38 ? expand('%') : expand('%:t')
    if filename =~ 'NERD_tree'
        return ''
    endif
    let modified = &modified ? ' +' : ''
    return fnamemodify(filename, ":~:.") . modified
endfunction

" Function returning the file encoding
function! LightlineFileEncoding()
    " Only show the file encoding if it's not 'utf-8'
    return &fileencoding == 'utf-8' ? '' : &fileencoding
endfunction

" Function returning file format
" Use an icon from WebDev Font instead of plain text
function! LightlineFileFormat()
    " Only show the file format if it's not 'unix'
    let format = &fileformat == 'unix' ? '' : &fileformat
    return winwidth(0) > 70 ? format . ' ' . WebDevIconsGetFileFormatSymbol() : ''
endfunction

" Function returning the MIME type of the file
" Use an icon from WebDev Font instead of plain text
function! LightlineFileType()
    return winwidth(0) > 70 ? WebDevIconsGetFileTypeSymbol() : ''
endfunction

" Functions showing the Linter status
function! LightlineLinter() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    return l:counts.total == 0 ? '' : printf('×%d', l:counts.total)
endfunction

function! LightlineLinterWarnings() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : '⚠ ' . printf('%d', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    return l:counts.total == 0 ? '' : '✖ ' . printf('%d', all_errors)
endfunction

function! LightlineLinterOk() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    return l:counts.total == 0 ? '✔︎' : ''
endfunction

" Function showing the Git Status
function! LightlineGitBranch()
    return "\uE725" . (exists('*fugitive#head') ? " " . fugitive#head() : '')
endfunction

augroup alestatus
    autocmd User ALELintPost call lightline#update()
augroup end

