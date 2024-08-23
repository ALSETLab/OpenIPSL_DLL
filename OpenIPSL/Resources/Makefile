ifeq ($(OS),Windows_NT)
	SHELL=cmd
    RM = cmd //C del //Q //F
else
    RM = rm -f
endif


CC = gcc
CFLAGS = -Wall -fpic -Wno-unused-variable -Wno-unused-value
INCLUDE_DIR = Include
LIBRARY_DIR = Library

DLL_NAME = $(LIBRARY_DIR)/SCRX9.dll
DLL_GFM_NAME = $(LIBRARY_DIR)/GFM_GFL_IBR.dll

SRC = $(LIBRARY_DIR)/SCRX9.c
OBJ = $(LIBRARY_DIR)/SCRX9.o

SRC_GFM = $(LIBRARY_DIR)/GFM_GFL_IBR.c
OBJ_GFM = $(LIBRARY_DIR)/GFM_GFL_IBR.o

HEADER1 = $(INCLUDE_DIR)/IEEE_Cigre_DLLInterface_types.h
HEADER2 = $(INCLUDE_DIR)/IEEE_Cigre_DLLInterface.h

all: $(DLL_NAME) $(DLL_GFM_NAME)

$(DLL_NAME): $(OBJ) $(HEADER1) $(HEADER2)
	$(CC) -shared -o $(DLL_NAME) $(OBJ)
$(DLL_GFM_NAME): $(OBJ_GFM) $(HEADER1) $(HEADER2)
	$(CC) -shared -o $(DLL_GFM_NAME) $(OBJ_GFM)

$(OBJ): $(SRC) $(HEADER1) $(HEADER2)
	$(CC) $(CFLAGS) -I$(INCLUDE_DIR) -c $(SRC) -o $(OBJ)
$(OBJ_GFM): $(SRC_GFM) $(HEADER1) $(HEADER2)
	$(CC) $(CFLAGS) -I$(INCLUDE_DIR) -c $(SRC_GFM) -o $(OBJ_GFM)

clean:
	$(RM) $(OBJ) $(SRC)