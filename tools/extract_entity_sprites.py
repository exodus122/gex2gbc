#!/usr/bin/env python3
"""
Split the entity/player tile banks into spritesheets, cut where the CODE cuts them.

The old extract_sprites_vertical() chopped banks $04-$07, $11-$12 and $18-$1C into
blind $2000-byte slabs. Nothing in the game addresses tiles that way. Three separate
mechanisms do, and each one says exactly where a picture starts and stops:

  banks $04-$07  call_00_098f_CopyPlayerGfxToVRAM
                 Gex. wD208_Player_SpriteID is a page number: bank
                 $04 + (id >> 6), address $4000 + (id & $3F) * $100. One page is one
                 32x32 frame, drawn by call_03_5ca8_Player_BuildSprites. Which pages
                 belong together is declared by data_02_4120_EntityActions_Gex - the
                 32 player actions, each naming its own frame list.

  banks $18-$1C  call_02_7030_Entity_NotifyActionChanged
                 The streaming enemies. Same page addressing, but the bank comes from
                 .data_02_7061_EntityGfxBankTable indexed by entity id, and the frame
                 lists come from that entity's action table. Every enemy owns a
                 contiguous run of pages.

  banks $11-$12  call_02_722c_EntityGfxQueue_StartNextTransfer
                 The preloaded scenery. .data_02_726c_EntityGfxDescriptors holds 58
                 explicit (bank, source, dest, size) jobs, so the boundaries are
                 written down rather than inferred.

So: work out which pages each referencing group owns, cut on the boundaries where
ownership changes, and name the file after the owner. Runs that nothing references
become image_unused_* so the partition still covers the bank byte for byte and the
ROM still rebuilds.

TILE ORDER. Every sprite here is 8x16 (LCDC $C7) and every layout in
bank03_oam_build.asm numbers tiles +2 down a column and +4 across, i.e. the pages are
stored column by column - which is why the Makefile passes --columns for
entity_sprites. A 32-pixel-tall shape is therefore a 4-row column-major image and a
16-pixel-tall one (the row_* shapes reached through .data_03_608e_FixedSpriteShapeTable,
which step +2 across) is a 2-row one. The height is read back out of the shape blocks
rather than guessed.

Usage:
    python3 tools/extract_entity_sprites.py              # write PNGs + main.asm snippet
    python3 tools/extract_entity_sprites.py --verify     # also check png -> bin -> rom
    python3 tools/extract_entity_sprites.py --dry-run    # print the plan, touch nothing

Run it from the repository root (or anywhere - paths are resolved from this file).
Needs rgbgfx on PATH, the same one the Makefile uses.
"""

import argparse
import os
import re
import struct
import subprocess
import sys
from collections import defaultdict

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)

ROM_PATH = os.path.join(ROOT, "rom.gb")
CONSTANTS_PATH = os.path.join(ROOT, "src", "constants", "constants.asm")
OUT_ROOT = os.path.join(ROOT, "src", "gfx", "entity_sprites")
SNIPPET_PATH = os.path.join(OUT_ROOT, "main_asm_snippet.inc")

BANK_SIZE = 0x4000
ROMX_BASE = 0x4000
PAGE_SIZE = 0x100          # GFX_PAGE_SIZE - one frame of 16 tiles
TILE_SIZE = 0x10

# --- ROM addresses, all named after the labels in the disassembly -------------

BANK_ENTITY_CODE = 0x02
BANK_OAM_CODE = 0x03

ADDR_ENTITY_ACTION_TABLE_PTRS = 0x4000     # 0x90 pointers, one per entity id
ADDR_ENTITY_ACTIONS_GEX = 0x4120           # data_02_4120_EntityActions_Gex
NUM_ENTITIES = 0x90
NUM_PLAYER_ACTIONS = 0x20

