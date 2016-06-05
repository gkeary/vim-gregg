"  this file is currently a scratchpad
"    for Hard way chapter about
"    Functional Programming
"
"
"    note: functional programming is
"    a. passing functions around as data
"    b. using immuable data structures
"

" Immutable Data Structures {{{
"
function! Sorted(l)
    let new_list = deepcopy(a:l)
    call sort(new_list)
    return new_list
endfunction
"Source and write the file, then run :echo Sorted([3, 2, 4, 1]) to try it out. Vim echoes [1, 2, 3, 4].
function! Reversed(l)
    let new_list = deepcopy(a:l)
    call reverse(new_list)
    return new_list
endfunction

function! Append(l, val)
    let new_list = deepcopy(a:l)
    call add(new_list, a:val)
    return new_list
endfunction

function! Assoc(l, i, val)
    let new_list = deepcopy(a:l)
    let new_list[a:i] = a:val
    return new_list
endfunction

function! Pop(l, i)
    let new_list = deepcopy(a:l)
    call remove(new_list, a:i)
    return new_list
endfunction
"}}}
" Higher Order Funtions {{{
"    i.e.  Functions that take other functions and do something with them.
"
"We'll begin with the trusty map function. Add this to your file:

function! Mapped(fn, l)
    let new_list = deepcopy(a:l)
    call map(new_list, string(a:fn) . '(v:val)')
    return new_list
endfunction
"  example {{{
"
":let mylist = [[1, 2], [3, 4]] :
"":echo Mapped(function("Reversed"), mylist)
"
" }}}
function! Filtered(fn, l)
    let new_list = deepcopy(a:l)
    call filter(new_list, string(a:fn) . '(v:val)')
    return new_list
endfunction
" example 2 {{{
" Try Filtered() out with the following commands:
"
" :let mylist = [[1, 2], [], ['foo'], []]
" :echo Filtered(function('len'), mylist)
"Vim displays [[1, 2], ['foo']].
" 
" }}} 
function! Removed(fn, l)
    let new_list = deepcopy(a:l)
    call filter(new_list, '!' . string(a:fn) . '(v:val)')
    return new_list
endfunction
" example 3 {{{
" Try Removed with the following commands:
"
" :let mylist = [[1, 2], [], ['foo'], []]
" :echo Removed(function('len'), mylist)
"Vim displays [[], []].
" 
" }}} 
"}}}
