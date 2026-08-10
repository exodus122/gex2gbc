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
$(BUILDDIR)/rom.o $(BUILDDIR)/rom.mk: src/main.asm $(patsubst src/gfx/%.png,src/.gfx/%.bin,$(GFXS))
	@mkdir -p $(BUILDDIR)
	$(RGBASM) -Wall -Wextra --export-all -Isrc -I.gfx \
		-M $(BUILDDIR)/rom.mk -MP -MQ $(BUILDDIR)/rom.o -MQ $(BUILDDIR)/rom.mk \
		-o $(BUILDDIR)/rom.o $<

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
src/.gfx/fonts/image_001_66a7_font.bin: fontgfx = --cols 1 --height 6
src/.gfx/fonts/image_001_689f_font.bin: fontgfx = --cols 1 --height 7
src/.gfx/fonts/image_001_6add_font.bin: fontgfx = --cols 2 --height 11

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

.PHONY: all clean check fonts-png fonts-verify
.SECONDARY:
