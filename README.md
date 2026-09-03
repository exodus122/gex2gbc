# gex2gbc

A disassembly of **Gex: Enter the Gecko** for Game Boy Color (USA, Europe).

The build reproduces the original ROM byte for byte. Everything is labelled rather
than hardcoded — there are no raw ROM addresses or bank numbers in the source — so
code and data can be moved, resized or reordered within a bank and everything that
points at it follows automatically.

## Requirements

- [RGBDS](https://rgbds.gbdev.io/) (built and verified with 1.0.3)
- Python 3, for the font encoder in `tools/`

## Building

```sh
make          # assemble and link, producing rom.gb
make check    # build, then verify rom.gb against the original's md5
make clean    # remove build output and generated graphics
```

`make` converts the PNGs under `src/gfx/` to binary, assembles `src/main.asm`, and
links the result. A successful `make check` prints `rom.gb: OK`.

If `rgbasm` and friends are not on your `PATH`, point the build at them:

```sh
make RGBDS=/path/to/rgbds/
```

## Layout

```
src/main.asm      section map - every bank, in order
src/code/         disassembled code, one file per bank or subsystem
src/data/         level entity lists and audio tracks
src/gfx/          graphics as PNGs, converted at build time
src/constants/    hardware, memory map and game constants
tools/            extraction and conversion scripts
```

## Making changes

`make check` is the regression test. Anything intended to be cosmetic — renaming,
re-laying-out a table, converting a literal to a label — should leave it passing.
Once you start changing behaviour it will fail by design; that is when to drop it
and test in an emulator instead.
