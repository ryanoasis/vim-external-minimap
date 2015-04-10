silent !gvim +line(".") "+set lines=30" "+set columns=20" "+set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 2" %

!gvim +line(".") "+set lines=30" "+set columns=20" "+set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 2" %


====

execute ':silent !gvim +line(".") "+set lines=30" "+set columns=20" "+set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 2" %'

execute ":silent !gvim +line('.') '+set lines=30' '+set columns=20' '+set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 2' %"

execute ": !gvim +" . shellescape(line(".")) . " '+set lines=30' '+set columns=20' '+set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 2' %"


execute ": !gvim +" . shellescape(line(".")) . ' "+set lines=30" "+set columns=20" "+set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 2" %'

execute ": !gvim +" . shellescape(line(".")) . ' % "+set lines=30" "+set columns=20" "+set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 2"'


execute ": !gvim +" . shellescape(line(".")) . ' % "+set lines=30" "+winpos 0 0" "+set columns=20" "+set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 3"'


== hide shit:

=== too many arguments?

execute ": !gvim -R +" . shellescape(line(".")) . ' % "+set lines=30" "+winpos 0 0" "+set columns=20" "+set norelativenumber" "+set nonumber" "+set foldcolumn=0" "+set tabline=" "+set noshowmode" "+set noruler" "+set laststatus=0" "+set noshowcmd" "+set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 3"'

===


execute ": !gvim -R % +" . shellescape(line(".")) . ' "+set nonumber" "+set foldcolumn=0" "+set tabline=" "+set noshowmode" "+set noruler" "+set laststatus=0" "+set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 3" "+set lines=30" "+set columns=20"'


=== show mode remove? no effect? add set norelativenumber instead:

execute ": !gvim -R % +" . shellescape(line(".")) . ' "+set nonumber" "+set foldcolumn=0" "+set tabline=" "+set norelativenumber" "+set noruler" "+set laststatus=0" "+set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 3" "+set lines=30" "+set columns=20"'

=== same as above ^ but silent and tweaked cols and lines to match the small font size (it is set before):

execute ":silent !gvim -R % +" . shellescape(line(".")) . ' "+set nonumber" "+set foldcolumn=0" "+set tabline=" "+set norelativenumber" "+set noruler" "+set laststatus=0" "+set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 3" "+set lines=130" "+set columns=90"'

=== server-name:

execute ":silent !gvim -R % +" . shellescape(line(".")) . ' "+set nonumber" "+set foldcolumn=0" "+set tabline=" "+set norelativenumber" "+set noruler" "+set laststatus=0" "+set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 3" "+set lines=130" "+set columns=90" --servername vim-external-minimap'

