//#include "stdafx.h"
#include <stdio.h>
#include <cuda.h>
#include <cutil.h>
#include <unistd.h>
#include <stdbool.h>




main (int argc, char **argv) {
	//variables
	bool demoMode = 0;
	//take in user inputs   
	char text[70];
	if(demoMode)
	char *password = getpass("Password: ");
	else
	{
		fputs("Please Enter Your Password: ", stdout);
		fflush(stdout); /* http://c-faq.com/stdio/fflush.html */
		fgets(text, sizeof text, stdin);
		printf("text = \"%s\"\n", text);
	}
	
	
	return 0;
	
}