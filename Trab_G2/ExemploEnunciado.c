#include <stdio.h>
#include <stdlib.h>
           int provol2c(int X, int Y) {

	Z = Y;
	while (X) {
		Z++;
	}

	return Z;

}

int main(int argc, char *argv[]) {

	printf("Saida -> %d\n", provol2c(atoi(argv[1]), atoi(argv[2])));
	return 0;

}