proc printf(formatstr: cstring) {.header: "<stdio.h>", varargs.}
var x = 3
printf("%d", x)
