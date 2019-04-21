" .vimrc / config/plugins/vim-ragtag.vimrc
" Tag autocompletion for markup languages


" <C-X>=        foo<%= ^ %>
" <C-X>+        <%= foo^ %>
" <C-X>-        foo<% ^ %>
" <C-X>_        <% foo^ %>
" <C-X>'        foo<%# ^ %>
" <C-X>"        <%# foo^ %>
" <C-X><Space>  <foo>^</foo>
" <C-X><CR>     <foo>\n^\n</foo>
" <C-X>/        Last HTML tag closed
" <C-X>!        <!DOCTYPE...>/<?xml ...?>
" <C-X>@        <link rel="stylesheet" ...>
" <C-X>#        <meta http-equiv="Content-Type" ... />
" <C-X>$        <script src="/javascripts/^.js"></script>

Plug 'tpope/vim-ragtag'
