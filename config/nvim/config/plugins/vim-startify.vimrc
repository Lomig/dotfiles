" .vimrc / config/plugins/vim-startify.vimrc
" Startup screen for Vim


Plug 'mhinz/vim-startify'

" General Configuration
let g:startify_files_number = 10    " Number of files to show
let g:startify_change_to_dir = 0    " Don't change working dir opening a file
let g:startify_custom_header = [ ]  " Custom header. Do you want a cow?
let g:startify_relative_path = 1    " Show relative paths for files
let g:startify_use_env = 1          " Use env variable to reduce path


function! s:list_commits()
    let git = 'git -C ' . getcwd()
    let commits = systemlist(git . ' log --oneline | head -n5')
    let git = 'G' . git[1:]
    return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
endfunction

" Startup list
" Only show Most Recently Used files from the current project
let g:startify_lists = [
\  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
\  { 'type': function('s:list_commits'), 'header': [ 'Recent Commits' ] },
\  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
\  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
\  { 'type': 'commands',  'header': [ 'Commands' ]       },
\ ]

let g:startify_commands = [
\   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
\   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
\ ]

let g:startify_bookmarks = [
    \ { 'c': '~/.dotfiles/config/nvim/init.vim' },
    \ { 'z': '~/.dotfiles/zsh/zshrc.symlink' }
\ ]

autocmd User Startified setlocal cursorline
