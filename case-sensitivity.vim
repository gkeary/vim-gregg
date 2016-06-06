: set ignorecase 
:if "foo" == "FOO"
:    echom "no, it couldn't be" 

:elseif "foo" == "foo" 
:    echom "this must be the one"
endif 
" the behavior of == depends on a user's settings
