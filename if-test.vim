: set ignorecase 
:if "foo" == "FOO"
:    echom "no, it couldn't be" 

:elseif "foo" == "foo" 
:    echom "this must be the one"
endif 
" the behavior of == depends on a user's settings
"
"
" Examples:
"abc" ==# "Abc"	  evaluates to 0
"abc" ==? "Abc"	  evaluates to 1
"abc" == "Abc"	  evaluates to 1 if 'ignorecase' is set, 0
"
"" see "HELP expr4
"  c.f. !=?  and is?  etc.
"
