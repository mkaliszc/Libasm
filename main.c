# include "libasm.h"

int main(void)
{
	const char test_string[] = "test1";
	const char cmp_string[] = "test1";
	char copy_str[6];
	char ft_strcpy_str[6];
	char read_buf[20];

	printf(LGREEN"\n=== TESTS NORMAUX ===\n");
	printf("Original string : %s, %p\n\n", test_string, test_string);

	size_t len = ft_strlen(test_string);
	printf(GREEN "ft_strlen : " ITALIC YELLOW "%ld\n", len);
	printf(GREEN "strlen : " ITALIC YELLOW "%ld" RESET "\n\n", strlen(test_string));

	ft_write(1, "This test was written by ft_write\n\n", 36);

	ft_strcpy(ft_strcpy_str, test_string);
	strcpy(copy_str, test_string);

	printf(GREEN "ft_strcpy string : " ITALIC YELLOW "%s\n", ft_strcpy_str);
	printf(GREEN "strcpy string : " ITALIC YELLOW "%s\n\n", copy_str);

	printf(GREEN "ft_strcmp : " ITALIC YELLOW "%d\n", ft_strcmp(test_string, cmp_string));
	printf(GREEN "strcmp : " ITALIC YELLOW "%d\n\n", strcmp(test_string, cmp_string));

	int fd = open("test.txt", O_RDONLY);
	if (fd != -1) {
		int bytes_read = ft_read(fd, read_buf, 7);
		printf(GREEN "str read by ft_read : " ITALIC YELLOW "%s " GREEN "and number of bytes read " ITALIC YELLOW "%d\n", read_buf, bytes_read);

		bytes_read = read(fd, read_buf, 5);
		read_buf[bytes_read] = '\0';
		printf(GREEN "str read by read after ft_read: " ITALIC YELLOW "%s " GREEN "and number of bytes read " ITALIC YELLOW "%d\n\n", read_buf, bytes_read);
		close(fd);
	}

	char *dup_str;

	dup_str = ft_strdup(test_string);
	printf(GREEN "ft_strdup string %p : " ITALIC YELLOW "%s\n", dup_str, dup_str);

	char *dup_str_real = strdup(test_string);
	printf(GREEN "strdup string %p : " ITALIC YELLOW "%s\n\n", dup_str_real, dup_str_real);
	free(dup_str);
	free(dup_str_real);

	printf(GREEN "ft_atoi_base test 1 : "ITALIC YELLOW "%d\n\n", ft_atoi_base("+++++++--ffawb", "0123456789abcdef"));
	printf(GREEN "ft_atoi_base test 2 : "ITALIC YELLOW "%d\n\n", ft_atoi_base("+++++++--ffa", "0123456789abcdef"));
	printf(GREEN "ft_atoi_base test 3 : "ITALIC YELLOW "%d\n\n", ft_atoi_base("+-+-+--+-123456","01213456789"));
	printf(GREEN "ft_atoi_base test 4 : "ITALIC YELLOW "%d\n\n", ft_atoi_base("+-+-+--+-123456a2", "0123456789"));

	printf(LRED "=== TESTS D'ERREUR ===" RESET "\n\n");

	printf(RED "Test 1: ft_write avec fd invalide (-1)" RESET "\n");
	errno = 0;
	ssize_t result = ft_write(-1, "test", 4);
	printf("ft_write result: %zd, errno: %d (%s)\n", result, errno, strerror(errno));
	
	errno = 0;
	ssize_t std_result = write(-1, "test", 4);
	printf("write result: %zd, errno: %d (%s)\n\n", std_result, errno, strerror(errno));

	printf(RED "Test 2: ft_read avec fd invalide (-1)" RESET "\n");
	errno = 0;
	result = ft_read(-1, read_buf, 10);
	printf("ft_read result: %zd, errno: %d (%s)\n", result, errno, strerror(errno));
	
	errno = 0;
	std_result = read(-1, read_buf, 10);
	printf("read result: %zd, errno: %d (%s)\n\n", std_result, errno, strerror(errno));

	printf(RED "Test 3: ft_write sur un fichier en lecture seule" RESET "\n");
	int readonly_fd = open("read_test.txt", O_RDONLY);
	if (readonly_fd != -1) {
		errno = 0;
		result = ft_write(readonly_fd, "test", 4);
		printf("ft_write result: %zd, errno: %d (%s)\n", result, errno, strerror(errno));
		
		errno = 0;
		std_result = write(readonly_fd, "test", 4);
		printf("write result: %zd, errno: %d (%s)\n", std_result, errno, strerror(errno));
		close(readonly_fd);
	}

	printf("\n" RED "Test 4: ft_read sur un fichier fermé" RESET "\n");
	int closed_fd = open("test.txt", O_RDONLY);
	if (closed_fd != -1) {
		close(closed_fd);
		
		errno = 0;
		result = ft_read(closed_fd, read_buf, 10);
		printf("ft_read result: %zd, errno: %d (%s)\n", result, errno, strerror(errno));
		
		errno = 0;
		std_result = read(closed_fd, read_buf, 10);
		printf("read result: %zd, errno: %d (%s)\n", std_result, errno, strerror(errno));
	}

	return 0;
}