ADDR_ENTITY_GFX_BANK_TABLE = 0x7061        # .data_02_7061_EntityGfxBankTable
ADDR_ENTITY_GFX_DESCRIPTORS = 0x726C       # .data_02_726c_EntityGfxDescriptors
NUM_GFX_DESCRIPTORS = 58
ADDR_ENTITY_GFX_AND_PALETTE = 0x743C       # data_02_743c_EntityGfxAndPaletteTable

ADDR_ENTITY_SPRITE_DESCRIPTORS = 0x5446    # data_03_5446_EntitySpriteDescriptors
ADDR_FIXED_SPRITE_SHAPE_TABLE = 0x608E     # .data_03_608e_FixedSpriteShapeTable
# data_03_5566_SpriteShapeTable_Main ($5566) and data_03_5a8a_SpriteShapeTable_Alt
# ($5a8a) are the other reading of the same descriptor byte - see fixed_shape_rows.

MAX_LABEL = 48                             # keep Windows paths comfortably short

BANK_PLAYER_GFX_BASE = 0x04
GFX_PAGE_INDEX_MASK = 0x3F

# PLAYER_ACTION_CLIMB does not animate through its animation block - data_02_766d
# sets the frame timer to $FF, so the ticker never runs and every one of
# call_02_44af_PlayerAction_Climb's sub-states writes wD208_Player_SpriteID itself.
# The frames it reaches are therefore invisible to the action tables, and half of
# them (all of bank $05, plus $97-$9E and $C2-$D0) look unreferenced without this.
#
#   short label            the table, for the comment                            addr  n  stride  +off  span
PLAYER_CLIMB_SPRITE_TABLES = (
    ("climb_background",   ".data_02_454f_BackgroundClimbSpriteBaseByDirection", 0x454F, 8, 1, 0, 8),
    ("climb_wall",         ".data_02_461e_WallClimbSpriteBaseByDirection",       0x461E, 8, 1, 0, 8),
    ("climb_wall_spin",    ".data_02_465f_WallTailSpinSpriteBaseByDirection",    0x465F, 8, 1, 0, 8),
    ("climb_background_drop", ".data_02_4689_BackgroundDismountSprites",         0x4689, 6, 1, 0, 1),
    ("climb_wall_drop",    ".data_02_46b1_WallDismountSprites",                  0x46B1, 2, 1, 0, 1),
    ("climb_corner",       ".data_02_472e_ClimbStopSprites",                     0x472E, 9, 1, 0, 1),
    ("climb_corner_exit",  ".data_02_4757_ClimbStopExitState byte +3",           0x4757, 8, 4, 3, 1),
)

# .jp_02_455f_PlayerClimbAction_BackgroundTailSpin adds its base as an immediate
# rather than reading a table, so it comes from constants.asm instead.
PLAYER_CLIMB_SPRITE_CONSTANTS = (
    ("climb_background_spin", "CLIMB_TAIL_SPIN_SPRITE_BASE", 8),
)

# A $00 in those tables is filler, not frame $00: the unreachable rows of
# .data_02_465f and the four unfinished rows of .data_02_4757 are zeroed, and
# crediting the climb with frame $00 would only smear it across Gex's walk cycle.
CLIMB_FILLER_ID = 0x00

# How far real data extends in each bank. Past this the bank is padding that rgblink
# supplies, and main.asm INCBINs nothing - matching the sections as they stand today.
BANK_DATA_END = {
    0x04: 0x8000, 0x05: 0x8000, 0x06: 0x8000, 0x07: 0x6000,
    0x11: 0x6000, 0x12: 0x8000,
    0x18: 0x8000, 0x19: 0x8000, 0x1A: 0x8000, 0x1B: 0x8000, 0x1C: 0x8000,
}

STREAMING_BANKS = (0x18, 0x19, 0x1A, 0x1B, 0x1C)
PLAYER_BANKS = (0x04, 0x05, 0x06, 0x07)
QUEUED_BANKS = (0x11, 0x12)


# =============================================================================
# ROM access
# =============================================================================

