#include "stdio.h"

int main(int argc, char const *argv[])
{
	int a[9] = {2, 5, 3, 7, 11, 8, 10, 13, 6}, b[9], n = 9, l = 1, i, ll, r, m;

	b[0] = a[0];

	for (i = 1; i < n; i++)
	{
		if (a[i] < b[0])
		{
			b[0] = a[i];
		}
		else if (a[i] > b[l - 1])
		{
			b[l] = a[i];
			l++;
		}
		else
		{
			ll = -1;
			r = l - 1;

			while (r - ll > 1)
			{
				m = ll + (r - ll) / 2;

				if (a[m] >= a[i])
					r = m;
				else
					ll = m;
			}

			b[r] = a[i];
		}
	}

	printf("%d\n", l);

	return 0;
}
