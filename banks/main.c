#include <stdio.h>
#include <stdlib.h>

#define N 200000

int main(void) {
	int n, d, money, i;
	int nowmoney = 0, prevoffset = 0;
	int b1 = -1, b2 = -1;
	int * index, * bestindex, * bestmoney;

	scanf("%d %d", &n, &d);
	index = (int *) malloc(N * sizeof(int));
	bestindex = (int *) malloc(N * sizeof(int));
	bestmoney = (int *) malloc(N * sizeof(int));

	for (i = 0; i < n; ++i) {
		scanf("%d %d", index + i, &money);
		if ((i == 0) || (money > bestmoney[i - 1])) {
			bestindex[i] = i;
			bestmoney[i] = money;
		} else {
			bestindex[i] = bestindex[i - 1];
			bestmoney[i] = bestmoney[i - 1];
		}
		while ((i != prevoffset) && (index[i] >= index[prevoffset + 1] + d))
			++prevoffset;

		if ((bestmoney[prevoffset] + money > nowmoney) && (index[i] >= index[prevoffset] + d)) {
			b1 = bestindex[prevoffset] + 1;
			b2 = i + 1;
			nowmoney = bestmoney[prevoffset] + money;
		}
		
	}
	free(index);
	free(bestindex);
	free(bestmoney);
	
	printf("%d %d\n", b1, b2);
	return 0;
}
