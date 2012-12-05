//#include "stdafx.h"
#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <cutil.h>
#include <unistd.h>
#include <stdbool.h>
#include <math.h>
#include <stdint.h>
#include <omp.h>

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
uint64_t x10;
uint64_t x11;
uint64_t x12;
uint64_t x13;
uint64_t x14;
};

extern void findPass_wrapper(passNum *passPtr, passNum *bruteNumOut);
extern __global__ void findPass(uint64_t *passPtr, uint64_t *bruteNumOut);
extern void seqFindPass_wrapper(passNum *passPtr, passNum *bruteNumOut);
extern void seqFindPass(uint64_t *passPtr, uint64_t *bruteNumOut);
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
__device__ uint64_t bruteOut = 0;

//wrapper for findPass, allocates memory then passes it to device and calls findPass
extern void findPass_wrapper(passNum *passPtr, passNum *bruteNumOut)
{
	uint64_t *devI1Ptr;
	uint64_t *dev01Ptr;
	
	cudaMalloc((void **)&dev01Ptr, sizeof(uint64_t));
    cudaMemcpy(dev01Ptr, &bruteNumOut->x1, sizeof(uint64_t), cudaMemcpyHostToDevice);
    cudaMalloc((void **)&devI1Ptr, sizeof(uint64_t));
    cudaMemcpy(devI1Ptr, &passPtr->x1, sizeof(uint64_t), cudaMemcpyHostToDevice);

    
    dim3 dimGrid(40960, 1);
    dim3 dimBlock(512, 1);
    
    if(passPtr->x1 != 0)
    {
		findPass<<<dimGrid,dimBlock>>>(devI1Ptr, dev01Ptr);
		cudaThreadSynchronize();
		//cudaMemcpy(&bruteNumOut->x1, dev01Ptr, sizeof(uint64_t), cudaMemcpyDeviceToHost);
		cudaMemcpyFromSymbol(&bruteNumOut->x1, "bruteOut", sizeof(uint64_t),0,cudaMemcpyDeviceToHost);
		bruteOut = 0;
    }
    
    if(passPtr->x2 != 0)
    {
		cudaMemcpy(devI1Ptr, &passPtr->x2, sizeof(uint64_t), cudaMemcpyHostToDevice);
		cudaMemcpy(dev01Ptr, &bruteNumOut->x2, sizeof(uint64_t), cudaMemcpyHostToDevice);
		findPass<<<dimGrid,dimBlock>>>(devI1Ptr, dev01Ptr);
		cudaThreadSynchronize();
		cudaMemcpyFromSymbol(&bruteNumOut->x2, "bruteOut", sizeof(uint64_t),0,cudaMemcpyDeviceToHost);
		bruteOut = 0;
    }
    
        if(passPtr->x3 != 0)
    {
		cudaMemcpy(devI1Ptr, &passPtr->x3, sizeof(uint64_t), cudaMemcpyHostToDevice);
		cudaMemcpy(dev01Ptr, &bruteNumOut->x3, sizeof(uint64_t), cudaMemcpyHostToDevice);
		findPass<<<dimGrid,dimBlock>>>(devI1Ptr, dev01Ptr);
		cudaThreadSynchronize();
		cudaMemcpyFromSymbol(&bruteNumOut->x3, "bruteOut", sizeof(uint64_t),0,cudaMemcpyDeviceToHost);
		bruteOut = 0;
    }
    
        if(passPtr->x4 != 0)
    {
		cudaMemcpy(devI1Ptr, &passPtr->x4, sizeof(uint64_t), cudaMemcpyHostToDevice);
		cudaMemcpy(dev01Ptr, &bruteNumOut->x4, sizeof(uint64_t), cudaMemcpyHostToDevice);
		findPass<<<dimGrid,dimBlock>>>(devI1Ptr, dev01Ptr);
		cudaThreadSynchronize();
		cudaMemcpyFromSymbol(&bruteNumOut->x4, "bruteOut", sizeof(uint64_t),0,cudaMemcpyDeviceToHost);
		bruteOut = 0;
    }
    
        if(passPtr->x5 != 0)
    {
		cudaMemcpy(devI1Ptr, &passPtr->x5, sizeof(uint64_t), cudaMemcpyHostToDevice);
		cudaMemcpy(dev01Ptr, &bruteNumOut->x5, sizeof(uint64_t), cudaMemcpyHostToDevice);
		findPass<<<dimGrid,dimBlock>>>(devI1Ptr, dev01Ptr);
		cudaThreadSynchronize();
		cudaMemcpyFromSymbol(&bruteNumOut->x5, "bruteOut", sizeof(uint64_t),0,cudaMemcpyDeviceToHost);
		bruteOut = 0;
    }
    
        if(passPtr->x6 != 0)
    {
		cudaMemcpy(devI1Ptr, &passPtr->x6, sizeof(uint64_t), cudaMemcpyHostToDevice);
		cudaMemcpy(dev01Ptr, &bruteNumOut->x6, sizeof(uint64_t), cudaMemcpyHostToDevice);
		findPass<<<dimGrid,dimBlock>>>(devI1Ptr, dev01Ptr);
		cudaThreadSynchronize();
		cudaMemcpyFromSymbol(&bruteNumOut->x6, "bruteOut", sizeof(uint64_t),0,cudaMemcpyDeviceToHost);
		bruteOut = 0;
    }
    
        if(passPtr->x7 != 0)
    {
		cudaMemcpy(devI1Ptr, &passPtr->x7, sizeof(uint64_t), cudaMemcpyHostToDevice);
		cudaMemcpy(dev01Ptr, &bruteNumOut->x7, sizeof(uint64_t), cudaMemcpyHostToDevice);
		findPass<<<dimGrid,dimBlock>>>(devI1Ptr, dev01Ptr);
		cudaThreadSynchronize();
		cudaMemcpyFromSymbol(&bruteNumOut->x7, "bruteOut", sizeof(uint64_t),0,cudaMemcpyDeviceToHost);
		bruteOut = 0;
    }
    
        if(passPtr->x8 != 0)
    {
		cudaMemcpy(devI1Ptr, &passPtr->x8, sizeof(uint64_t), cudaMemcpyHostToDevice);
		cudaMemcpy(dev01Ptr, &bruteNumOut->x8, sizeof(uint64_t), cudaMemcpyHostToDevice);
		findPass<<<dimGrid,dimBlock>>>(devI1Ptr, dev01Ptr);
		cudaThreadSynchronize();
		cudaMemcpyFromSymbol(&bruteNumOut->x8, "bruteOut", sizeof(uint64_t),0,cudaMemcpyDeviceToHost);
		bruteOut = 0;
    }
    
        if(passPtr->x9 != 0)
    {
		cudaMemcpy(devI1Ptr, &passPtr->x9, sizeof(uint64_t), cudaMemcpyHostToDevice);
		cudaMemcpy(dev01Ptr, &bruteNumOut->x9, sizeof(uint64_t), cudaMemcpyHostToDevice);
		findPass<<<dimGrid,dimBlock>>>(devI1Ptr, dev01Ptr);
		cudaThreadSynchronize();
		cudaMemcpyFromSymbol(&bruteNumOut->x9, "bruteOut", sizeof(uint64_t),0,cudaMemcpyDeviceToHost);
		bruteOut = 0;
    }
    
        if(passPtr->x10 != 0)
    {
		cudaMemcpy(devI1Ptr, &passPtr->x10, sizeof(uint64_t), cudaMemcpyHostToDevice);
		cudaMemcpy(dev01Ptr, &bruteNumOut->x10, sizeof(uint64_t), cudaMemcpyHostToDevice);
		findPass<<<dimGrid,dimBlock>>>(devI1Ptr, dev01Ptr);
		cudaThreadSynchronize();
		cudaMemcpyFromSymbol(&bruteNumOut->x10, "bruteOut", sizeof(uint64_t),0,cudaMemcpyDeviceToHost);
		bruteOut = 0;
    }
    
        if(passPtr->x11 != 0)
    {
		cudaMemcpy(devI1Ptr, &passPtr->x11, sizeof(uint64_t), cudaMemcpyHostToDevice);
		cudaMemcpy(dev01Ptr, &bruteNumOut->x11, sizeof(uint64_t), cudaMemcpyHostToDevice);
		findPass<<<dimGrid,dimBlock>>>(devI1Ptr, dev01Ptr);
		cudaThreadSynchronize();
		cudaMemcpyFromSymbol(&bruteNumOut->x11, "bruteOut", sizeof(uint64_t),0,cudaMemcpyDeviceToHost);
		bruteOut = 0;
    }
    
        if(passPtr->x12 != 0)
    {
		cudaMemcpy(devI1Ptr, &passPtr->x12, sizeof(uint64_t), cudaMemcpyHostToDevice);
		cudaMemcpy(dev01Ptr, &bruteNumOut->x12, sizeof(uint64_t), cudaMemcpyHostToDevice);
		findPass<<<dimGrid,dimBlock>>>(devI1Ptr, dev01Ptr);
		cudaThreadSynchronize();
		cudaMemcpyFromSymbol(&bruteNumOut->x12, "bruteOut", sizeof(uint64_t),0,cudaMemcpyDeviceToHost);
		bruteOut = 0;
    }
    
            if(passPtr->x13 != 0)
    {
		cudaMemcpy(devI1Ptr, &passPtr->x13, sizeof(uint64_t), cudaMemcpyHostToDevice);
		cudaMemcpy(dev01Ptr, &bruteNumOut->x13, sizeof(uint64_t), cudaMemcpyHostToDevice);
		findPass<<<dimGrid,dimBlock>>>(devI1Ptr, dev01Ptr);
		cudaThreadSynchronize();
		cudaMemcpyFromSymbol(&bruteNumOut->x13, "bruteOut", sizeof(uint64_t),0,cudaMemcpyDeviceToHost);
		bruteOut = 0;
    }
    
            if(passPtr->x14 != 0)
    {
		cudaMemcpy(devI1Ptr, &passPtr->x14, sizeof(uint64_t), cudaMemcpyHostToDevice);
		cudaMemcpy(dev01Ptr, &bruteNumOut->x14, sizeof(uint64_t), cudaMemcpyHostToDevice);
		findPass<<<dimGrid,dimBlock>>>(devI1Ptr, dev01Ptr);
		cudaThreadSynchronize();
		cudaMemcpyFromSymbol(&bruteNumOut->x14, "bruteOut", sizeof(uint64_t),0,cudaMemcpyDeviceToHost);
		bruteOut = 0;
    }
    /*cudaError_t cudaErr;
    cudaErr = cudaGetLastError();
    printf("%s\n", cudaGetErrorString(cudaErr));
    cudaThreadSynchronize();*/
    
    cudaFree(devI1Ptr);
    cudaFree(dev01Ptr);
    return;
} 

