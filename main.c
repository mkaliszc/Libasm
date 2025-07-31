# include "libasm.h"

int main(void)
{
	const char test_string[] = "test1";
	const char cmp_string[] = "test1";
	char copy_str[6];
	char ft_strcpy_str[6];
	char read_buf[20];

	printf(LGREEN"\n=== TESTS NORMAUX ===\n");
	printf("Original string : %s\n\n", test_string);

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

	printf(LRED "=== TESTS D'ERREUR ===" RESET "\n\n");

	// Test 1: ft_write avec un file descriptor invalide
	printf(RED "Test 1: ft_write avec fd invalide (-1)" RESET "\n");
	errno = 0; // Reset errno
	ssize_t result = ft_write(-1, "test", 4);
	printf("ft_write result: %zd, errno: %d (%s)\n", result, errno, strerror(errno));
	
	// Comparaison avec write standard
	errno = 0;
	ssize_t std_result = write(-1, "test", 4);
	printf("write result: %zd, errno: %d (%s)\n\n", std_result, errno, strerror(errno));

	// Test 2: ft_read avec un file descriptor invalide
	printf(RED "Test 2: ft_read avec fd invalide (-1)" RESET "\n");
	errno = 0;
	result = ft_read(-1, read_buf, 10);
	printf("ft_read result: %zd, errno: %d (%s)\n", result, errno, strerror(errno));
	
	// Comparaison avec read standard
	errno = 0;
	std_result = read(-1, read_buf, 10);
	printf("read result: %zd, errno: %d (%s)\n\n", std_result, errno, strerror(errno));

	// Test 3: ft_write sur un fichier en lecture seule
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

	// Test 4: ft_read sur un fichier fermé
	printf("\n" RED "Test 4: ft_read sur un fichier fermé" RESET "\n");
	int closed_fd = open("test.txt", O_RDONLY);
	if (closed_fd != -1) {
		close(closed_fd); // Fermer le fichier
		
		errno = 0;
		result = ft_read(closed_fd, read_buf, 10);
		printf("ft_read result: %zd, errno: %d (%s)\n", result, errno, strerror(errno));
		
		errno = 0;
		std_result = read(closed_fd, read_buf, 10);
		printf("read result: %zd, errno: %d (%s)\n", std_result, errno, strerror(errno));
	}

	return 0;
}