#include <stdio.h>

static void func(int *var)
{
    printf("%d\n", *var);
}

int main(void)
{
    int var = 42;

    func(&var);
    for (int i = 0; i < 5; i++)
    {
        var++;
    }
    printf("%d\n", var);
    return 0;
}
