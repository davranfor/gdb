#include <stdio.h>

// Do not allow sprintf
#pragma GCC poison sprintf

int main(void)
{
    char str[256];

    sprintf(str, "Hello");
    return 0;
}
