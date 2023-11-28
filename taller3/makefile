# Makefile 

# Compilers
NVCC = nvcc
CXX = g++

# Flags
NVCC_FLAGS = -arch=sm_20
CXX_FLAGS = -std=c++11

# Source files
CU_FILES = archivo1.cu archivo2.cu archivo3.cu
CPP_FILES = book.h

# Object files
OBJ_FILES = $(CU_FILES:.cu=.o)

# Output executable
OUT_EXE = tu_ejecutable

# Target
all: $(OUT_EXE)

$(OUT_EXE): $(OBJ_FILES)
	$(NVCC) $(NVCC_FLAGS) -o $@ $^ $(CXX_FLAGS)

%.o: %.cu $(CPP_FILES)
	$(NVCC) $(NVCC_FLAGS) -o $@ -c $< $(CXX_FLAGS)

clean:
	rm -f $(OUT_EXE) $(OBJ_FILES)