extern __global__ void findPass(uint64_t *passPtr, uint64_t *bruteNumOut)
{
	//each thread gets its own passNum to increment
	uint64_t bruteNum = 0;
	uint64_t passNum = *passPtr;
	int bx = blockIdx.x; //40960 blocks
	int tx = threadIdx.x; //512 threads
	int tid = tx + 512*bx;
	int stride = 40960*512;
	isCracked = false;

	__syncthreads();
	if(tid <= passNum){
		//bruteNum starts at its tid, then increments by stride
		bruteNum = tid;

		while(!isCracked)
		{
		
				//if we have found the password
				if(bruteNum >= passNum)
				{
					bruteOut = passNum;
					//*bruteNumOut = bruteNum;
					//set output to the found password
				isCracked = true; //we're done
				}

				bruteNum += stride;
		
}}
return;
}

void seqFindPass_wrapper(passNum *passPtr, passNum *bruteNumOut)
{
	if(passPtr->x1 != 0)
    {
		seqFindPass(&passPtr->x1, &bruteNumOut->x1);
    }
    
    if(passPtr->x2 != 0)
    {
		seqFindPass(&passPtr->x2, &bruteNumOut->x2);
    }
    
    if(passPtr->x3 != 0)
    {
		seqFindPass(&passPtr->x3, &bruteNumOut->x3);
    }
    
    if(passPtr->x4 != 0)
    {
		seqFindPass(&passPtr->x4, &bruteNumOut->x4);
    }
    
    if(passPtr->x5 != 0)
    {
		seqFindPass(&passPtr->x5, &bruteNumOut->x5);
    }
    
    if(passPtr->x6 != 0)
    {
		seqFindPass(&passPtr->x6, &bruteNumOut->x6);
    }
    
    if(passPtr->x7 != 0)
    {
		seqFindPass(&passPtr->x7, &bruteNumOut->x7);
    }
    
    if(passPtr->x8 != 0)
    {
		seqFindPass(&passPtr->x8, &bruteNumOut->x8);
    }
    
    if(passPtr->x9 != 0)
    {
		seqFindPass(&passPtr->x9, &bruteNumOut->x9);
    }
    
    if(passPtr->x10 != 0)
    {
		seqFindPass(&passPtr->x10, &bruteNumOut->x10);
    }
    
    if(passPtr->x11 != 0)
    {
		seqFindPass(&passPtr->x11, &bruteNumOut->x11);
    }
    
    if(passPtr->x13 != 0)
    {
		seqFindPass(&passPtr->x13, &bruteNumOut->x13);
    }
    
    if(passPtr->x14 != 0)
    {
		seqFindPass(&passPtr->x14, &bruteNumOut->x14);
    }
    
    return;
}

