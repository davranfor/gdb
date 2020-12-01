#!/bin/bash

# Compile
gcc -Wall -pedantic -g -o demo demo.c

# Exit on compile error
if [ $? -ne 0 ]; then
    exit
fi

# Run the script
gdb -quiet -command=awatch.gdb demo

echo "output redirected to awatch.log"