class Rom:
    def __init__(self, path):
        with open(path, "rb") as f:
            self.data = f.read()
        if len(self.data) < 0x40 * BANK_SIZE:
            raise SystemExit(f"{path}: too small to be the 1 MiB ROM")

    def read(self, bank, addr, n=1):
        off = bank * BANK_SIZE + (addr - ROMX_BASE if addr >= ROMX_BASE else addr)
        return self.data[off:off + n]

    def byte(self, bank, addr):
        return self.read(bank, addr, 1)[0]

    def word(self, bank, addr):
        return struct.unpack("<H", self.read(bank, addr, 2))[0]


# =============================================================================
# Names, pulled out of constants.asm so this file never goes stale
# =============================================================================

def load_names(path):
    try:
        with open(path, "r", encoding="utf-8", errors="replace") as f:
            text = f.read()
    except OSError:
        return {}, {}

    entities, actions, defs = {}, {}, {}
    pattern = re.compile(r"^DEF\s+([A-Z0-9_]+)\s+EQU\s+\$([0-9A-Fa-f]+)", re.MULTILINE)
    for name, value in pattern.findall(text):
        value = int(value, 16)
        defs.setdefault(name, value)
        if name.startswith("ENTITY_"):
            entities.setdefault(value, name)
        elif (name.startswith("PLAYER_ACTION_") and name != "PLAYER_ACTION_MASK"
              and value < NUM_PLAYER_ACTIONS):
            actions.setdefault(value, name)
    return entities, actions, defs


def slug(name, strip_prefix):
    if name.startswith(strip_prefix):
        name = name[len(strip_prefix):]
    return name.lower().strip("_") or "unnamed"


def label_and_note(owners, generic):
    """A short file label plus the full list for the comment above the INCBIN.

    `owners` is an iterable of (sort key, short label, full name). Sharing is
    common - three remotes on one page range, seven Channel Z projectiles on one
    descriptor - so the label names the first owner or two and counts the rest
    rather than growing a 90-character filename.
    """
    owners = sorted(set(owners))
    if not owners:
        return "unused", generic
    for shown in (2, 1):
        label = "_".join(o[1] for o in owners[:shown])
        if len(owners) > shown:
            label += f"_and_{len(owners) - shown}_more"
        if len(label) <= MAX_LABEL:
            break
    return label, ", ".join(o[2] for o in owners)


def entity_owners(ids, names):
    return [(i, slug(names.get(i, f"entity_{i:02x}"), "ENTITY_"),
             names.get(i, f"entity ${i:02x}")) for i in ids]


# =============================================================================
# Action tables -> the frame ids each action names
# =============================================================================

def read_action_tables(rom):
    """entity id -> list of (action index, [frame ids]).

    The pointer table at $02:$4000 holds one address per entity id and the tables
    run back to back, so a table ends where the next lowest one starts. Gex's is
    the exception - it sits directly behind the pointer table at $4120, ahead of
    every other one - so a second bound is needed anyway: a row is only a row while
    its second word points at a real animation block, which is how the walk stops
    at the end of the last entity's table too.
    """
    ptrs = [rom.word(BANK_ENTITY_CODE, ADDR_ENTITY_ACTION_TABLE_PTRS + 2 * i)
            for i in range(NUM_ENTITIES)]
    if ptrs[0] != ADDR_ENTITY_ACTIONS_GEX:
        raise SystemExit(f"entity $00's action table is at ${ptrs[0]:04x}, not "
                         f"${ADDR_ENTITY_ACTIONS_GEX:04x} - is this the right ROM?")
    starts = sorted(set(ptrs[1:]))
    tables_end = starts[-1] + 4

    def next_start(ptr):
        later = [s for s in starts if s > ptr]
        return later[0] if later else 0x8000

    tables = {}
    for i, ptr in enumerate(ptrs):
        end = next_start(ptr)
        rows, addr, action = [], ptr, 0
        while addr + 4 <= end and action < NUM_PLAYER_ACTIONS:
            _func, data = struct.unpack("<HH", rom.read(BANK_ENTITY_CODE, addr, 4))
            frames = read_animation_block(rom, data, tables_end)
            if frames is None:
                break
            rows.append((action, frames))
            addr += 4
            action += 1
        tables[i] = rows
    return tables


