" .vimrc / config/plugins/vim-surround.vimrc


" 'Hello *world!'           ds'         Hello world!
" [123+4*56]/2              cs])        (123+456)/2
" 'Look ma, I'm *HTML!'     cs'<q>      <q>Look ma, I'm HTML!</q>
" if *x>3 {                 ysW(        if ( x>3 ) {
" my $str = *whee!;         vllllS'     my $str = 'whee!';

Plug 'tpope/vim-surround'
