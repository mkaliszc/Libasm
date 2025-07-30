#include "libasm.h"

int main(void)
{
    const char test_string[] = "test1";
    char result_char = '0';
    const char newline = '\n';
    char copy_str[20] = {0};
    
    write(1, test_string, 5);
    write(1, &newline, 1);

    size_t len = ft_strlen(test_string);
    result_char = len + '0';
    write(1, &result_char, 1);
    write(1, &newline, 1);

    ft_strcpy(copy_str, test_string);
    ft_write(1, copy_str, 5);
    write(1, &newline, 1);
    
    return 0;
}