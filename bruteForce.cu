//#include "stdafx.h"
#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <cutil.h>
#include <unistd.h>
#include <stdbool.h>
#include <math.h>
#include <stdint.h>

// can represent 78 characters, each var will represent 13 chars
struct passNum{
uint64_t x1;
uint64_t x2;
uint64_t x3;
uint64_t x4;
uint64_t x5;
uint64_t x6;
uint64_t x7;
uint64_t x8;
uint64_t x9;
};

extern void findPass_wrapper(passNum *passPtr, passNum *bruteNumOut, uint64_t *maxNum);
extern __global__ void findPass(passNum *passPtr, passNum *bruteNumOut, uint64_t *max);
extern void stringToNumaz(char *str, passNum *passPtr);
extern void stringToNumazAZ(char *str, passNum *passPtr);
extern void stringToNumazAZ09(char *str, passNum *passPtr);
extern void stringToNumazAZ09sc(char *str, passNum *passPtr);
extern int cudaMalloc();
extern int cudaMemcpy();
extern int cudaFree();
extern void __syncthreads();
extern int cudaMemcpyToSymbol();
__device__ bool isCracked = false;

//wrapper for findPass, allocates memory then passes it to device and calls findPass
extern void findPass_wrapper(passNum *passPtr, passNum *bruteNumOut, uint64_t *maxNum)
{
	passNum *devI1Ptr;
	passNum *dev01Ptr;
	uint64_t *devI2Ptr;
	cudaMalloc((void **)&dev01Ptr, sizeof(passNum));
    cudaMemcpy(dev01Ptr, bruteNumOut, sizeof(passNum), cudaMemcpyHostToDevice);
    cudaMalloc((void **)&devI1Ptr, sizeof(passNum));
    cudaMemcpy(devI1Ptr, passPtr, sizeof(passNum), cudaMemcpyHostToDevice);
    cudaMalloc((void **)&devI2Ptr, sizeof(int));
    cudaMemcpy(devI2Ptr, maxNum, sizeof(uint64_t), cudaMemcpyHostToDevice);
    
    dim3 dimGrid(43, 1);
    dim3 dimBlock(96, 1);
    findPass<<<dimGrid,dimBlock>>>(devI1Ptr, dev01Ptr, devI2Ptr);
    cudaMemcpy(bruteNumOut, dev01Ptr, sizeof(passNum), cudaMemcpyDeviceToHost);
    cudaError_t cudaErr;
    cudaErr = cudaGetLastError();
    printf("%s\n", cudaGetErrorString(cudaErr));
    cudaThreadSynchronize();
    cudaFree(devI1Ptr);
    cudaFree(dev01Ptr);
    cudaFree(devI2Ptr);
    return;
} 

