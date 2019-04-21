" .vimrc / config/plugins/vim-abolish.org
" Abolish replace Abbreviations when dealing with multiple formats


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abolish example
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :iabbrev  seperate  separate
" :iabbrev desparate desperate
" :iabbrev  Seperate  Separate
" :iabbrev Desparate Desperate
" :iabbrev  SEPERATE  SEPARATE
" :iabbrev DESPARATE DESPERATE
" :iabbrev  seperation  separation
" :iabbrev desparation desperation
" :iabbrev  seperately  separately
" :iabbrev desparately desperately
" :iabbrev  Seperation  separation
" :iabbrev Desparation Desperation
" :iabbrev  Seperately  Separately
" :iabbrev Desparately Desperately
" :iabbrev  SEPERATION  SEPARATION
" :iabbrev DESPARATION DESPERATION
" :iabbrev  SEPERATELY  SEPARATELY
" :iabbrev DESPARATELY DESPERATELY
"
" -->
"
" :Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" %Subvert example
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :%s/facility/building/g
" :%s/Facility/Building/g
" :%s/FACILITY/BUILDING/g
" :%s/facilities/buildings/g
" :%s/Facilities/Buildings/g
" :%s/FACILITIES/BUILDINGS/g
"
" -->
"
"  :%Subvert/facilit{y,ies}/building{,s}/g


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Coercion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fooBar -> foo_bar : crs (Snake Case)
" fooBar -> FooBar  : crm (Mixed Case)
" fooBar -> fooBar  : crc (Camel Case)
" fooBar -> FOO_BAR : cru (Upper Case)
" fooBar -> foo-bar : cr- (Dash Case)
" fooBar -> foo.bar : cr. (Dot Case) 
" fooBar -> foo bar : cr<space> (Space Case) 
" fooBar -> Foo Bar : crt (Title Case)

Plug 'tpope/vim-abolish'