def read_animation_block(rom, addr, tables_end):
    """The frame id list of one animation block, or None if `addr` is not one.

    A block is a 4-byte header - hand-over flags, sprite flags, ticks per frame,
    frame count - followed by that many frame ids. Blocks live above every action
    table, so an address below `tables_end` is a sign the walk has run off the end
    of a table rather than found another row.
    """
    if not (tables_end <= addr < 0x8000):
        return None
    header = rom.read(BANK_ENTITY_CODE, addr, 4)
    count = header[3]
    if count == 0 or count > NUM_PLAYER_ACTIONS:
        return None
    return list(rom.read(BANK_ENTITY_CODE, addr + 4, count))


# =============================================================================
# Sprite shapes -> how many tile rows a page is stored as
# =============================================================================

def shape_rows(rom, ptr):
    """2 or 4, read off a layout block.

    A layout is a part count then that many (dY, dX, tile, attr) records, and the
    parts are 8x16. One row of parts is two tile rows; two rows of parts (dY $F0
    and $00) is four. That distinction is exactly the difference between the box_*
    shapes, whose tile numbers step +4 across, and the row_* shapes, which step +2.
    """
    if not (ROMX_BASE <= ptr < 0x8000):
        return None
    count = rom.byte(BANK_OAM_CODE, ptr)
    if count == 0 or count > 16:
        return None
    ys = {rom.read(BANK_OAM_CODE, ptr + 1 + 4 * k, 4)[0] for k in range(count)}
    return 2 * len(ys)


def fixed_shape_rows(rom):
    """entity id -> tile rows per page for the SPRITE_FLAG_FIXED_SHAPE path.

    Byte +0 of data_03_5446_EntitySpriteDescriptors means one of two things
    depending on which builder reads it. Only .jp_03_602e_Entity_BuildSprites_FixedShape
    consumes the tiles that .data_02_726c_EntityGfxDescriptors preloads, so for banks
    $11-$12 the row is an index into .data_03_608e_FixedSpriteShapeTable and nothing
    else. (The streamed enemies of banks $18-$1C read the other table, whose columns
    are all four tiles tall - see split_streamed.)
    """
    rows = {}
    for entity in range(NUM_ENTITIES):
        index = rom.byte(BANK_OAM_CODE, ADDR_ENTITY_SPRITE_DESCRIPTORS + 2 * entity)
        ptr = rom.word(BANK_OAM_CODE, ADDR_FIXED_SPRITE_SHAPE_TABLE + 2 * index)
        rows[entity] = shape_rows(rom, ptr)
    return rows


# =============================================================================
# The three splits
# =============================================================================

class Chunk:
    """One output file: a byte range of one bank plus how to draw it."""

    def __init__(self, bank, start, end, name, rows, note=""):
        self.bank = bank
        self.start = start          # absolute ROMX address
        self.end = end
        self.name = name
        self.rows = rows            # tile rows in the PNG
        self.note = note

    @property
    def size(self):
        return self.end - self.start

    @property
    def tiles(self):
        return self.size // TILE_SIZE

    @property
    def columns(self):
        return self.tiles // self.rows

    @property
    def stem(self):
        return f"image_{self.name}_{self.bank:03x}_{self.start:04x}"

    def data(self, rom):
        return rom.read(self.bank, self.start, self.size)

    def __repr__(self):
        return (f"<{self.bank:02x}:{self.start:04x}-{self.end:04x} {self.stem} "
                f"{self.columns}x{self.rows} tiles>")


