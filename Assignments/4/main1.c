#include<stdio.h>
#include "header.h"
#include <stdlib.h>
#include <string.h>

int main ( int argc, char* argv[])
{
	char *file = argv[1];
	FILE *fs;
	fs = fopen(file,"r");
	double a[2];
	char op;
	char buff[32];
	char string[100];
while(fgets(string, 100, fs))
{		int i =0;
	    int j=0;
	    int k =0 ;
		while(string[i]!='\n')
		{
			if(string[i]!=' '||string[i]!='\n')
				{
					buff[k] = string[i];
					k++;
					i++;
				}
			if(string[i]==' '||string[i]=='\n')
			{
				a[j] = atof(buff);
				j++;
				memset(buff,0,strlen(buff));
				k=0;
				if(j==1)
				{op = string[i+1];
					//printf("%c\n",op );
			    i=i+3;}
			}

	 	}

	 if(op=='+')
	 {
	 	printf("%lf\n",add(a[0],a[1]));
	 }
	 if(op=='-')
	 {
	 	printf("%lf\n",sub(a[0],a[1]));
	 }

	 if(op=='*')
	  {
	  	printf("%lf\n",mpy(a[0],a[1]));
	  }
	  if(op=='/')
	  {
	  	printf("%lf\n",divide(a[0],a[1]));
	  }
 }
	return 0;
}
