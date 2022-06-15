#include<stdlib.h>
#include<stdio.h>
int main(int argv, char **argc){

	int n = atoi(argc[1]);
	int size = 1;

	for (int i=0; i<n;i++){
		size = size*atoi(argc[2+i]);
	}

	FILE *orig = fopen(argc[2+n],"rb");
	FILE *decomp =fopen( argc[3+n], "rb");
	FILE *error = fopen(argc[4+n],"wb");

	float *orig_data = malloc(size*sizeof(float));
	float *decomp_data = malloc(size*sizeof(float));
	float *error_data  = malloc(size*sizeof(float));

	fread(orig_data, sizeof(float), size, orig);
	fread(decomp_data, sizeof(float), size, decomp);

	for (int i =0; i<size; i++){
		error_data[i]=orig_data[i]-decomp_data[i];
	}

	fwrite(error_data, sizeof(float), size, error);
	fclose(decomp);
	fclose(error);
	fclose(orig);
	free(orig_data);
	free(decomp_data);
	free(error_data);
	return 0;
}






