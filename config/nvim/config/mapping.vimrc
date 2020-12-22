" .vimrc / config/mapping.vimrc
" Configuration for key mapping


" Set a map leader for more key combos
nnoremap <SPACE> <Nop>
let mapleader = " "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" French AZERTY Helpers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Access numbers directly while in Normal Mode
nnoremap & 1
nnoremap é 2
nnoremap " 3
nnoremap ' 4
nnoremap ( 5
nnoremap § 6
nnoremap è 7
nnoremap ! 8
nnoremap ç 9
nnoremap à 0
nnoremap 1 &
nnoremap 2 é
nnoremap 3 "
nnoremap 4 '
nnoremap 5 (
nnoremap 6 §
nnoremap 7 è
nnoremap 8 !
nnoremap 9 ç
nnoremap 0 à

" Remap impossible shortcuts:
" Ctrl + ] --> Ctrl + $
" jk and kj --> Escape
nmap <C-]> <C-$>
inoremap jk <esc>
inoremap kj <esc>

" . is on shift on Azerty keyboards
" Remapping to ù
nnoremap ù .<cr>
vnoremap ù :normal .<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Splits, Buffers and Tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Move to <direction> split
" If there is no split there, create one
map <silent> <C-h> :call functions#WinMove('h')<cr>
map <silent> <C-j> :call functions#WinMove('j')<cr>
map <silent> <C-k> :call functions#WinMove('k')<cr>
map <silent> <C-l> :call functions#WinMove('l')<cr>

" Zoom the current buffer in a new tab
nnoremap <silent> <leader>= :call functions#zoom()<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text movements and changes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ï is <A-j> on macOS Azerty — Move the current line down
" È is <A-k> on macOS Azerty — Move the current line up
nnoremap Ï :m .+1<cr>==
nnoremap È :m .-2<cr>==
inoremap Ï <Esc>:m .+1<cr>==gi
inoremap È <Esc>:m .-2<cr>==gi
vnoremap Ï :m '>+1<cr>gv=gv
vnoremap È :m '<-2<cr>gv=gv

" Unescape HTML special characters back to UTF8 version
nnoremap <silent> <leader>u :call functions#HtmlUnEscape()<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cursor movements
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Moving normally even on wrapped lines
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$

" Scroll the viewport faster
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Toggle highlighting the current entire line
nnoremap <leader>i :set cursorline!<cr>
" Toggle invisible characters
nmap <leader>l :set list!<cr>
" Switch between the 2 last buffers
nmap <leader>ù <c-^>


set pastetoggle=<F3>

" Clear highlighted search
noremap <leader><space> :set hlsearch! hlsearch?<cr>

" Remove extra whitespace
nmap <leader><space><space> :%s/\s\+$<cr>
nmap <leader><space><space><space> :%s/\n\{2,}/\r\r/g<cr>

" Activate spell-checking alternatives
nmap <leader>sf :set invspell spelllang=fr<cr>
nmap <leader>se :set invspell spelllang=en<cr>

" Set tab to tabulations
nmap \t :set ts=4 sts=4 sw=4 noet<cr>
" Set tab to spaces
nmap \s :set ts=4 sts=4 sw=4 et<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ruby / Rails Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! VimuxRake()
    write
    call VimuxRunCommand("clear")
    VimuxClearRunnerHistory
    call VimuxRunCommand("rake")
endfunction

function! VimuxRubyRun()
    write
    call VimuxRunCommand("clear")
    call VimuxRunCommand("ruby " . bufname("%"))
endfunction

map <leader>c :call VimuxRake()<CR>
map <leader>cc :call VimuxRubyRun()<CR>
