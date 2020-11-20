/*************************
Analize core dump with gdb
--------------------------
ulimit -c unlimited
gcc -g -o demo core_dump.c
./demo
gdb demo core
(gdb) where
(gdb) bt full
*************************/

#include <stdio.h>

int main(void)
{
    char str[] = "Hello";

    str[100000] = 0;
    puts(str);
    return 0;
}

