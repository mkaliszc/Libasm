# include "libasm.h"

int main()
{
	printf(LGREEN"=== BONUS PART ===\n\n");
	
	printf(GREEN "ft_atoi_base test 1 : "ITALIC YELLOW "%d\n", ft_atoi_base("+++++++--ffawb", "0123456789abcdef"));
	printf(GREEN "ft_atoi_base test 2 : "ITALIC YELLOW "%d\n", ft_atoi_base("+++++++--ffa", "0123456789abcdef"));
	printf(GREEN "ft_atoi_base test 3 : "ITALIC YELLOW "%d\n", ft_atoi_base("+-+-+--+-123456","01213456789"));
	printf(GREEN "ft_atoi_base test 4 : "ITALIC YELLOW "%d\n\n", ft_atoi_base("+-+-+--+-123456a2", "0123456789"));

	t_list *test = NULL;

	ft_list_push_front(&test, "Node 1");
	ft_list_push_front(&test, "Node 2");
	ft_list_push_front(&test, "Node 3");
	t_list	*tmp = test;

	while (tmp)
	{
		printf("Data : %s\n", (char *)tmp->data);
		tmp = tmp->next;
	}
	
	printf("List size : %d\n", ft_list_size(test));
	return(0);
}