#include <stdio.h>
#include <math.h>

#define PI 3.14159265

int main ()
{
	//FILE *frIn = fopen("valor.txt", "r");
	FILE *frOut = fopen("sineresult.txt","w"); 
	if(	frOut!=NULL 
		//&&
		 //frIn!=NULL
		){
		double param = PI / 45 , result;
		//leer*****************************************************************
		//fscanf(frIn, "%lf", &param);
		result = sin (param);
		result=result*result;
		//escribir*************************************************************
		fprintf(frOut, "%lf", result);
		//cerrar***************************************************************
		//close(frIn);
		close(frOut);
		return 0;
	}else return 1;
}