void seqFindPass(uint64_t *passPtr, uint64_t *bruteNumOut)
{
uint64_t bruteNum = *passPtr;
uint64_t i;
#pragma omp parallel for
for(i = 0; i <= bruteNum; i++)
{
}

*bruteNumOut = i;
return;
}


int main (int argc, char **argv) {
	//variables
	char passTypeChar[4];
	int passType = 0; //type of password
	char text[80];//users password
	passNum pass = {0,0,0,0,0,0,0,0,0,0,0,0,0,0};//Users entered password
	passNum *passPtr = &pass;
	passNum brute = {0,0,0,0,0,0,0,0,0,0,0,0,0,0};//programs cracked password to be found
	passNum *brutePtr = &brute;
	passNum seqbrute = {0,0,0,0,0,0,0,0,0,0,0,0,0,0};//seq programs cracked password to be found
	passNum *seqbrutePtr = &seqbrute;
	
	//take in user inputs   
	printf("\n1: a-z\n2: a-z A-Z\n3: a-z A-Z 0-9\n4: a-z A-Z 0-9 Special Characters\n");
	printf("Please Enter The Type of Password: ");
	fflush(stdout); /* http://c-faq.com/stdio/fflush.html */
	fgets(passTypeChar, sizeof passTypeChar, stdin);
	passType = atoi(passTypeChar);
	fputs("Please Enter Your Password: ", stdout);
	fflush(stdout); /* http://c-faq.com/stdio/fflush.html */
	fgets(text, sizeof text, stdin);
	
	char *str = &text[0];
	switch(passType)
	{
	case 1:
	stringToNumaz(str, passPtr);
	break;
	
	case 2:
	stringToNumazAZ(str, passPtr);
	break;
	
	case 3:
	stringToNumazAZ09(str, passPtr);
	break;
	
	case 4:
	stringToNumazAZ09sc(str, passPtr);
	break;
	
	default:
	printf("Please enter a valid password type!\n");
	return 0;
	}
	
	printf("Working...\n");
	
	// create CUDA event handles for timing purposes
	cudaEvent_t start_event, stop_event;
	float elapsed_time_gpu, elapsed_time_cpu;
  
	CUDA_SAFE_CALL( cudaEventCreate(&start_event) );
	CUDA_SAFE_CALL( cudaEventCreate(&stop_event) );
	cudaEventRecord(start_event, 0);   
	seqFindPass_wrapper(passPtr, seqbrutePtr);
	cudaEventRecord(stop_event, 0);
	cudaEventSynchronize(stop_event);
	CUDA_SAFE_CALL( cudaEventElapsedTime(&elapsed_time_cpu,start_event, stop_event) )
  
	CUDA_SAFE_CALL( cudaEventCreate(&start_event) );
	CUDA_SAFE_CALL( cudaEventCreate(&stop_event) );
	cudaEventRecord(start_event, 0);   
	findPass_wrapper(passPtr, brutePtr);
	cudaThreadSynchronize();
	cudaEventRecord(stop_event, 0);
	cudaEventSynchronize(stop_event);
	CUDA_SAFE_CALL( cudaEventElapsedTime(&elapsed_time_gpu,start_event, stop_event) )
  
  //print out statistics
	printf("Found!\nCPU Brute Force Time: %.2f msec\n", elapsed_time_cpu);
	printf("GPU Brute Force Time: %.2f msec\n", elapsed_time_gpu);
	printf("GPU Speedup: %.2f\n", elapsed_time_cpu/elapsed_time_gpu);
	printf("Your password is %s\n",text);
	printf("The computation tried the following number of strings:\n");
	
	printf("%llu +\n", brutePtr->x1);
	if(brutePtr->x2 > 0)
		printf("%llu +\n", brutePtr->x2);
	if(brutePtr->x3 > 0)
		printf("%llu +\n", brutePtr->x3);
	if(brutePtr->x4 > 0)
		printf("%llu +\n", brutePtr->x4);
	if(brutePtr->x5 > 0)
		printf("%llu +\n", brutePtr->x5);
	if(brutePtr->x6 > 0)
		printf("%llu +\n", brutePtr->x6);
	if(brutePtr->x7 > 0)
		printf("%llu +\n", brutePtr->x7);
	if(brutePtr->x8 > 0)
		printf("%llu +\n", brutePtr->x8);
	if(brutePtr->x9 > 0)
		printf("%llu +\n", brutePtr->x9);
	if(brutePtr->x10 > 0)
		printf("%llu +\n", brutePtr->x10);
	if(brutePtr->x11 > 0)
		printf("%llu +\n", brutePtr->x11);
	if(brutePtr->x12 > 0)
		printf("%llu +\n", brutePtr->x12);
	if(brutePtr->x13 > 0)
		printf("%llu +\n", brutePtr->x13);
	if(brutePtr->x14 > 0)
		printf("%llu +\n", brutePtr->x14);
	
	return 0;
}

