#include <stdio.h>
#include <stdlib.h>
                int provol2c(int A, int B, int C) {

	for (int i=0; i<B; i++) {
		A++;
	}
	for (int i=0; i<C; i++) {
		A++;
	}

	return A;

}

int main(int argc, char *argv[]) {

	printf("Saida -> %d\n", provol2c(atoi(argv[1]), atoi(argv[2]), atoi(argv[3])));
	return 0;

}