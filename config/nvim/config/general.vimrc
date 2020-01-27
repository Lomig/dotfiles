" .vimrc / config/general.vimrc
" General configuration for nvim behaviour

" Disable Arrow Keys — Vim Hardmode!
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shell=$SHELL                " Set Vim Shell to Environment Shell

set autoread                    " Detect when a buffer is changed
set hidden                      " Buffer put into background instead of closed

set history=1000                " Set history to 1000
set textwidth=120               " Set width limit to 120 (instead of 80)

set backspace=indent,eol,start  " Allow backspace to work everywhere
set clipboard=unnamed           " Let Vim use the system clipboard as first buffer

set noerrorbells                " No beeping on error
set visualbell                  " Visual blink instead of sound
set t_vb=                       " Blink set to none to remove it too
set tm=750                      " Delay for composed shortcut before error

" Put every temp and swap files in a separate directory
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Incompatible with standard vim
if (has('nvim'))
    set inccommand=split        " Show %s/foo/bar/g results in a temp split
endif

" Use mouse if detected
if has('mouse')
    set mouse=a
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching Behaviour
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ignorecase                  " Case insensitive searching...
set smartcase                   " ...but if expresson contains a capital letter
set hlsearch                    " Highlight search results
set incsearch                   " Set incremental live search
set nolazyredraw                " Don't redraw while executing macros

set magic                       " Set magic on, for regex


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Appearance
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                      " Show line number on active line
set relativenumber              " Show relative line numbers on other lines

" Make the number not relative in INSERT mode or if the buffer has not the focus
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

set wrap                        " Turn on line wrapping
set wrapmargin=8                " Right margin before wrapping lines
set linebreak                   " Don't wrap in the middle of a word

set so=7                        " Scroll if 7 lines left below/above the cursor
set showmatch                   " Show matching braces
set mat=2                       " Matching braces blink duration (1/10 second)

set autoindent                  " Automatically set indent of new line
set list                        " Toggle invisible characters
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

set ttyfast                     " Faster redrawing for modern consoles / tty

set diffopt+=vertical           " Diff files with a vertical split
if argc() == 2                  " Vertical split as default if opening two files
    silent vertical all
endif

set laststatus=2                " Show the satus line all the time
set showcmd                     " Show incomplete commands under status bar
set noshowmode                  " Don't show legacy mode — Disabled for PowerLine
set cmdheight=1                 " Command bar height

set wildmenu                    " Enhanced command line completion
set wildmode=list:longest,full  " Completion behaves like in a shell

set title                       " Set Terminal title to Vim

set t_Co=256                    " Force 256 colours mode
set t_ut=                       " Prevents background colour to be erased

" Enable 24 bit color support if supported
if (has("termguicolors"))
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

" Switch cursor to line when in insert mode, and block when not
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
\,sm:block-blinkwait175-blinkoff150-blinkon175

" Highlight conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab Control
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set smarttab			" Tab respects 'tabstop', 'shiftwidth' and 'softtabstop'
set tabstop=4			" The visible width of tabs
set softtabstop=4		" Edit as if the tabs are 4 characters wide
set shiftwidth=4		" Number of spaces to use for indent and unindent
set shiftround			" Round indent to a multiple of 'shiftwidth'
set noexpandtab			" Insert tabs rather than spaces for <Tab>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Code Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=syntax	" Fold based on indent
set foldlevelstart=99	" Prevent folding on file opening
set foldnestmax=10		" Deepest fold is 10 levels
set nofoldenable		" Don't fold by default
set foldlevel=1			" Fold opportunity at each indent change