extern __global__ void findPass(passNum *passPtr, passNum *bruteNumOut, uint64_t *max)
{
	//each thread gets its own passNum to increment
	uint64_t maxNum = *max;
	passNum bruteNum = {0,0,0,0,0,0,0,0,333};
	int bx = blockIdx.x;
	int tx = threadIdx.x;
	int tid = tx + 96*bx;
	int stride = 96*43;
	bruteNumOut->x9 = 456;
	
	//bruteNum starts at its tid, then increments by stride
	bruteNum.x1 = tid;
	bruteNum.x2 = tid;
	bruteNum.x3 = tid;
	bruteNum.x4 = tid;
	bruteNum.x5 = tid;
	bruteNum.x6 = tid;
	bruteNum.x7 = tid;
	bruteNum.x8 = tid;
	bruteNum.x9 = tid;
	
	while(!isCracked)
	{
	/*
		if(bruteNum.x8 >= maxNum){
			bruteNum.x9 += stride;
			bruteNum.x8 = maxNum;}
		else if(bruteNum.x7 >= maxNum){
			bruteNum.x8 += stride;
			bruteNum.x7 = maxNum;}
		else if(bruteNum.x6 >= maxNum){
			bruteNum.x7 += stride;
			bruteNum.x6 = maxNum;}
		else if(bruteNum.x5 >= maxNum){
			bruteNum.x6 += stride;
			bruteNum.x5 = maxNum;}
		else if(bruteNum.x4 >= maxNum){
			bruteNum.x5 += stride;
			bruteNum.x4 = maxNum;}
		else if(bruteNum.x3 >= maxNum){
			bruteNum.x4 += stride;
			bruteNum.x3 = maxNum;}
		else if(bruteNum.x2 >= maxNum){
			bruteNum.x3 += stride;
			bruteNum.x2 = maxNum;}
		else if(bruteNum.x1 >= maxNum){
			bruteNum.x2 += stride;
			bruteNum.x1 = maxNum;}
		else
			bruteNum.x1 += stride;
			*/
			
			bruteNum.x1 += stride;
			if(bruteNum.x1 >= 500000)
			{
			*bruteNumOut = bruteNum;
			bruteNumOut->x6 = maxNum;
			isCracked = true;
			}
			//if we have found the password
			if((bruteNum.x1 == passPtr->x1) &&
			(bruteNum.x2 == passPtr->x2) &&
			(bruteNum.x3 == passPtr->x3) &&
			(bruteNum.x4 == passPtr->x4) &&
			(bruteNum.x5 == passPtr->x5) &&
			(bruteNum.x6 == passPtr->x6) &&
			(bruteNum.x7 == passPtr->x7) &&
			(bruteNum.x8 == passPtr->x8) &&
			(bruteNum.x9 == passPtr->x9))
			{
			isCracked = true; //we're done
			*bruteNumOut = bruteNum; //set output to the found password
			}
	}
	
	__syncthreads();
	return;
}


main (int argc, char **argv) {
	//variables
	bool demoMode = 0;
	passNum pass = {0,0,0,0,0,0,0,0,111};//Users entered password
	passNum *passPtr = &pass;
	passNum brute = {0,0,0,0,0,0,0,0,222};//programs cracked password to be found
	passNum *brutePtr = &brute;
	uint64_t *maxNumaz;
	maxNumaz = (uint64_t*)malloc(sizeof(uint64_t));
	*maxNumaz = 2580398988131886080;
	//take in user inputs   
	char text[80];
	if(demoMode)
	char *password = getpass("Password: ");
	else
	{
		fputs("Please Enter Your Password: ", stdout);
		fflush(stdout); /* http://c-faq.com/stdio/fflush.html */
		fgets(text, sizeof text, stdin);
		printf("text = %s \n", text);
	}
	
	char *str = &text[0];
	stringToNumaz(str, passPtr);
	printf("x1 = %llu \n", passPtr->x1);
	printf("x2 = %llu \n", passPtr->x2);
	printf("x3 = %llu \n", passPtr->x3);
	printf("x4 = %llu \n", passPtr->x4);
	printf("x5 = %llu \n", passPtr->x5);
	printf("x6 = %llu \n", passPtr->x6);
	
	findPass_wrapper(passPtr, brutePtr, maxNumaz);
	printf("x1 = %llu \n", brutePtr->x1);
	printf("x2 = %llu \n", brutePtr->x2);
	printf("x3 = %llu \n", brutePtr->x3);
	printf("x4 = %llu \n", brutePtr->x4);
	printf("x5 = %llu \n", brutePtr->x5);
	printf("x6 = %llu \n", brutePtr->x6);
	printf("x7 = %llu \n", brutePtr->x7);
	printf("x8 = %llu \n", brutePtr->x8);
	printf("x9 = %llu \n", brutePtr->x9);
	
	return 0;
	
}

//hash function for a-z special chars(not congruent, but it doesn't have any collisions) ascii valid chars 33 - 126
void stringToNumaz(char *str, passNum *passPtr)
{

	for(int i = 0; i < 80; i++)
	{
		if(str[i] == '\n')
			return;

		
		if(i > 64)
			passPtr->x6 += (str[i] - 'a' + 1) * pow(26,i-65);
		else if(i > 51)
			passPtr->x5 += (str[i] - 'a' + 1) * pow(26,i-51);
		else if(i > 38)
			passPtr->x4 += (str[i] - 'a' + 1) * pow(26,i-39);
		else if(i > 25)
			passPtr->x3 += (str[i] - 'a' + 1) * pow(26,i-26);
		else if(i > 12)
			passPtr->x2 += (str[i] - 'a' + 1) * pow(26,i-13);
		else
			passPtr->x1 += (str[i] - 'a' + 1) * pow(26,i);
		}
		
	return;
}

