//Author: Felix Omwansa

/* fgets example */
// reading text from a file, converting it to hexadecimal ASCII equivalent, then printing output.
#include <stdio.h>
#include <string.h>
int main() {
   FILE * pFile;
   char testWord[10]; //strings will be stored in these arrays
   char defaultIndexes[2]= {'0', 'x'};
	
	int i, j, k,l, m, n, len, len2; //looping operators

   pFile = fopen ("myfile.txt" , "r");
   if (pFile == NULL) perror ("Error opening file");
   else {
     if ( fgets (testWord , 100 , pFile) != NULL )
       puts (testWord); //file data stored in testWord

     	//conversion to hex
	len = strlen(testWord);
	char mystring[100];
	len2= strlen(mystring);
	char hexOut[100][4];

	if (testWord[len-1]=='\n')
		testWord[--len] = '\0';

		for(i=0; i<len; i++){
	//initialise msystring array	
	sprintf(mystring+i*2 , "%02X", testWord[i]);

		}
		//print output	
		printf("Raw hex data of ' %s ' is: \t %s \n", testWord, mystring);
		
		//store output in multidimensional array
			for(k=0; k<len2; k++){	
			hexOut[k][0]=defaultIndexes[0];
			hexOut[k][1]=defaultIndexes[1];
			
			hexOut[k][2]=mystring[k];
			hexOut[k][3]=mystring[k+1];
						
			}
		//output each array element's value
		for (m=0; m<len2; m++) {
		     for (n=0; n<4; n++){
			 printf("Multidimensional array output of hexOut at [%d][%d] = %d\n", m,n, hexOut[m][n] );
		      }

	fclose (pFile);
	}
		
	}
 return 0;
}

//end
