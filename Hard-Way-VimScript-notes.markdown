Learn VimScript The Hard Way
============================

http://learnvimscriptthehardway.stevelosh.com/

A few quick notes about things that I read in the book.


Github  Book Source 
-------

+ : here is the link
+ : https://github.com/sjl/learnvimscriptthehardway
+ :link  
- sjl https://github.com/sjl/learnvimscriptthehardway
- 

Echoing
-------

+ :ec[ho], prints a message (to the status line?) 
+ :echom[sg], prints a message to the status line, and the message-history
+ :messages, shows messages from :echom
+ :rgk, shows my name as Gregg Keary
+ :bullet added?
+ 

These commands are good for debugging** by gregg keary**

Comments 
--------

One can add comments using a double quote :)

Options
-------

There are boolean options, e.g.

+ :set number and conversely :set nonumber
+ This behavior is apparently common to all boolean options 
+ :set nu[mber]! will toggle the value
+ :set nu[mber]? will report the value => "number" or "nonumber"

And those that take values, e.g.

+ set numberwidth=10 
+ set numberwidth? will report the value

And as an added bonus, you can even specify multiple values at once!

A little aside, :set relativenumber is fairly cool. 

Mapping
-------

Mapping lets you tell Vim: When I press this key, don'' do that; do this.

###Normal Mode Mapping

+ :map - x makes - do what x did
+ It would seem that these mapping will cascade... :D

To handle special characters, one can use <keyname>, e.g.

+ :map <space> viw, space selects a word
+ :map <c-d> dd, ctrl+d deletes a line

When writing these kinds of statements, a comment helps clarify intent.

###Modal Mapping

To use a mapping in each different mode, one can use: 

+ :nmap - for normal mode
+ :vmap - for visual mode 
+ :imap - for insert mode

Note: With imap, it will literally paste in the key combo! 
+ :imap <c-d> dd, will just paste in dd!
+ :imap <c-d> <esc>ddi does what you probably expected

Bonus: :imap <c-u> <esc>vUi, sets <c-u> to set to uppercase.
(Also U in visual mode set the word to uppercase.

###Unmapping

One can unmap, using unmap, and variants of it:

+ nunmap
+ iunmap
+ vunmap

###Recursion

If you do something like:

:nmap dd O<esc>jddk

then it will enter into a recursive cycle for ever. (Which you can end with 
<c-c>)

*And that is why they invented :noremap!*

:noremap, stands for non-recursive map. It just maps to whatever it would map to if there were no mappings before. It also has the typical friends that one might come to expect. :nnoremap, :vnoremap and :inoremap.

*ALWAYS USE NOREMAP*
It just isn''t worth the hassle!

Leaders
-------

Doing these crazy mappings leads to clobbering. Which is why we use the concept
of leaders, a rarely used character that we place at the beginning or our
mapping.

Good news: vim supports leaders! 

+ let mapleader = ","
+ :nnoremap <leader>d dd

Three good reasons to use the leader key:

+ May want to be able to use the leader key later on
+ If someone wants to copy your .vimrc, they can use their own leader
+ Lots of plugins use leaders, +1 for familiarity

###Local Leader

Local leaders take on meaning only for a certain type of file. 

+ :let maplocalleader = "\\"

Note: The value of leader must be declared before the mapping is created!

Editing Yo .vimrc
-----------------

Don''t want to lose context just to edit the .vimrc

+ :nnoremap <leader>ev :vsplit $MYVIMRC<cr>
+ :nnoremap <leader>sv :source $MYVIMRC<cr>

Now you can edit, and source the .vimrc super fast :)

Abbreviations
-------------

These are like mappings, but meant for insert mode. 

+ iabbr[ev] and and

There exists: :set iskeyword?

Abbreviations can of course be used for more things than just spelling
corrections: One example might be sysout to System.out.println();

###Difference Between Mapping and Abbr

Mappings are not context sensitive, abbreviations are, e.g.

+ :abbr bar baz => foobar stays as foobar
+ :inoremap bar baz => foobar becomes foobaz

More Mappings
-------------

If you map something that shadows a multiple key mapping, if you type it
quickly, you will get the new mapping. If you type it slowly, you will get the
original mapping. 

There is a timeout on the command.

###Time For Something A Little Bit Trickier

What does this do?

+ :nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

<!-- " Silly quote -->

WHAT DOES IT DO???

Well, it surrounds the current work with quotes. But what is more important is
how does it work?

Break it down now:

