# BGB Trainer — Game Boy Memory Visualizer

A Python tool that hooks into the **BGB** Game Boy emulator, reads its
process memory in real time, and displays the data in a separate GUI window.

---

## Features

| Tab | What it shows |
|-----|---------------|
| **Collision Map** | Current 32×32 tile map drawn as a colour-coded grid. Walkable tiles (green), walls/trees (red), water (blue), tall grass (light green). Player position shown as a yellow diamond, NPCs as white dots. Updates at ~10 fps. |
| **Hex Viewer** | Live hex dump of any 64KB GB memory region (WRAM, VRAM, OAM, etc.). Changed bytes highlighted in red since last frame. |
| **Sprites / OAM** | All 40 OAM entries listed with Y, X, tile ID, flags, on-screen status, and flip bits. |
| **Player Info** | Gex specific: coordinates, facing, map ID, HP, etc. |

---

## Requirements

- Python 3.9+
- Windows (BGB is Windows-only). On other OSes the trainer runs in **simulation mode** with animated demo data.
- BGB emulator: https://bgb.bircd.org/

```
pip install -r requirements.txt
```

On Windows, `pywin32` is installed automatically.  
On Linux/macOS, `tkinter` must be installed (`sudo apt install python3-tk`).

---

## Running

```bash
python main.py
```

1. Start BGB and load a ROM first.
2. Click **⟳ CONNECT** in the trainer. It will find BGB by process name and scan its memory for the GB memory block.
3. If BGB isn't running, the trainer falls back to simulation mode showing a generated map.

> **Run as Administrator** if the Connect button shows "Failed to open process".  
> Windows requires elevated privileges to call `ReadProcessMemory` on other processes.

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

Use BGB's built-in memory viewer (**Window → Tile viewer** / **VRAM viewer**)
alongside a debugger (`F2` to open BGB's debugger) to find these addresses.

---

## File structure

```
bgb_trainer/
├── main.py           Entry point
├── trainer_app.py    Main window, polling loop, tab coordination
├── bgb_memory.py     Windows process memory reader + simulation fallback
├── game_maps.py      Per-game memory address profiles
├── collision_view.py Tile map / collision grid canvas widget
├── hex_view.py       Scrollable hex dump with change highlighting
├── sprite_view.py    OAM sprite table (Treeview)
└── requirements.txt
```

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| "BGB process not found" | Start BGB and load a ROM before connecting |
| "Failed to open BGB process" | Run trainer as Administrator |
| "Could not locate GB memory" | Make sure a ROM is loaded in BGB (not just the emulator window) |
| Blank collision map | The ROM may not be in `game_maps.py` — check the Player Info tab for the detected title and add a profile |
| Wrong player position | Coordinates are game-specific — find them with BGB's memory viewer |
