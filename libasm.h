# pragma once

# include "colors.h"
# include <unistd.h>
# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <fcntl.h>
# include <errno.h>

// * Mandatory part

int		ft_strcmp(const char *s1, const char *s2);
size_t	ft_strlen(const char *str);
char*	ft_strcpy(char *dest, const char *src);
ssize_t	ft_write(int fd, const void *buf, size_t count);
int		ft_strcmp(const char *s1, const char *s2);
ssize_t	ft_read(int fd, void *buf, size_t count);
char*	ft_strdup(const char *s);

// * Bonus part

typedef struct s_list
{
	void			*data;
	struct t_list	*next;
}	t_list;
	

int		ft_atoi_base(char *str, char *base);
void	ft_list_push_front(t_list **begin_list, void *data);