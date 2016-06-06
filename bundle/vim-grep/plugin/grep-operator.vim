nnoremap <leader>g :set operatorfunc=GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call GrepOperator(visualmode())<cr>
nnoremap <leader>f :set operatorfunc=Show<cr>g@
vnoremap <leader>f :<c-u>call Show(visualmode())<cr>

function! Show(type)
	echom a:type
	if a:type ==# 'v'
		echom a:type
	elseif a:type ==# 'V'
		echom a:type
	elseif a:type ==# 'char'
		echom a:type
	else
		echom "OTHERWISE"
	endif
endfunction
function! GrepOperator(type)
	if a:type ==# 'v'
		execute "normal! `<v`y"
	elseif a:type ==# 'char'
		execute "normal! `[v`]y"
	else
		return
	endif
	echom shellescape(@@)

	silent execute "grep! -R " . shellescape(@@) . "." 
	copen
	"echom shellescape(@@)
endfunction
function! XGrepOperator(type)
    if a:type ==# 'v'
        execute "normal! `<v`>y"
    elseif a:type ==# 'char'
        execute "normal! `[v`]y"
    else
        return
    endif

    echom @@
endfunction
"Because we've defined a brand new Vim operator we can use it in a lot of different ways, such as:

"viw<leader>g: Visually select a word, then grep for it.
"<leader>g4w: Grep for the next four words.
"<leader>gt;: Grep until semicolon.
"<leader>gi[: Grep inside square brackets.
