grep-operator
=================

this plugin is meant to be a wrapper around grep but it does not work yet.
all calls to grep will start up a cmd window which hangs.

status
---------
placed in a separate bundle folder and disabled

possible? _vimrc hooks
------------
" By default, use magic for Regular Expressions
nnoremap / /\v
" Search (grep)  for the word under the cursor
":nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " %"<cr>:copen<cr>