+ viw - visually selects a word
+ <esc> - exits visual mode, leaving the cursor on the last char of the word
+ a - append
+ " - we are in insert mode, so this inserts a quote <!-- " silly quote -->
+ <esc> - go back to normal mode
+ h - move one character left
+ b - move back to start of word
+ i - enter insert mode before current char
+ " - as above :) <!-- " silly quote -->
+ <esc> - go back to normal mode 
+ l - move right, bringing cursor to first char of word 
+ e - move cursor to end of word
+ l - move right again, cursor comes to rest on the end quote

Because we used :nnoremap, this will always do as we expect. However, notice
how difficult to read Vim mappings can get! 

Quick Tip
---------

If you need to jump to the start of the previously selected visual block, use `<
Conversely, to jump to the end, use `>
 
One Way of Speeding Up Editing 
------------------------------

If you map jk to <esc> then you can have a nice fast way of getting back to
normal mode. You can then force yourself to use this new mapping by binding the
old mapping to <nop>

+ :inoremap jk <esc> 
+ :inoremap <esc> <nop>

This binding allows you to keep your fingers on the home row. Now that you are a
perfect touch typist, that is sure to improve your productivity by several
orders of magnitude!

Use this idea to force yourself to use all kinds of new mappings, and speed
yourself up in the long run. :)

Bro you shouldn''t still be using the arrow keys! Especially in insert mode. :p
(I think that it is only sensible to diable the arrow keeys some of the time.)

Buffer Local Options && Mappings
--------------------------------

It is possible, by adding <buffer> to a mapping, to make a mapping apply to only
the current buffer.

It is bad form to use <buffer> and <leader> together. One should instead use
<localleader>. This concept permits namespacing.

Vim will always choose the more specific mapping; That is the one that contains
<buffer> will take priority over the one that does not.

Local Settings
--------------

Using :setlocal, it is possible to apply settings to only one buffer.

Autocommands
------------

Autocommand allow us to tell Vim to do something when something happens.
An example:

+ :autocmd BufNewFile * :write, When a new file is opened, write it to disk.

###What This Does

+ :autocmd basically says listen for this event.
+ * is a pattern. It is used as a filter for the event.
+ And finally, :write is the command to execute when a matching event occurs.

There is a huge range of different types of events, ranging from editing a new
file, switching buffer, not doing anything, changing modes, the list goes on.

+ :autocmd BufNewFile *.txt :write, As above, but only for .txt files.
+ :autocmd BufWritePre *.html :normal gg=G, correctly indent HTML files on save.

Commenting a line:

+ :autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
+ :autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>

And that right there gives meaning to the buffer specific settings! Thanks Vim!

GOTCHA: The one downside is that you cannot use any special characters when
specifying the command to be run.


Variables
------------

let foo = "bar"   
foo is now a variable.  it can be a string or an integer.  it''s value can be seen with "echo &foo"

Options as Variables:  set textwidth= 80 ; echo &textwidth (here textwidth is a vim "OPTION"
Using an ampersand in front of a name tells Vim that you''re referring to the option, not a variable that happens to have the same name.

:let &textwidth = 100
:set textwidth?
Vim will display textwidth=100.

Why would we want to do this when we could just use set? Run the following commands:

:let &textwidth = &textwidth + 10
:set textwidth?
This time Vim displays textwidth=110. When you set an option using set you can only set it to a single literal value. When you use let and set it as a variable you can use the full power of Vimscript to determine the value.


Registers as Variables
-------------------

:let @a="hello!"
register A has that text
so:  "ap will put the register text

Select a word in your file and yank it with y, then run this command:

:echo @"
Vim will echo the word you just yanked. The " register is the "unnamed" register, which is where text you yank without specifying a destination will go.

Perform a search in your file with /someword, then run the following command:

:echo @/
Vim will echo the search pattern you just used. This lets you programmatically read and modify the current search pattern, which can be very useful at times.


Vim Coerces variables
-----------------------------
After observing all of these commands we can draw a few informed conclusions about Vimscript:

Vim will try to coerce variables (and literals) when necessary. When 10 + "20foo" is evaluated Vim will convert "20foo" to an integer (which results in 20) and then add it to 10.
Strings that start with a number are coerced to that number, otherwise they're coerced to 0.
Vim will execute the body of an if statement when its condition evaluates to a non-zero integer, after all coercion takes place.
VIM WILL EXECUTE THE BODY OF AN IF STATEMENT WHEN ITS CONDITION EVALUATES TO A NON-ZERO INTEGER, AFTER ALL COERCION TAKES PLACE.
