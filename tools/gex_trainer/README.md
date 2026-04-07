# Gex Trainer — Game Boy Memory Visualizer

A Python tool that hooks into the **BGB** Game Boy emulator, reads its
process memory in real time, and displays the data in a separate GUI window.

---

## Features

| Tab | What it shows |
|-----|---------------|
| **Collision Map** | Current 32×32 tile map drawn as a colour-coded grid. Also diplays entity hitboxes and lists the currently loaded entitys in the sidebar. You can click an objec to view its properties. Updates at ~10 fps. |
| **Hex Viewer** | Live hex dump of any 64KB GB memory region (WRAM, VRAM, OAM, etc.). Changed bytes highlighted in red since last frame. |
| **Sprites / OAM** | All 40 OAM entries listed with Y, X, tile ID, flags, on-screen status, and flip bits. |
| **Watches** | User-defined memory watches with labels, addresses, and sizes. Supports grouping, value poking, and value freezing. |

---

## Requirements

- Python 3.9+
- Windows (BGB is Windows-only)
- BGB emulator: https://bgb.bircd.org/

```
pip install -r requirements.txt
```

---

## Running

```bash
python main.py
```

1. Start BGB and load a ROM first.
2. Follow the **Connecting** steps below to link the trainer to BGB.

> **Run as Administrator** if the Connect button shows "Failed to open process".  
> Windows requires elevated privileges to call `ReadProcessMemory` on other processes.

---

## Connecting to BGB

The trainer needs to locate BGB's internal Game Boy memory block before it
can read anything. The easiest way to do this is via the **📋 PASTE WRAM**
button:

1. In BGB, open the memory viewer: **Right Click → Debugger**.
2. Navigate to address **`C000`** — this is the start of WRAM.
3. Select and copy at least **60 bytes** starting from `C000` (copy them as hex).
4. In the trainer, click **📋 PASTE WRAM** and paste the copied bytes into the dialog.
5. Click **Connect**. The trainer will use those bytes to locate the correct
   memory region in BGB's process and begin reading live data.

---

## How it works

### Memory reading

BGB stores the full 64 KB Game Boy address space as a contiguous block in
its own virtual memory. The trainer:

1. Enumerates all running processes via `CreateToolhelp32Snapshot` to find `bgb.exe`.
2. Opens the process with `PROCESS_VM_READ | PROCESS_QUERY_INFORMATION`.
3. Scans the process's virtual memory regions using `VirtualQueryEx`, looking for a ≥64 KB committed readable region.
4. Identifies the GB memory block by checking for the Nintendo logo bytes at offset `0x0104` (mandatory in every valid Game Boy ROM).
5. All subsequent reads use `ReadProcessMemory(handle, gb_base + gb_addr, ...)`.

### Game detection

The ROM header at `0x0100–0x014F` contains a fixed title string at `0x0134`.
`game_maps.py` maps known title strings to memory address profiles so the
trainer knows where to find player coords, the tile map, NPC data, etc.

---

## Adding your own game

Edit `game_maps.py` and add an entry to `GAME_PROFILES`:

```python
"MY GAME TITLE": {
    "name": "My Game",
    "color": "#FF6600",
    "player_x": 0xC300,      # WRAM address of X coordinate byte
    "player_y": 0xC301,      # WRAM address of Y coordinate byte
    "map_data": 0xC400,      # WRAM address of tile map (row-major bytes)
    "map_width":  16,         # tiles per row
    "map_height": 14,         # rows
    "collision_fn": lambda tile: tile >= 0x40,  # which tile values are solid
},
```

Use BGB's built-in memory viewer (**Right Click → Debugger**) to find these addresses.

---

## File structure

```
bgb_trainer/
├── main.py           Entry point
├── trainer_app.py    Main window, polling loop, tab coordination
├── bgb_memory.py     Windows process memory reader
├── game_maps.py      Per-game memory address profiles
├── collision_view.py Tile map / collision grid canvas widget
├── hex_view.py       Scrollable hex dump with change highlighting
├── sprite_view.py    OAM sprite table (Treeview)
├── watches_view.py   User-defined memory watches
└── requirements.txt
```

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| "BGB process not found" | Start BGB and load a ROM before connecting |
| "Failed to open BGB process" | Run trainer as Administrator |
| "Could not locate GB memory" | Use **📋 PASTE WRAM** — copy 50 bytes from address `C000` in BGB's memory viewer and paste them into the dialog |
| Blank collision map | The ROM may not be in `game_maps.py` — check the detected title and add a profile |
| Wrong player position | Coordinates are game-specific — find them with BGB's memory viewer |
