# awatch
# Set a watchpoint that will break when expr is either read from or written into by the program.

set pagination off
# redirect the ouptut to a file
set logging file awatch.log
set logging overwrite on
set logging off
set logging redirect on
set logging on
# end redirect
break main
run
# You can also watch a pointer using "awatch *var"
awatch var
commands
continue
end
continue
quit

