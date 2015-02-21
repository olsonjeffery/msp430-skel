## msp-hw

Learning learning learning.

Mostly I want to establish patterns/workflow for how I'm developing/building/deployment my projects, so that I can leverage it in future endevours.

### Workflow Thus Far

* I'm doing this on OSX Yosemite, which has a pretty poor experience as far as raw `mspdebug` & `msp430-gcc` is concerned
* Energia, on the other hand, works out-of-the-box with my MSP-EXP430F5529LP
* Building/flashing on Energia (so we're forced to pull in the Energia boilerplate + `void`/`setup`)
* But other files are normal C
* The "use external editor" option is enabled, so I'm actually writing code in Emacs
* Sadly this means I'm not standing up the `main` function, disabling the watchdog timer, etc
* But I should be able to otherwise avoid the Energia API, if so desired, and write straight-up C
* I'm going to set up some `Makefile` helpers for advanced linting, etc, apart from building
