CC=/usr/local/apps/cuda/3.2/cuda/bin/nvcc
INCLUDE=-I/usr/local/apps/cuda/3.2/cuda/include \
        -I/usr/local/apps/cuda/SDK2/C/common/inc

LIBDIR=-L/usr/local/apps/cuda/SDK2/C/lib
OMP=-Xcompiler -fopenmp
LIBS=-lcutil
BRUTESOURCE=bruteForce.cu
EXECUTABLE=brute
#this compiles all of the code for all the different programs
#$(EXECUTABLE): $(CC) $(INCLUDE) $(LIBDIR) $(LIBS) -o brute bruteForce.cu
# $(BRUTESOURCE)
$(EXECUTABLE): bruteForce.cu
	$(CC) $(INCLUDE) $(LIBDIR) $(OMP) $< -o $@ $(LIBS)
	
sequencialBrute: gcc -o bruteSeq bruteForce.cu
clean: 
	@echo
	 rm brute
	 @echo
	 @echo Done
	
	
#sequencial version
#source files
#SPARSESOURCE=sparse_matvec.cu
#same compiler and libraries
#seq:
	# $(CC) $(INCLUDE) $(LIBDIR) $(LIBS) -o seq $(SPARSESOURCE)
	# #$< -o $@ $(LIBS)
	
# run: seq
	# @echo finish compiling
	# ./seq sm2.txt
	# @echo finish running
# clean: 
	# @echo
	# rm $(EXECUTABLE) seq
	# @echo
	# @echo Done