def runs_by_owner(owner_of_page, first_page, last_page):
    """Collapse a page->owners map into maximal runs that share the same owner set."""
    out, run = [], None
    for page in range(first_page, last_page + 1):
        owners = frozenset(owner_of_page.get(page, ()))
        if run is not None and run[2] == owners:
            run[1] = page
        else:
            run = [page, page, owners]
            out.append(run)
    return out


def climb_sprite_owners(rom, defs, action_names):
    """page -> owners, for the frames PLAYER_ACTION_CLIMB writes to wD208 by hand.

    Each source contributes either a single frame id or a base plus the eight-frame
    loop the climb counter walks - `counter >> 2 & 7` added to the base, so a base of
    $40 owns $40 to $47.
    """
    climb = next((a for a, n in action_names.items() if n == "PLAYER_ACTION_CLIMB"), 0x1D)
    owners = defaultdict(set)

    sources = [(label, note, [rom.byte(BANK_ENTITY_CODE, addr + stride * i + off)
                              for i in range(count)], span)
               for label, note, addr, count, stride, off, span in PLAYER_CLIMB_SPRITE_TABLES]
    for label, const, span in PLAYER_CLIMB_SPRITE_CONSTANTS:
        if const in defs:
            sources.append((label, f"{const} (${defs[const]:02x})", [defs[const]], span))

    for order, (label, note, bases, span) in enumerate(sources):
        owner = ((climb, order + 1), label,
                 f"{action_names.get(climb, 'PLAYER_ACTION_CLIMB')} via {note}")
        for base in bases:
            if base == CLIMB_FILLER_ID:
                continue
            for step in range(span):
                owners[(base + step) & 0xFF].add(owner)
    return owners


def split_player(rom, tables, action_names, defs):
    """Banks $04-$07, cut on the frame lists of data_02_4120_EntityActions_Gex,
    plus the ids PLAYER_ACTION_CLIMB writes for itself."""
    owners = defaultdict(set)
    for action, frames in tables[0]:
        owner = ((action, 0), slug(action_names.get(action, f"action_{action:02x}"),
                                   "PLAYER_ACTION_"),
                 action_names.get(action, f"player action ${action:02x}"))
        for frame in frames:
            owners[frame].add(owner)
    for page, extra in climb_sprite_owners(rom, defs, action_names).items():
        # data_02_766d, the climb action's animation block, holds one frame at a
        # timer of $FF - a seed, not an animation. Where a climb table also claims
        # the page, the table is the real owner and naming both would only give us
        # image_player_climb_climb_background_*.
        owners[page] = {o for o in owners[page] if o[1] != "climb"} | extra

    chunks = []
    for start, end, actions in runs_by_owner(owners, 0x00, 0xFF):
        label, note = label_and_note(actions, "no player action names these frames")

        # A run of frame ids can cross a bank boundary - the low six bits of the id
        # are the page and the top two the bank - so cut it at every multiple of $40.
        page = start
        while page <= end:
            bank = BANK_PLAYER_GFX_BASE + (page >> 6)
            last = min(end, (page | GFX_PAGE_INDEX_MASK))
            addr = ROMX_BASE + (page & GFX_PAGE_INDEX_MASK) * PAGE_SIZE
            stop = min(ROMX_BASE + ((last & GFX_PAGE_INDEX_MASK) + 1) * PAGE_SIZE,
                       BANK_DATA_END.get(bank, 0x8000))
            if stop > addr:
                # Gex is always the 32x32 rectangle of
                # .data_03_5d6f_PlayerSpriteShapeTable - four columns of four tiles.
                chunks.append(Chunk(bank, addr, stop, f"player_{label}", 4, note))
            page = last + 1
    return chunks


