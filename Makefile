ENERGIA_PATH=/Applications/Energia.app/Contents/Resources/Java/hardware/tools/msp430
CC=$(ENERGIA_PATH)/bin/msp430-gcc
CFLAGS=-g -mmcu=msp430f5529
LD_LIBRARY_PATH=$(ENERGIA_PATH)
ODIR=obj
_OBJ = main.o
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

hw.elf: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)

$(ODIR)/%.o: %.c
	mkdir -p $(ODIR)
	$(CC) -c -o $@ $< $(CFLAGS)

.PHONY: lint clean

lint:
	cppcheck --std=c11 *.c *.h

clean:
	rm -Rf hw.elf $(ODIR)
