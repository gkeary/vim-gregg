mapping with the dot
--------------------
:nnoremap <leader>g :grep -R something .<cr>
If you've read :help grep this should be pretty easy to understand. We've looked at lots of mappings before, and there's nothing new here.

something something

something somthing something
something somthing something
something somthing something
something somthing something

Obviously we're not done yet, so let's refine this mapping until it meets our simplified goal.

The Search Term
First we need to search for the word under the cursor, not the string something. Run the following command:
adding a search term
---------------------
:nnoremap <leader>g :grep -R <cword> .<cr>
Now try it out. <cword> is a special bit of text you can use in Vim's command-line mode, and Vim will replace it with "the word under the cursor" before running the command.

You can use <cWORD> to get a WORD instead of a word. Run this command:

using <cWORD>
----------------
:nnoremap <leader>g :grep -R <cWORD> .<cr>
Now try the mapping when your cursor is over something like foo-bar. Vim will grep for foo-bar instead of just part of the word.

operator-pending mappings
==========================

The original vi did not have separate mappings for
Normal/Visual/Operator-pending mode and for Insert/Command-line mode.
Therefore the ":map" and":map!" commands enter and display mappings for
several modes.  In Vim you can use the ":nmap", ":vmap", ":omap", "cmap" and
":imap" commands to enter mappings for each mode separately.


text for testing onoremap
----------------------------
return person.get_pets(type="cat", fluffy_only=True)
return person.get_pets(type="cat", fluffy_only=True)
return person.get_pets(type="cat", fluffy_only=True)
return person.get_pets()

map1
------------
onoremap p i(
type dp

using :copen
--------------

