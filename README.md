## msp-skel

Learning learning learning.

The goal of this repo:

* Establish patterns/workflow for how I'm developing/building/deployment my msp430 projects, for future use

### Workflow Thus Far

* I'm doing this on OSX Yosemite, which has a pretty poor experience as far as raw `mspdebug` & `msp430-gcc` is concerned (most of the activity appears to be from the 2011 timeframe)
* Energia, on the other hand, works out-of-the-box with my MSP-EXP430F5529LP
* If you use the toolchain distributed in Energia, you can make it work

### What's here

1. A very basic project skeleton.
2. A `Makefile` with a few things:
  1. The default target will build an elf executable, ready to be flashed onto an msp430
  2. `lint` target, leveraging `cppcheck`
  3. `clean` target

### TODO

* Some kind of `mspdebug` thing
