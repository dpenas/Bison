#include <stdio.h>
#include <stdlib.h>

FILE* out;
FILE* in;
void main (int argc, char* argv[]){
	int i = 0;
	char line[100][100];
	if (argc < 2){
		printf("You need to specify an input file\n");
		exit(EXIT_FAILURE);
	}
	if ((in = fopen(argv[1], "r")) == NULL){
		printf("The file does not exist\n");
		exit(EXIT_FAILURE);
	}
	
	while(fgets(line[i], 200, in) != NULL){
		printf("Line: %s", line[i]);
		i++;
	}
	fclose(in);
}
