#include <stdio.h>
#include <stdlib.h>
           int provol2c(int A, int B) {

	if (A) {
		B = A;
	A = 0;
	}

	return B;

}

int main(int argc, char *argv[]) {

	printf("Saida -> %d\n", provol2c(atoi(argv[1]), atoi(argv[2])));
	return 0;

}