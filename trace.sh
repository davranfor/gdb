#!/bin/bash

# Overwrite the contents of trace.gdb with a title
echo "# Trace commands" > trace.gdb

# Don't stop each time there is a pagination
echo "set pagination off" >> trace.gdb

# For each .c file create a backtrace for each function called
for i in *.c; do
    [ -f "$i" ] || break
    echo "rbreak $i:." >> trace.gdb
    echo "command" >> trace.gdb
    echo "silent" >> trace.gdb
    echo "backtrace 1" >> trace.gdb
    echo "continue" >> trace.gdb
    echo "end" >> trace.gdb
done

# Set the log file
echo "set logging file trace.log" >> trace.gdb
# Overwrite the contents of the file
echo "set logging overwrite on" >> trace.gdb
# Redirect only to a file (not to stdout)
echo "set logging off" >> trace.gdb
echo "set logging redirect on" >> trace.gdb
echo "set logging on" >> trace.gdb

# Run the debugger
echo "run" >> trace.gdb

# Exit the debugger
echo "quit" >> trace.gdb

gdb -quiet -command=trace.gdb program

