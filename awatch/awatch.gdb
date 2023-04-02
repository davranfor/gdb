# awatch
# Set a watchpoint that will break when expr is either read from or written into by the program.

set pagination off

set logging file awatch.log
set logging overwrite on
set logging redirect on
set logging enabled on

break main
run

# You can also watch a pointer using "awatch *var"
awatch var
commands
continue
end

continue
quit

