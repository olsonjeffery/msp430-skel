# The MIT License (MIT)
#
# Copyright (c) 2015 Jeff Olson <olson.jeffery@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
# Makefile for msp-skel project. This provides a basic starting point for flushing
# out a project, using low-level C (ie *not* dependant on Energia libraries and
# build-time code transformation).

# Edit this is need be. Should correspond to what will be passed into msp430-gcc's -mmcu flag
MSP430PLATFORM=msp430f5529

# Change TARGET to be whatever you want to name the output
TARGET=$(shell basename `pwd`)_$(MSP430PLATFORM).elf

# Optionally change this if you put energia somewhere else
ENERGIA_PATH ?=/Applications/Energia.app/Contents/Resources/Java/hardware/tools/msp430

# This is useful when invoking mspdebug w/o having to cwd
LD_LIBRARY_PATH=$(ENERGIA_PATH)/mspdebug

# This is set up to pull in the msp430 toolchain and apply specific flags based on
# your platform
CC=$(ENERGIA_PATH)/bin/msp430-gcc
CFLAGS=-g -mmcu=$(MSP430PLATFORM) -Wall

# mspdebug and msp430-gdb paths
MSPDEBUG=$(ENERGIA_PATH)/mspdebug/mspdebug
GDB=$(ENERGIA_PATH)/bin/msp430-gdb

# Edit this to reflect the working driver that mspdebug will use on your system (tilib is a good choice)
MSPDEBUG_DRIVER=sim

SOURCES=$(wildcard src/**/*.c src/*.c src/**/*.cpp src/*.cpp)
DEPS=$(wildcard src/**/*.h src/*.h src/**/*.hpp src/*.hpp)

all: lint $(TARGET)

$(TARGET): $(SOURCES) $(DEPS)
	$(CC) -o $@ $(SOURCES) $(CFLAGS)

.PHONY: lint clean

lint:
	cppcheck --std=c11 $(SOURCES) $(DEPS)

clean:
	rm -Rf $(TARGET)

flash: all
	LD_LIBRARY_PATH=$(LD_LIBRARY_PATH) $(MSPDEBUG) $(MSPDEBUG_DRIVER) "prog $(TARGET)"

debug: all
	LD_LIBRARY_PATH=$(LD_LIBRARY_PATH) $(MSPDEBUG) $(MSPDEBUG_DRIVER) "prog $(TARGET)" gdb &
	$(GDB) $(TARGET) --eval="target remote localhost:2000"
