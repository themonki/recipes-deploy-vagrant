#include <stdio.h>
#include <math.h>

#define PI 3.14159265

int main ()
{
	//FILE *frIn = fopen("valor.txt", "r");
	FILE *frOut = fopen("valor.txt","w"); 
	if(	frOut!=NULL 
		//&&
		 //frIn!=NULL
		){
		double degree = PI / 45;
		//leer*****************************************************************
		//fscanf(frIn, "%lf", &param);
		//escribir*************************************************************
		fprintf(frOut, "%lf", degree);
		//cerrar***************************************************************
		//close(frIn);
		close(frOut);
		return 0;
	}else return 1;
}
