#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 program source_dir"
    exit 1
fi

# Overwrite the contents of trace.gdb
printf "# $(date)\n# $0 $1 $2\n\n" > trace.gdb

# Do not attempt to query debuginfod servers
# echo "set debuginfod enabled off" > ~/.gdbinit

# Don't stop each time there is a pagination
echo "set pagination off" >> trace.gdb

# Set the log file
echo "set logging file trace.log" >> trace.gdb
# Overwrite the contents of the file
echo "set logging overwrite on" >> trace.gdb
# Write only to the log file (not to stdout)
echo "set logging redirect on" >> trace.gdb

# For each .c file create a backtrace for each function called
for i in $2/*.c; do
    [ -f "$i" ] || break
    echo "rbreak $i:." >> trace.gdb
    echo "command" >> trace.gdb
    echo "silent" >> trace.gdb
    echo "backtrace 1" >> trace.gdb
    echo "continue" >> trace.gdb
    echo "end" >> trace.gdb
done

echo "echo \nDebugging ...\n\n" >> trace.gdb

# Show the current values of the logging settings
#echo "show logging" >> trace.gdb

# Enable logging
echo "set logging enabled on" >> trace.gdb

# Run the debugger
echo "run" >> trace.gdb

# Exit the debugger
echo "quit" >> trace.gdb

gdb --quiet --command=trace.gdb $1

