
Autocommand Structure
---------------------

Let's take a closer look at the autocommand we just created:

    :::text
    :autocmd BufNewFile * :write
             ^          ^ ^
             |          | |
             |          | The command to run.
             |          |
             |          A "pattern" to filter the event.
             |
             The "event" to watch for.

Here is some text from gregg
Did :::text  call it out as code.  
No I don't think so  it has to be indented with at least 2 tabs
