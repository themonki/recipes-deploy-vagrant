#include <stdio.h>
#include <math.h>

#define PI 3.14159265

int main ()
{
	FILE *frIn = fopen("valor.txt", "r");
	FILE *frOut = fopen("cosineresult.txt","w"); 
	if(	frOut!=NULL 
		&&
		 frIn!=NULL
		){
		double param, result;
		//leer*****************************************************************
		fscanf(frIn, "%lf", &param);
		result = cos (param);
		result=result*result;
		//escribir*************************************************************
		fprintf(frOut, "%lf", result);
		//cerrar***************************************************************
		close(frIn);
		close(frOut);
		return 0;
	}else return 1;
}
