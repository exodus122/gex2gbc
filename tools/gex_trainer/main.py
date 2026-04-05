"""
BGB Trainer - Game Boy memory visualizer
Reads memory from BGB emulator via Windows ReadProcessMemory API
"""
import sys
import tkinter as tk
from trainer_app import TrainerApp

if __name__ == "__main__":
    root = tk.Tk()
    app = TrainerApp(root)
    root.mainloop()