//hash function for a-z special chars(not congruent, but it doesn't have any collisions) ascii valid chars 33 - 126
void stringToNumaz(char *str, passNum *passPtr)
{
	
	for(int i = 0; i < 80; i++)
	{
		if(str[i] == '\n')
			return;
		
		if(i > 79)
			passPtr->x11 += (str[i] - 'a' + 1) * pow(26,i-80);
		else if(i > 71)
			passPtr->x10 += (str[i] - 'a' + 1) * pow(26,i-72);
		else if(i > 63)
			passPtr->x9 += (str[i] - 'a' + 1) * pow(26,i-64);
		else if(i > 55)
			passPtr->x8 += (str[i] - 'a' + 1) * pow(26,i-56);
		else if(i > 47)
			passPtr->x7 += (str[i] - 'a' + 1) * pow(26,i-48);
		else if(i > 39)
			passPtr->x6 += (str[i] - 'a' + 1) * pow(26,i-40);
		else if(i > 31)
			passPtr->x5 += (str[i] - 'a' + 1) * pow(26,i-32);
		else if(i > 23)
			passPtr->x4 += (str[i] - 'a' + 1) * pow(26,i-24);
		else if(i > 15)
			passPtr->x3 += (str[i] - 'a' + 1) * pow(26,i-16);
		else if(i > 7)
			passPtr->x2 += (str[i] - 'a' + 1) * pow(26,i-8);
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


		if(i > 77)
			passPtr->x14 += (str[i] - 'A' + 1) * pow(58,i-78);
		else if(i > 71)
			passPtr->x13 += (str[i] - 'A' + 1) * pow(58,i-72);
		else if(i > 65)
			passPtr->x12 += (str[i] - 'A' + 1) * pow(58,i-66);
		else if(i > 59)
			passPtr->x11 += (str[i] - 'A' + 1) * pow(58,i-60);
		else if(i > 53)
			passPtr->x10 += (str[i] - 'A' + 1) * pow(58,i-54);
		else if(i > 47)
			passPtr->x9 += (str[i] - 'A' + 1) * pow(58,i-48);
		else if(i > 41)
			passPtr->x8 += (str[i] - 'A' + 1) * pow(58,i-42);
		else if(i > 35)
			passPtr->x7 += (str[i] - 'A' + 1) * pow(58,i-36);
		else if(i > 29)
			passPtr->x6 += (str[i] - 'A' + 1) * pow(58,i-30);
		else if(i > 23)
			passPtr->x5 += (str[i] - 'A' + 1) * pow(58,i-24);
		else if(i > 17)
			passPtr->x4 += (str[i] - 'A' + 1) * pow(58,i-18);
		else if(i > 11)
			passPtr->x3 += (str[i] - 'A' + 1) * pow(58,i-12);
		else if(i > 5)
			passPtr->x2 += (str[i] - 'A' + 1) * pow(58,i-6);
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

		if(i > 77)
			passPtr->x14 += (str[i] - '0' + 1) * pow(58,i-78);
		else if(i > 71)
			passPtr->x13 += (str[i] - '0' + 1) * pow(58,i-72);
		else if(i > 65)
			passPtr->x12 += (str[i] - '0' + 1) * pow(58,i-66);
		else if(i > 59)
			passPtr->x11 += (str[i] - '0' + 1) * pow(58,i-60);
		else if(i > 53)
			passPtr->x10 += (str[i] - '0' + 1) * pow(58,i-54);
		else if(i > 47)
			passPtr->x9 += (str[i] - '0' + 1) * pow(58,i-48);
		else if(i > 41)
			passPtr->x8 += (str[i] - '0' + 1) * pow(58,i-42);
		else if(i > 35)
			passPtr->x7 += (str[i] - '0' + 1) * pow(58,i-36);
		else if(i > 29)
			passPtr->x6 += (str[i] - '0' + 1) * pow(58,i-30);
		else if(i > 23)
			passPtr->x5 += (str[i] - '0' + 1) * pow(58,i-24);
		else if(i > 17)
			passPtr->x4 += (str[i] - '0' + 1) * pow(58,i-18);
		else if(i > 11)
			passPtr->x3 += (str[i] - '0' + 1) * pow(58,i-12);
		else if(i > 5)
			passPtr->x2 += (str[i] - '0' + 1) * pow(58,i-6);
		else
			passPtr->x1 += (str[i] - '0' + 1) * pow(58,i);
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

		if(i > 77)
			passPtr->x14 += (str[i] - '!' + 1) * pow(58,i-78);
		else if(i > 71)
			passPtr->x13 += (str[i] - '!' + 1) * pow(58,i-72);
		else if(i > 65)
			passPtr->x12 += (str[i] - '!' + 1) * pow(58,i-66);
		else if(i > 59)
			passPtr->x11 += (str[i] - '!' + 1) * pow(58,i-60);
		else if(i > 53)
			passPtr->x10 += (str[i] - '!' + 1) * pow(58,i-54);
		else if(i > 47)
			passPtr->x9 += (str[i] - '!' + 1) * pow(58,i-48);
		else if(i > 41)
			passPtr->x8 += (str[i] - '!' + 1) * pow(58,i-42);
		else if(i > 35)
			passPtr->x7 += (str[i] - '!' + 1) * pow(58,i-36);
		else if(i > 29)
			passPtr->x6 += (str[i] - '!' + 1) * pow(58,i-30);
		else if(i > 23)
			passPtr->x5 += (str[i] - '!' + 1) * pow(58,i-24);
		else if(i > 17)
			passPtr->x4 += (str[i] - '!' + 1) * pow(58,i-18);
		else if(i > 11)
			passPtr->x3 += (str[i] - '!' + 1) * pow(58,i-12);
		else if(i > 5)
			passPtr->x2 += (str[i] - '!' + 1) * pow(58,i-6);
		else
			passPtr->x1 += (str[i] - '!' + 1) * pow(58,i);
		}
		
	return;
}
