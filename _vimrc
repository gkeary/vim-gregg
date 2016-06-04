"  zM close-all   zR  Open-all
source $VIMRUNTIME/mswin.vim
" makes the mouse behave like MicroSoft Windows mouse  cf behave xterm 
behave mswin 
execute pathogen#infect()
syntax on
filetype plugin indent on
"  Diff Original (DiffOrig) {{{
if !exists(":DiffOrig")
	"echoerr 'Hey'
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
"}}}
" DiffOrig EXPANDED {{{
  "command DiffOrig 
  "
" :vert new  " new window with vertical split
" :set bt=nofile " buftype has <no file> 
" :r ++edit # " replace everything with contents of previous buffer 
" :0d_ " delete the top line ??? 
" :diffthis " set diffopts for this buffer  <calls MyDiff()>
" :wincmd p " move to the next window (to-the-right) 
" :diffthis " set diffopts for this as the second buffer
" }}}
"NERDTree {{{
"took this out 10/21/2015 
"autocmd vimenter * NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
"  this one didn't work: autocmd bufenter * if (winnr("$") == 1 && b:NERDTreeType == "primary") | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists ("b:NERDTreeType") && b:NERDTreeType == "primary") |q | endif
"

 " "}}}
"  Comment a single line ---------------------------------- {{{
:autocmd FileType CSHARP nnoremap <buffer> <localleader>c 0I//<esc>
:autocmd FileType BASIC nnoremap <buffer> <localleader>c I'<esc>
:autocmd FileType vim     nnoremap <buffer> <localleader>c I"<esc>

"  }}}
" Vimscript file settings ---------------------- {{{
augroup filetype_vim
	autocmd!
	autocmd Filetype vim setlocal foldmethod=marker
	" This will tell Vim to use the marker method of folding
	" for any Vimscript files.
augroup END
" }}}
" Basic Settings  {{{ 
syntax enable
set background=dark
colorscheme solarized
:set guifont=Lucida_Console:h16:cDEFAULT
:set relativenumber numberwidth=3 



" }}}
"  Mappings {{{
let mapleader = ","
"  \ must be escaped
let maplocalleader = ","
nnoremap <leader>n :NERDTreeToggle<CR> 
nnoremap <leader>e :vsplit $MYVIMRC<cr>
nnoremap <leader>s :source $MYVIMRC<cr>
nnoremap <leader>q :call QuickfixToggle()<cr>

" surround current word with double-quotes
nnoremap <leader>' viw<esc>a"<esc>hbi"<esc>lel

"here is a "word"
"
"	echo '>^.^>'
"
"  }}}
" Abbreviations  {{{
:iabbrev @@    gregg@gkeary.com
:iabbrev ccopy Copyright 2016 Gregg Keary, all rights reserved.
:iabbrev ssig --- <cr>Gregg Keary<cr>gregg@gkeary.com
" }}}
" Status Line {{{
:set statusline=%.20f         " Path to the file
:set statusline+=\ -\      " Separator
:set statusline+=FileType: " Label
:set statusline+=%y        " Filetype of the file
:set statusline+=%=        " Switch to the right side
:set statusline+=%-5l        " Current line
:set statusline+=/         " Separator
:set statusline+=%-7L        " Total lines
" }}}
"  Comments Comments {{{
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

" }}}