def split_streamed(rom, tables, entity_names):
    """Banks $18-$1C, cut on .data_02_7061_EntityGfxBankTable plus the frame lists."""
    bank_of_entity = list(rom.read(BANK_ENTITY_CODE, ADDR_ENTITY_GFX_BANK_TABLE, NUM_ENTITIES))

    per_bank = defaultdict(lambda: defaultdict(set))
    for entity in range(1, NUM_ENTITIES):
        bank = bank_of_entity[entity]
        if bank not in STREAMING_BANKS:
            continue
        for _action, frames in tables.get(entity, []):
            for frame in frames:
                if 0x40 <= frame <= 0x7F:
                    per_bank[bank][frame].add(entity)

    chunks = []
    for bank in STREAMING_BANKS:
        owners = per_bank.get(bank, {})
        for start, end, entities in runs_by_owner(owners, 0x40, 0x7F):
            addr = start * PAGE_SIZE
            stop = (end + 1) * PAGE_SIZE
            if addr >= BANK_DATA_END.get(bank, 0x8000):
                continue
            stop = min(stop, BANK_DATA_END.get(bank, 0x8000))
            if stop <= addr:
                continue

            label, note = label_and_note(entity_owners(sorted(entities), entity_names),
                                         "no entity streams these pages")
            # Streamed enemies are drawn from data_03_5566_SpriteShapeTable_Main,
            # every one of whose columns is 4 tiles tall - so a page is always
            # 4 columns by 4 rows, one 32x32 frame, whatever the shape crops to.
            chunks.append(Chunk(bank, addr, stop, label, 4, note))
    return chunks


def split_queued(rom, entity_names, rows_by_entity):
    """Banks $11-$12, cut on .data_02_726c_EntityGfxDescriptors."""
    gfx_id_of_entity = {}
    for entity in range(NUM_ENTITIES):
        gfx_id = rom.byte(BANK_ENTITY_CODE, ADDR_ENTITY_GFX_AND_PALETTE + 2 * entity)
        if gfx_id:
            gfx_id_of_entity[entity] = gfx_id

    users = defaultdict(list)
    for entity, gfx_id in gfx_id_of_entity.items():
        users[gfx_id].append(entity)

    # Descriptors can name the same source twice (id $2C and $38 both load
    # $11:$4800), so key by byte range and merge the names.
    ranges = {}
    for gfx_id in range(NUM_GFX_DESCRIPTORS):
        rec = rom.read(BANK_ENTITY_CODE, ADDR_ENTITY_GFX_DESCRIPTORS + 8 * gfx_id, 8)
        bank = rec[0]
        src = rec[1] | (rec[2] << 8)
        size = rec[5] | (rec[6] << 8)
        if bank == 0 or size == 0:
            continue                                  # id $00, the no-graphics sentinel
        ranges.setdefault((bank, src, size), []).append(gfx_id)

    chunks = []
    for (bank, src, size), gfx_ids in sorted(ranges.items()):
        entities = sorted(e for g in gfx_ids for e in users.get(g, []))
        label, note = label_and_note(entity_owners(entities, entity_names),
                                     "no entity selects this graphics id")
        label = "gfx_%s_%s" % ("_".join(f"{g:02x}" for g in sorted(gfx_ids)), label)

        # Every user of one descriptor draws it through the same shape height in
        # practice; if they ever disagreed the taller reading is the safe one,
        # since a 4-row sheet still contains a 2-row entity's tiles in order.
        candidates = {rows_by_entity.get(e) for e in entities} - {None}
        rows = 2 if candidates == {2} else 4
        if len(candidates) > 1:
            note += f"  (shapes disagree on height: {sorted(candidates)}, using {rows})"
        chunks.append(Chunk(bank, src, src + size, label, rows, note))

    chunks += fill_gaps(chunks, QUEUED_BANKS)
    return chunks


def fill_gaps(chunks, banks):
    """Explicit image_unused_* chunks for whatever the real ones do not cover."""
    out = []
    for bank in banks:
        end = BANK_DATA_END.get(bank, 0x8000)
        covered = sorted((c.start, c.end) for c in chunks if c.bank == bank)
        cursor = ROMX_BASE
        for start, stop in covered:
            if start > cursor:
                out.append(Chunk(bank, cursor, start, "unused",
                                 4, "not named by any descriptor"))
            cursor = max(cursor, stop)
        if cursor < end:
            out.append(Chunk(bank, cursor, end, "unused", 4,
                             "not named by any descriptor"))
    return out


