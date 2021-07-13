#include <stdio.h>
#include <stdlib.h>
                                   int provol2c(int A, int B, int C) {

	if (A) {
		if (B) {
		if (C) {
		for (int i=0; i<A; i++) {
		C++;
	}
	for (int i=0; i<B; i++) {
		C++;
	}
	}
	else{
		C = 0;
	}
	}
	else{
		C = 0;
	}
	}
	else{
		C = 0;
	}

	return C;

}

int main(int argc, char *argv[]) {

	printf("Saida -> %d\n", provol2c(atoi(argv[1]), atoi(argv[2]), atoi(argv[3])));
	return 0;

}