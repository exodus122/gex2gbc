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

make maps-docs    # regenerate the map .asm from the .bin files
make maps-verify  # fail if a generated .asm is stale or does not match its .bin
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
src/data/maps/    map data as .bin, plus the .asm generated from it (see below)
src/data/audio/   audio tracks
src/gfx/          graphics as PNGs, converted at build time
src/constants/    hardware, memory map and game constants
tools/            extraction and conversion scripts
tools/map_formats.json   record layouts for everything under src/data/maps/
```

## Map data

The map assets under `src/data/maps/` — entity lists, door lists, spawn tables — are
`.bin` files, so a map editor can read and write them directly. Beside each one is an
`.asm` that is **generated** from it by `tools/render_map_asm.py`, and it is the `.asm`
that gets assembled: `db ENTITY_SCREAM_TV_BAT` rather than `$4c`, one record per line,
with each entity named, each map id named, and each door annotated with the record that
is its reverse or marked one-way.

That gives the data one source of truth and the documentation no way to drift. `grep`
finds every map an entity appears in and the answer is current by construction; a binary
edit made in a map editor becomes a reviewable `git diff` after `make maps-docs`; and
because the generated file is what the ROM is built from, a generator bug fails
`make check` rather than quietly producing a wrong document.

`tools/map_formats.json` is where the record layouts live, and it is the file to edit
when you work out what a byte means — name it once and every map's `.asm` improves.
Nothing in the generator knows a ROM address, so unlike `tools/extract_*.py` (one-shot
scripts that read the original ROM) it is safe to re-run on edited data.

Do not hand-edit a generated `.asm`; the next build overwrites it. Edit the `.bin`, or
the schema, then `make maps-docs`.

## Making changes

`make check` is the regression test. Anything intended to be cosmetic — renaming,
re-laying-out a table, converting a literal to a label — should leave it passing.
Once you start changing behaviour it will fail by design; that is when to drop it
and test in an emulator instead.
