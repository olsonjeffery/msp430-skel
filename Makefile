ENERGIA_PATH=/Applications/Energia.app/Contents/Resources/Java/hardware/tools/msp430
CC=$(ENERGIA_PATH)/bin/msp430-gcc
CFLAGS=-g -mmcu=msp430f5529 -Wpendantic -Wall
LD_LIBRARY_PATH=$(ENERGIA_PATH)
SOURCES = $(wildcard src/**/*.c src/*.c src/**/*.cpp src/*.cpp)
DEPS = $(wildcard src/**/*.h src/*.h src/**/*.hpp src/*.hpp)
TARGET = hello-worlf.elf

all: lint $(TARGET)

$(TARGET): $(SOURCES) $(DEPS)
	$(CC) -o $@ $(SOURCES) $(CFLAGS)

.PHONY: lint clean

lint:
	cppcheck --std=c11 $(SOURCES) $(DEPS)

clean:
	rm -Rf $(TARGET)
