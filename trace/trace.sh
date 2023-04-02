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

# Don't print the arguments of the functions
# echo "set print frame-arguments presence" >> trace.gdb

# For each .c file create a backtrace for all functions
find $2 -maxdepth 1 -type f -name '*.c' -print0 | while read -d $'\0' file
do
    echo "rbreak $file:." >> trace.gdb
    echo "command" >> trace.gdb
    echo "silent" >> trace.gdb
    echo "backtrace 1" >> trace.gdb
    echo "continue" >> trace.gdb
    echo "end" >> trace.gdb
done

echo "echo \nDebugging ...\n\n" >> trace.gdb

# Show the current values of the logging settings
# Wecho "show logging" >> trace.gdb

# Enable logging
echo "set logging enabled on" >> trace.gdb

# Run the debugger
echo "run" >> trace.gdb

# Exit the debugger
echo "quit" >> trace.gdb

gdb --quiet --command=trace.gdb $1

