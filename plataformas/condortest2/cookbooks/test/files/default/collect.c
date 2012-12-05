#include <stdio.h>
#include <math.h>

#define PI 3.14159265

int main ()
{
	FILE *frInCos = fopen("cosineresult.txt", "r");
	FILE *frInSin = fopen("sineresult.txt","r"); 
	if(	frInCos!=NULL 
		&&
		 frInSin!=NULL
		){
		double paramCos ,paramSin, result;
		//leer*****************************************************************
		fscanf(frInCos, "%lf", &paramCos);
		fscanf(frInSin, "%lf", &paramSin);
		result = paramCos + paramSin;
		//imprimir*************************************************************
		printf("%lf\n", result);
		//cerrar***************************************************************
		close(frInCos);
		close(frInSin);
		return 0;
	}else return 1;
}