# =============================================================================
# Output
# =============================================================================

def check_partition(chunks, banks):
    """Every byte of every bank up to BANK_DATA_END must be covered exactly once."""
    problems = []
    for bank in banks:
        end = BANK_DATA_END.get(bank, 0x8000)
        mine = sorted((c.start, c.end, c.stem) for c in chunks if c.bank == bank)
        cursor = ROMX_BASE
        for start, stop, stem in mine:
            if start < cursor:
                problems.append(f"bank ${bank:02x}: {stem} overlaps ${cursor:04x}")
            elif start > cursor:
                problems.append(f"bank ${bank:02x}: gap ${cursor:04x}-${start:04x}")
            cursor = max(cursor, stop)
        if cursor != end:
            problems.append(f"bank ${bank:02x}: covered to ${cursor:04x}, expected ${end:04x}")
    return problems


def check_reassembly(rom, chunks, banks):
    """Concatenating a bank's chunks in address order must give the bank back."""
    problems = []
    for bank in banks:
        mine = sorted((c for c in chunks if c.bank == bank), key=lambda c: c.start)
        blob = b"".join(c.data(rom) for c in mine)
        end = BANK_DATA_END.get(bank, 0x8000)
        if blob != rom.read(bank, ROMX_BASE, end - ROMX_BASE):
            problems.append(f"bank ${bank:02x}: the chunks do not reassemble into the bank")
    return problems


def check_geometry(chunks):
    problems = []
    for c in chunks:
        if c.size % TILE_SIZE:
            problems.append(f"{c.stem}: ${c.size:04x} bytes is not a whole number of tiles")
        elif c.tiles % c.rows:
            problems.append(f"{c.stem}: {c.tiles} tiles does not divide into {c.rows} rows")
    return problems


def run_rgbgfx(args):
    try:
        subprocess.run(["rgbgfx"] + args, check=True,
                       stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    except FileNotFoundError:
        raise SystemExit("rgbgfx not found on PATH - it is the same one the Makefile uses")
    except subprocess.CalledProcessError as exc:
        raise SystemExit(f"rgbgfx {' '.join(args)} failed:\n{exc.stderr.decode(errors='replace')}")


GROUP_DIR = {"player": "player", "streamed": "streamed", "queued": "queued"}

# What extract_sprites_vertical() used to leave in src/gfx/entity_sprites: one PNG
# per $2000 slab, image_<bank>_<addr>.png. entity_palettes.bin and anything else in
# there is left alone.
OLD_SHEET = re.compile(
    r"^image_(%s)_[0-9a-fA-F]{4}\.png$"
    % "|".join(f"{b:03x}" for b in PLAYER_BANKS + QUEUED_BANKS + STREAMING_BANKS),
    re.IGNORECASE)


def superseded_pngs():
    try:
        entries = sorted(os.listdir(OUT_ROOT))
    except OSError:
        return []
    return [os.path.join(OUT_ROOT, n) for n in entries if OLD_SHEET.match(n)]


def write_chunks(rom, groups, verify):
    written = []
    for group, chunks in groups.items():
        outdir = os.path.join(OUT_ROOT, GROUP_DIR[group])
        os.makedirs(outdir, exist_ok=True)
        for c in chunks:
            raw = c.data(rom)
            binpath = os.path.join(outdir, c.stem + ".bin")
            pngpath = os.path.join(outdir, c.stem + ".png")
            with open(binpath, "wb") as f:
                f.write(raw)
            run_rgbgfx(["--reverse", str(c.columns), "--columns", "-o", binpath, pngpath])
            os.remove(binpath)

            if verify:
                check = pngpath + ".check.bin"
                run_rgbgfx(["--columns", "-o", check, pngpath])
                with open(check, "rb") as f:
                    got = f.read()
                os.remove(check)
                if got != raw:
                    raise SystemExit(f"{c.stem}: png -> bin does not reproduce the ROM bytes "
                                     f"({len(got)} vs {len(raw)} bytes)")
            written.append((group, c, os.path.relpath(pngpath, ROOT)))
    return written


def write_snippet(groups):
    by_bank = defaultdict(list)
    for group, chunks in groups.items():
        for c in chunks:
            by_bank[c.bank].append((c, group))

    lines = [
        "; Generated by tools/extract_entity_sprites.py - paste over the matching",
        "; SECTION blocks in src/main.asm. The .bin files come from src/gfx via the",
        "; Makefile's png -> bin rule, which already passes --columns for entity_sprites.",
        "",
    ]
    for bank in sorted(by_bank):
        lines.append(f'SECTION "bank{bank:02x}", ROMX[$4000], BANK[${bank:02x}]')
        for c, group in sorted(by_bank[bank], key=lambda t: t[0].start):
            if c.note:
                lines.append(f"    ; ${c.start:04x}  {c.columns}x{c.rows} tiles - {c.note}")
            lines.append(f'    INCBIN ".gfx/entity_sprites/{GROUP_DIR[group]}/{c.stem}.bin"')
        lines.append("")

    os.makedirs(OUT_ROOT, exist_ok=True)
    with open(SNIPPET_PATH, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))
    return SNIPPET_PATH