//58 possible chars, ascii A-z
void stringToNumazAZ(char *str, passNum *passPtr)
{

	for(int i = 0; i < 80; i++)
	{
		if(str[i] == '\n')
			return;

		if(i > 79)
			passPtr->x9 += (str[i] - 'A' + 1) * pow(58,i-80);
		else if(i > 69)
			passPtr->x8 += (str[i] - 'A' + 1) * pow(58,i-70);
		else if(i > 59)
			passPtr->x7 += (str[i] - 'A' + 1) * pow(58,i-60);
		else if(i > 49)
			passPtr->x6 += (str[i] - 'A' + 1) * pow(58,i-50);
		else if(i > 39)
			passPtr->x5 += (str[i] - 'A' + 1) * pow(58,i-40);
		else if(i > 29)
			passPtr->x4 += (str[i] - 'A' + 1) * pow(58,i-30);
		else if(i > 19)
			passPtr->x3 += (str[i] - 'A' + 1) * pow(58,i-20);
		else if(i > 9)
			passPtr->x2 += (str[i] - 'A' + 1) * pow(58,i-10);
		else
			passPtr->x1 += (str[i] - 'A' + 1) * pow(58,i);
		}
		
	return;
}

//74 possible chars, asci 0 through z
void stringToNumazAZ09(char *str, passNum *passPtr)
{

	for(int i = 0; i < 80; i++)
	{
		if(str[i] == '\n')
			return;

		if(i > 79)
			passPtr->x9 += (str[i] - '0' + 1) * pow(74,i-80);
		else if(i > 69)
			passPtr->x8 += (str[i] - '0' + 1) * pow(74,i-70);
		else if(i > 59)
			passPtr->x7 += (str[i] - '0' + 1) * pow(74,i-60);
		else if(i > 49)
			passPtr->x6 += (str[i] - '0' + 1) * pow(74,i-50);
		else if(i > 39)
			passPtr->x5 += (str[i] - '0' + 1) * pow(74,i-40);
		else if(i > 29)
			passPtr->x4 += (str[i] - '0' + 1) * pow(74,i-30);
		else if(i > 19)
			passPtr->x3 += (str[i] - '0' + 1) * pow(74,i-20);
		else if(i > 9)
			passPtr->x2 += (str[i] - '0' + 1) * pow(74,i-10);
		else 
			passPtr->x1 += (str[i] - '0' + 1) * pow(74,i);
		}
		
	return;
}

//74 possible chars, asci 0 through z
void stringToNumazAZ09sc(char *str, passNum *passPtr)
{

	for(int i = 0; i < 80; i++)
	{
		if(str[i] == '\n')
			return;

		if(i > 71)
			passPtr->x9 += (str[i] - '!' + 1) * pow(93,i-72);
		else if(i > 62)
			passPtr->x8 += (str[i] - '!' + 1) * pow(93,i-63);
		else if(i > 53)
			passPtr->x7 += (str[i] - '!' + 1) * pow(93,i-54);
		else if(i > 44)
			passPtr->x6 += (str[i] - '!' + 1) * pow(93,i-45);
		else if(i > 35)
			passPtr->x5 += (str[i] - '!' + 1) * pow(93,i-36);
		else if(i > 26)
			passPtr->x4 += (str[i] - '!' + 1) * pow(93,i-27);
		else if(i > 17)
			passPtr->x3 += (str[i] - '!' + 1) * pow(93,i-18);
		else if(i > 8)
			passPtr->x2 += (str[i] - '!' + 1) * pow(93,i-9);
		else
			passPtr->x1 += (str[i] - '!' + 1) * pow(93,i);
		}
		
	return;
}
