ROM := rom.gb
BUILDDIR := build

SRCS := $(wildcard src/main.asm)
GFXS := $(shell find src/gfx/ -type f -name '*.png')

RGBDS ?=
RGBASM  ?= $(RGBDS)rgbasm
RGBFIX  ?= $(RGBDS)rgbfix
RGBGFX  ?= $(RGBDS)rgbgfx
RGBLINK ?= $(RGBDS)rgblink

PYTHON  ?= python3
FONTGFX := $(PYTHON) tools/fontgfx.py
RENDERMAP := $(PYTHON) tools/render_map_asm.py

# The binary map assets under src/data/maps/ are the source of truth for their bytes;
# tools/map_formats.json is the source of truth for what those bytes mean. The .asm
# below is generated from both and is what gets assembled, so a stale document cannot
# survive a build - and if the generator is wrong, `make check` says so.
# Adding an asset type to the schema is picked up here with no Makefile edit.
MAPASM := $(shell $(RENDERMAP) --list-outputs)

OBJS := $(patsubst src/main.asm,$(BUILDDIR)/rom.o,$(SRCS))
DEPS := $(patsubst src/main.asm,$(BUILDDIR)/rom.mk,$(SRCS))

all: $(ROM)

check: $(ROM)
	md5sum -c $(ROM).md5

clean:
	-rm -rf $(BUILDDIR) $(ROM) src/.gfx

$(ROM): $(OBJS)
	@mkdir -p $(@D)
	$(RGBLINK) -w -m $(BUILDDIR)/$(basename $@).map -n $(basename $@).sym -o $@ $^
	$(RGBFIX) --validate $(FIXFLAGS) $@

# assemble .asm → build/rom.o and build/rom.mk
$(BUILDDIR)/rom.o $(BUILDDIR)/rom.mk: src/main.asm $(MAPASM) $(patsubst src/gfx/%.png,src/.gfx/%.bin,$(GFXS))
	@mkdir -p $(BUILDDIR)
	$(RGBASM) -Wall -Wextra --export-all -Isrc -I.gfx \
		-M $(BUILDDIR)/rom.mk -MP -MQ $(BUILDDIR)/rom.o -MQ $(BUILDDIR)/rom.mk \
		-o $(BUILDDIR)/rom.o $<

# bin -> annotated asm. The mirror image of the png -> bin rule below: there the
# editable source is the PNG and the build derives the bytes, here the editable source
# is the .bin and the build derives the documentation.
# Scoped to src/data/maps/ deliberately: a bare `%.asm: %.bin` would offer to
# regenerate ANY .asm that happens to have a same-stem .bin beside it.
src/data/maps/%.asm: src/data/maps/%.bin tools/render_map_asm.py tools/map_formats.json
	$(RENDERMAP) -q -o $@ $<

# Regenerate every generated map .asm.
maps-docs:
	$(RENDERMAP) --all

# Fail if a checked-in generated .asm is stale, or if one does not re-assemble to its
# .bin byte for byte. The second check is what lets this be trusted without rgbasm.
maps-verify:
	$(RENDERMAP) --check
	$(RENDERMAP) --verify -q

# Special gfx processing flags
src/.gfx/entity_sprites/%.bin: rgbgfx += --columns
src/.gfx/misc_sprites/%.bin: rgbgfx += --columns

# png → .bin
src/.gfx/%.bin: src/gfx/%.png
	@mkdir -p $(dir $@)
	$(RGBGFX) $(rgbgfx) -o $@ $<

# The bank 01 menu fonts are not 8x8 tile data - their glyphs are 6, 7 and 11 PIXELS
# tall (see data_01_65fe_FontDescriptors in bank01_menus.asm), so rgbgfx cannot describe them at all.
# They go through tools/fontgfx.py instead. This pattern is more specific than the
# generic src/.gfx/%.bin rule above, so make prefers it (shorter stem wins).
src/.gfx/fonts/font_small.bin:  fontgfx = --cols 1 --height 6
src/.gfx/fonts/font_medium.bin: fontgfx = --cols 1 --height 7
src/.gfx/fonts/font_large.bin:  fontgfx = --cols 2 --height 11

src/.gfx/fonts/%.bin: src/gfx/fonts/%.png
	@mkdir -p $(dir $@)
	$(FONTGFX) encode $(fontgfx) -o $@ $<

# One-time bootstrap: turn the checked-in font .bin files into the .png sources.
fonts-png:
	$(FONTGFX) decode-all

# Assert that png → bin reproduces the original .bin byte for byte
fonts-verify:
	$(FONTGFX) verify-all

ifneq ($(MAKECMDGOALS),clean)
-include $(DEPS)
endif

.PHONY: all clean check fonts-png fonts-verify maps-docs maps-verify
.SECONDARY:
