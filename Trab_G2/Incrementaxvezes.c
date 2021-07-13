#include <stdio.h>
#include <stdlib.h>
          int provol2c(int A, int B) {

	for (int i=0; i<B; i++) {
		A++;
	}

	return A;

}

int main(int argc, char *argv[]) {

	printf("Saida -> %d\n", provol2c(atoi(argv[1]), atoi(argv[2])));
	return 0;

}