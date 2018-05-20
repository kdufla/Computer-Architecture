#include "stdio.h"

int main(int argc, char const *argv[])
{

	int n = 10, max, global_max = 0;
	int a[10] = {6, 1, 5, 3, 7, 5, 3, 6, 8, 4};
	int b[10] = {1};

	for (int i = 1; i < n; i++)
	{
		max = 0;
		for (int j = 0; j < i; j++)
		{
			if (a[j] < a[i])
			{
				if (max < b[j])
				{
					max = b[j];
				}
			}
		}
		b[i] = max + 1;
		if (global_max < max + 1)
		{
			global_max = max + 1;
		}
	}

	for (size_t i = 0; i < n; i++)
	{
		printf("%d ", b[i]);
	}
	printf("\n%d\n", global_max);

	return 0;
}
