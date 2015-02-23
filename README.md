## msp430-skel

Interested in a low-level, `make(1)`-based build setup for your [TI msp430](http://en.wikipedia.org/wiki/TI_MSP430) project? `msp430-skel` uses the [Energia](http://energia.nu) toolchain, but without applying its incumbent libraries & code transormations. It was created in the context of the author's challenges getting a build/test/run pipeline established on OSX Yosemite, but should be applicable to any vaguely POSIX'ish platform that Energia supports.

This codebase is released under the terms of the MIT License. See `LICENSE.txt`, in this repo, for more information.

A tip of the chapeau to [Rei Vilo](https://github.com/rei-vilo), who [pointed the author](https://github.com/energia/Energia/issues/570) towards the [embedXcode](http://embedxcode.weebly.com/) project. It was instructive in understanding how to leverage Energia to acheive `msp430-skel`'s own goal(s). If you would prefer an Xcode-based developer experience, check it out!

### Why Do This?

* The [author](http://github.com/olsonjeffery) is using OSX Yosemite which, as far as the raw `mspdebug`/`msp430-gcc`/driver experience is concerned, is somewhat poor (the most recent developer activity appears to be from the 2011 timeframe + there's all kinds of aweful kernel extension cruft to deal with)
* Energia works out-of-the-box with my MSP-EXP430F5529LP
* While Energia is great (really, it is!), the author desires a low-level, non-kid-glove environment to explore and learn the platform (particularly the abstraction around the `main()` entrypoint was irksome, in terms of "magic")
* If you use the toolchain distributed with Energia (instead of via Homebrew, MacPorts, Fink, etc), you can make satisfy the above-outlined goal quite well

### What's Included

1. A very basic project skeleton
  1. Source code layout under `src/` (basic `main.c` included)
  2. msp430-flashable elf image placed in root of repo, named `(directory basename)_(msp430 platform variant).elf`
2. A `Makefile` with a few things:
  1. The default `all` target will lint the codebase and build an elf executable, ready to be flashed onto an msp430
  2. `lint` target, leveraging `cppcheck`
  3. `clean` target
  4. `flash` target that will build the application and then use the `prog` command in `mspdebug` to flash the elf image, using the driver specified in `MSPDEBUG_DRIVER`
  5. `debug` target that flashes the application image, as in `flash`, then sets up a `msp430-gdb` session and connects to it (finishing and exiting `msp430-gdb` will also cause the `mspdebug` session to close and the process to end)

### Setup

1. Clone the repo, possibly stripping existing git history to restart as your application (perhaps also dropping the `LICENSE.txt` as the project-wide license)
2. Edit the `Makefile`, particularly:
  1. `MSP430PLATFORM`: the board/chip variant that you're using (should correspond to whatever you would pass to `msp430-gcc`'s `-mmcu` flag)
  2. `TARGET`: Defaults to the enclosing directory's basename, combined with the value of `MSP430PLATFORM`
  3. `MSPDEBUG_DRIVER`: Defaults to `sim`, which is just a test driver (`tilib` is the working driver of choice on the author's system)
3. You most likely want to install [cppcheck](http://cppcheck.sourceforge.net/) so that the `lint` target works, otherwise remove `lint` from the `all` target
4. Optionally, you'll want to either edit the `ENERGIA_PATH` variable or set it in your environment (the default is the install path for `Energia.app` in the author's OSX Yosemite setup)
5. Have fun!