# =============================================================================

def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--rom", default=ROM_PATH)
    ap.add_argument("--dry-run", action="store_true",
                    help="print the split and write nothing")
    ap.add_argument("--verify", action="store_true",
                    help="re-encode each PNG and check it reproduces the ROM bytes")
    ap.add_argument("--remove-old", action="store_true",
                    help="delete the old bank-sized image_0XX_XXXX.png sheets this replaces")
    args = ap.parse_args()

    rom = Rom(args.rom)
    entity_names, action_names, defs = load_names(CONSTANTS_PATH)
    tables = read_action_tables(rom)
    rows_by_entity = fixed_shape_rows(rom)

    groups = {
        "player": split_player(rom, tables, action_names, defs),
        "streamed": split_streamed(rom, tables, entity_names),
        "queued": split_queued(rom, entity_names, rows_by_entity),
    }

    problems = []
    for chunks, banks in ((groups["player"], PLAYER_BANKS),
                          (groups["streamed"], STREAMING_BANKS),
                          (groups["queued"], QUEUED_BANKS)):
        problems += check_partition(chunks, banks)
        problems += check_reassembly(rom, chunks, banks)
        problems += check_geometry(chunks)
    if problems:
        print("The split does not cover the banks cleanly:", file=sys.stderr)
        for p in problems:
            print("  " + p, file=sys.stderr)
        return 1

    total = sum(len(c) for c in groups.values())
    for group, chunks in groups.items():
        print(f"{group}: {len(chunks)} sheets")
        for c in sorted(chunks, key=lambda c: (c.bank, c.start)):
            print(f"  ${c.bank:02x}:${c.start:04x}-${c.end:04x}  "
                  f"{c.columns:3d}x{c.rows} tiles  {c.stem}"
                  + (f"   ; {c.note}" if c.note else ""))
    print(f"\n{total} sheets total")

    stale = superseded_pngs()
    if stale:
        print("\nsuperseded by this split:")
        for path in stale:
            print("  " + os.path.relpath(path, ROOT))
        print("  (pass --remove-old to delete them - the Makefile globs every png "
              "under src/gfx, so leaving them builds stale .bin files)")

    if args.dry_run:
        return 0

    write_chunks(rom, groups, args.verify)
    if args.remove_old:
        for path in stale:
            os.remove(path)
        print(f"removed {len(stale)} superseded png(s)")
    print("wrote " + os.path.relpath(write_snippet(groups), ROOT))
    return 0


if __name__ == "__main__":
    sys.exit(main())
