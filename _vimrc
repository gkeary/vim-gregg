set nocompatible

"  here is a link to steve losh's book:
"  https://github.com/sjl/learnvimscriptthehardway
"
" copied from MAX to Toothless 5/21/2016 
"source $VIMRUNTIME/vimrc_example.vim
" for gui  -- let's try this
"source $VIMRUNTIME/gvimrc_example.vim
source $VIMRUNTIME/mswin.vim

" makes the mouse behave like MicroSoft Windows mouse  cf behave xterm 
behave mswin 

execute pathogen#infect()
syntax on
filetype plugin indent on

if !exists(":DiffOrig")
	echoerr 'Hey'
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set diffexpr=MyDiff()


function! MyDiff()
   let opt = '-a --binary horizontal '
   if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
   if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
   let arg1 = v:fname_in
   if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
   let arg2 = v:fname_new
   if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
   let arg3 = v:fname_out
   if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
   if $VIMRUNTIME =~ ' '
     if &sh =~ '\<cmd'
       if empty(&shellxquote)
         let l:shxq_sav = ''
         set shellxquote&
       endif
       let cmd = '"' . $VIMRUNTIME . '\diff"'
     else
       let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
     endif
   else
     let cmd = $VIMRUNTIME . '\diff'
   endif
    echoerr  'cmd=' . cmd . 'opt=' . opt . 'arg1: '. arg1 . 'arg2: ' . arg2 
  " silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
   if exists('l:shxq_sav')
     let &shellxquote=l:shxq_sav
   endif
 endfunction

 " 
 " autocmd entries
 " 

"took this out 10/21/2015 
"autocmd vimenter * NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
"  this one didn't work: autocmd bufenter * if (winnr("$") == 1 && b:NERDTreeType == "primary") | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists ("b:NERDTreeType") && b:NERDTreeType == "primary") |q | endif
"
"  comment <this-line> stuff
"
:autocmd FileType CSHARP nnoremap <buffer> <localleader>c 0I//<esc>
:autocmd FileType BASIC nnoremap <buffer> <localleader>c I'<esc>
:autocmd FileType vim     nnoremap <buffer> <localleader>c I"<esc>


syntax enable
set background=dark
colorscheme solarized
:set guifont=Lucida_Console:h16:cDEFAULT
:set relativenumber numberwidth=3 

let mapleader = ","
"  \ must be escaped
let maplocalleader = ","

"  mappings mappings

nnoremap <leader>n :NERDTreeToggle<CR> 
nnoremap <leader>e :vsplit $MYVIMRC<cr>
nnoremap <leader>s :source $MYVIMRC<cr>

" surround current word with double-quotes
nnoremap <leader>' viw<esc>a"<esc>hbi"<esc>lel

"here is a "word"
"
"	echo '>^.^>'
"
" Abbreviations Abbreviations
:iabbrev @@    gregg@gkeary.com
:iabbrev ccopy Copyright 2016 Gregg Keary, all rights reserved.
:iabbrev ssig --- <cr>Gregg Keary<cr>gregg@gkeary.com


" to upper a word do viwU
" to lower a word do viwu
" take this out: inoremap <c-u> <esc>viwU
" 
" mapping jj to <esc> is not a good idea because I must use <esc> in the shell
" i.e. SET -o vi 
"inoremap jj <esc> 
"inoremap <esc> <nop>
"Convert all the mappings you added to your ~/.vimrc file in the previous chapters to be prefixed with <leader> so they don't shadow existing commands.
"Remember: the best way to learn to use these new snippets is to disable the old way of doing things. Running :iabbrev <buffer> return NOPENOPENOPE will force you to use your abbreviation instead. Add these "training" snippets to match all the ones you created to save time.
":iabbrev <buffer> return NOPENOPENOPE 

" Status Line Status line 
:set statusline=%.20f         " Path to the file
:set statusline+=\ -\      " Separator
:set statusline+=FileType: " Label
:set statusline+=%y        " Filetype of the file
:set statusline+=%=        " Switch to the right side
:set statusline+=%-5l        " Current line
:set statusline+=/         " Separator
:set statusline+=%-7L        " Total lines
