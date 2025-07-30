# pragma once

#include <unistd.h>

int ft_strcmp(const char *s1, const char *s2);
size_t ft_strlen(const char *str);
char* ft_strcpy(char *dest, const char *src);
ssize_t ft_write(int fd, const void *buf, size_t count);