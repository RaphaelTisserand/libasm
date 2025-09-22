#include <unistd.h>
#include <stdio.h>
#include <string.h>

extern size_t	ft_strlen(char* str);

int	main(int ac, char** av) {
	char*	str = "merci snaji pour les travaux\n";

	printf("strlen: %d; ft_strlen: %d\n", strlen(str), ft_strlen(str));

	return 0;
}
