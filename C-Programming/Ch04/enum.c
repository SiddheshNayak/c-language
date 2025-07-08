#include <stdio.h>

typedef enum {
    SUN,
    MON,
    TUES,
    WED,
    THUS,
    FRI,
}weekday_t;

int main()
{
    weekday_t wd;
    wd = SUN;
    printf("weekDay : %d\n", wd);

    return 0;
}