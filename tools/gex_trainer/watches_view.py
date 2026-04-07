"""
watches_view.py - Free-form memory watch list with freeze, grouping, and persist support.

Saved as JSON: watches.json next to the script.
"""

import json
import os
import tkinter as tk
from tkinter import filedialog, messagebox, ttk

C_BG = "#0D1117"
C_PANEL = "#161B22"
C_BORDER = "#21262D"
C_GREEN = "#00FF88"
C_RED = "#FF4444"
C_YELLOW = "#FFD700"
C_TEXT = "#C9D1D9"
C_DIM = "#667788"
C_FROZEN = "#FF8800"
FONT = ("Courier New", 9)
FONT_B = ("Courier New", 9, "bold")

WATCHES_FILE = os.path.join(os.path.dirname(os.path.abspath(__file__)), "watches.json")


class WatchesView(tk.Frame):
    """
    Tab showing a live list of watched memory addresses.
    Caller must call poll(reader) every frame to update values and apply freezes.
    """

    def __init__(self, parent, **kw):
        super().__init__(parent, bg=C_BG, **kw)
        self._entries = []
        self._reader = None
        self._next_group_id = 1
        self._sort_key = None
        self._sort_reverse = False
        self._tree_to_entry = {}
        self._build_ui()
        self._load()

    def _build_ui(self):
        hdr = tk.Frame(self, bg=C_BG)
        hdr.pack(fill=tk.X, padx=8, pady=(8, 4))
        tk.Label(hdr, text="WATCHES", font=("Courier New", 11, "bold"),
                 fg=C_GREEN, bg=C_BG).pack(side=tk.LEFT)

        def btn(parent, text, cmd, **kw):
            return tk.Button(parent, text=text, command=cmd, font=FONT_B,
                             relief=tk.FLAT, padx=8, pady=3, cursor="hand2", **kw)

        btn(hdr, "+ ADD", self._add_dialog, bg="#1F3A1F", fg=C_GREEN).pack(side=tk.RIGHT, padx=(4, 0))
        btn(hdr, "+ GROUP", self._add_group_dialog, bg="#2D2A1A", fg=C_YELLOW).pack(side=tk.RIGHT, padx=(4, 0))
        btn(hdr, "SAVE", self._save, bg="#1A2A3A", fg="#58A6FF").pack(side=tk.RIGHT, padx=(4, 0))
        btn(hdr, "LOAD", self._load_dialog, bg="#1A2A3A", fg="#58A6FF").pack(side=tk.RIGHT, padx=(4, 0))

        cols = ("Address", "Size", "Value (hex)", "Value (dec)", "Frozen", "Freeze Val")
        self._tree = ttk.Treeview(self, columns=cols, show="tree headings", selectmode="browse")
        self._tree.heading("#0", text="Label", command=lambda: self._sort_by("label"))
        self._tree.column("#0", width=220, anchor="w", stretch=True)

        heading_keys = {
            "Address": "addr",
            "Size": "size",
            "Value (hex)": "value_hex",
            "Value (dec)": "value",
            "Frozen": "frozen",
            "Freeze Val": "freeze_val",
        }
        widths = [80, 55, 95, 95, 60, 85]
        for col, width in zip(cols, widths):
            self._tree.heading(col, text=col, command=lambda key=heading_keys[col]: self._sort_by(key))
            self._tree.column(col, width=width, anchor="center", stretch=False)

        vsb = ttk.Scrollbar(self, orient=tk.VERTICAL, command=self._tree.yview)
        self._tree.configure(yscrollcommand=vsb.set)
        vsb.pack(side=tk.RIGHT, fill=tk.Y, padx=(0, 8), pady=(0, 8))
        self._tree.pack(fill=tk.BOTH, expand=True, padx=(8, 0), pady=(0, 8))

        style = ttk.Style()
        style.configure("Treeview",
                        background=C_BG, foreground=C_TEXT,
                        fieldbackground=C_BG, font=FONT, rowheight=20)
        style.configure("Treeview.Heading",
                        background=C_PANEL, foreground=C_GREEN,
                        font=FONT_B)
        self._tree.tag_configure("frozen", foreground=C_FROZEN)
        self._tree.tag_configure("normal", foreground=C_TEXT)
        self._tree.tag_configure("group", foreground=C_YELLOW, font=FONT_B)

        self._tree.bind("<Double-1>", self._on_double_click)
        self._tree.bind("<Button-3>", self._on_right_click)
        self._tree.bind("<Delete>", self._on_delete_key)
        self._tree.bind("<<TreeviewOpen>>", self._on_tree_open)
        self._tree.bind("<<TreeviewClose>>", self._on_tree_close)

        self._menu = tk.Menu(self.root_window(), tearoff=0, bg=C_PANEL, fg=C_TEXT,
                             activebackground="#1F6FEB", activeforeground="white",
                             font=FONT)

    def root_window(self):
        w = self
        while w.master:
            w = w.master
        return w

    def poll(self, reader):
        if not reader or not reader.connected:
            return
        self._reader = reader
        for entry in self._entries:
            if entry["type"] != "watch":
                continue
            addr = entry["addr"]
            size = entry["size"]
            if entry["frozen"]:
                val = entry["freeze_val"]
                if size == 1:
                    reader.write_byte(addr, val)
                else:
                    reader.write_word(addr, val)
                entry["value"] = val
            else:
                if size == 1:
                    value = reader.read_byte(addr)
                else:
                    value = reader.read_word(addr)
                entry["value"] = value if value is not None else 0
        self._refresh_tree()

    def _refresh_tree(self):
        selected_key = self._selected_entry_key()
        open_group_ids = {entry["id"] for entry in self._entries
                          if entry["type"] == "group" and not entry.get("collapsed", False)}

        self._tree_to_entry = {}
        self._tree.delete(*self._tree.get_children())

        groups_by_id = {entry["id"]: entry for entry in self._entries if entry["type"] == "group"}
        children_by_group = {}
        root_entries = []
        for index, entry in enumerate(self._entries):
            if entry["type"] == "watch" and entry.get("group_id"):
                children_by_group.setdefault(entry["group_id"], []).append((index, entry))
            else:
                root_entries.append((index, entry))

        for index, entry in self._sorted_pairs(root_entries):
            if entry["type"] == "group":
                iid = self._tree_id(entry)
                self._tree_to_entry[iid] = index
                self._tree.insert(
                    "", tk.END, iid=iid, text=entry["label"], open=entry["id"] in open_group_ids,
                    tags=("group",), values=("", "", "", "", "", "")
                )
                for child_index, child in self._sorted_pairs(children_by_group.get(entry["id"], [])):
                    self._insert_watch(iid, child_index, child)
            else:
                self._insert_watch("", index, entry)

        if selected_key:
            iid = self._entry_key_to_tree_id(selected_key)
            if iid in self._tree.get_children("") or self._tree.exists(iid):
                self._tree.selection_set(iid)

    def _insert_watch(self, parent_iid, index, watch):
        iid = self._tree_id(watch, index)
        self._tree_to_entry[iid] = index
        val = watch.get("value", 0) or 0
        size = watch["size"]
        hex_str = f"0x{val:02X}" if size == 1 else f"0x{val:04X}"
        freeze_val = watch.get("freeze_val", 0) or 0
        freeze_str = f"0x{freeze_val:02X}" if size == 1 else f"0x{freeze_val:04X}"
        tag = "frozen" if watch["frozen"] else "normal"
        self._tree.insert(
            parent_iid, tk.END, iid=iid, text=watch["label"], tags=(tag,),
            values=(
                f"0x{watch['addr']:04X}",
                "byte" if size == 1 else "word",
                hex_str,
                str(val),
                "Y" if watch["frozen"] else "",
                freeze_str if watch["frozen"] else "",
            ),
        )

    def _sorted_pairs(self, pairs):
        if not self._sort_key:
            return pairs
        return sorted(pairs, key=lambda pair: self._sort_value(pair[1], self._sort_key), reverse=self._sort_reverse)

    def _sort_by(self, key):
        if self._sort_key == key:
            self._sort_reverse = not self._sort_reverse
        else:
            self._sort_key = key
            self._sort_reverse = False
        self._refresh_tree()

    def _sort_value(self, entry, key):
        if entry["type"] == "group":
            if key == "label":
                return (0, entry["label"].lower())
            return (0, 0)
        if key == "label":
            return (1, entry["label"].lower())
        if key == "addr":
            return (1, entry["addr"])
        if key == "size":
            return (1, entry["size"])
        if key == "value":
            return (1, entry.get("value", 0) or 0)
        if key == "value_hex":
            return (1, entry.get("value", 0) or 0)
        if key == "frozen":
            return (1, 1 if entry["frozen"] else 0)
        if key == "freeze_val":
            return (1, entry.get("freeze_val", 0) or 0)
        return (1, 0)

    def _tree_id(self, entry, index=None):
        if entry["type"] == "group":
            return f"group:{entry['id']}"
        return f"watch:{index}"

    def _entry_key_to_tree_id(self, key):
        kind, value = key
        return f"group:{value}" if kind == "group" else f"watch:{value}"

    def _selected_entry_key(self):
        iid = self._selected_tree_iid()
        if not iid:
            return None
        if iid.startswith("group:"):
            return ("group", iid.split(":", 1)[1])
        if iid.startswith("watch:"):
            return ("watch", int(iid.split(":", 1)[1]))
        return None

    def _selected_tree_iid(self):
        sel = self._tree.selection()
        return sel[0] if sel else None

    def _selected_index(self):
        iid = self._selected_tree_iid()
        return self._tree_to_entry.get(iid)

    def _selected_entry(self):
        index = self._selected_index()
        if index is None:
            return None
        return self._entries[index]

    def _watch_groups(self):
        return [entry for entry in self._entries if entry["type"] == "group"]

    def _group_choices(self):
        choices = ["(none)"]
        choices.extend(group["label"] for group in self._watch_groups())
        return choices

    def _group_id_for_label(self, label):
        for group in self._watch_groups():
            if group["label"] == label:
                return group["id"]
        return None

    def _add_dialog(self, prefill=None, edit_idx=None, default_group_id=None):
        dlg = tk.Toplevel(self.root_window())
        dlg.title("Edit Watch" if edit_idx is not None else "Add Watch")
        dlg.configure(bg=C_BG)
        dlg.geometry("360x300")
        dlg.resizable(False, False)
        dlg.transient(self.root_window())
        dlg.grab_set()

        def row(row_index, label, widget):
            tk.Label(dlg, text=label, font=FONT, fg=C_DIM, bg=C_BG,
                     anchor="e", width=12).grid(row=row_index, column=0, padx=(12, 4), pady=6, sticky="e")
            widget.grid(row=row_index, column=1, padx=(0, 12), pady=6, sticky="ew")

        dlg.columnconfigure(1, weight=1)

        e_label = tk.Entry(dlg, font=FONT, bg=C_PANEL, fg=C_TEXT,
                           insertbackground=C_TEXT, relief=tk.FLAT, bd=4)
        e_addr = tk.Entry(dlg, font=FONT, bg=C_PANEL, fg=C_TEXT,
                          insertbackground=C_TEXT, relief=tk.FLAT, bd=4)
        size_var = tk.StringVar(value="byte")
        e_size = ttk.Combobox(dlg, textvariable=size_var, values=["byte", "word"],
                              font=FONT, state="readonly", width=8)
        group_var = tk.StringVar(value="(none)")
        e_group = ttk.Combobox(dlg, textvariable=group_var, values=self._group_choices(),
                               font=FONT, state="readonly")
        frozen_var = tk.BooleanVar(value=False)
        e_frozen = tk.Checkbutton(dlg, variable=frozen_var, text="Freeze",
                                  font=FONT, fg=C_TEXT, bg=C_BG,
                                  selectcolor=C_BG, activebackground=C_BG)
        e_freeze_val = tk.Entry(dlg, font=FONT, bg=C_PANEL, fg=C_TEXT,
                                insertbackground=C_TEXT, relief=tk.FLAT, bd=4)

        row(0, "Label:", e_label)
        row(1, "Address:", e_addr)
        row(2, "Size:", e_size)
        row(3, "Group:", e_group)
        row(4, "", e_frozen)
        row(5, "Freeze val:", e_freeze_val)

        group_id = default_group_id
        if prefill:
            group_id = prefill.get("group_id")
            e_label.insert(0, prefill.get("label", ""))
            e_addr.insert(0, f"0x{prefill['addr']:04X}")
            size_var.set("byte" if prefill["size"] == 1 else "word")
            frozen_var.set(prefill.get("frozen", False))
            freeze_val = prefill.get("freeze_val", 0)
            e_freeze_val.insert(0, f"0x{freeze_val:02X}" if prefill["size"] == 1 else f"0x{freeze_val:04X}")
        if group_id:
            group = next((g for g in self._watch_groups() if g["id"] == group_id), None)
            if group:
                group_var.set(group["label"])

        status_var = tk.StringVar()
        tk.Label(dlg, textvariable=status_var, font=FONT, fg=C_RED,
                 bg=C_BG).grid(row=6, column=0, columnspan=2, padx=12)

        def commit():
            label = e_label.get().strip() or "Watch"
            try:
                addr = int(e_addr.get().strip(), 16)
            except ValueError:
                status_var.set("Invalid address (use hex like 0xD200)")
                return
            if not (0 <= addr <= 0xFFFF):
                status_var.set("Address out of range")
                return
            size = 1 if size_var.get() == "byte" else 2
            frozen = frozen_var.get()
            try:
                freeze_val = int(e_freeze_val.get().strip(), 16) if e_freeze_val.get().strip() else 0
            except ValueError:
                status_var.set("Invalid freeze value")
                return

            current_value = 0
            if edit_idx is not None:
                current_value = self._entries[edit_idx].get("value", 0)
            entry = {
                "type": "watch",
                "label": label,
                "addr": addr,
                "size": size,
                "group_id": self._group_id_for_label(group_var.get()) if group_var.get() != "(none)" else None,
                "frozen": frozen,
                "freeze_val": freeze_val,
                "value": current_value,
            }
            if edit_idx is not None:
                self._entries[edit_idx] = entry
            else:
                self._entries.append(entry)
            self._refresh_tree()
            dlg.destroy()

        bf = tk.Frame(dlg, bg=C_BG)
        bf.grid(row=7, column=0, columnspan=2, pady=8)
        tk.Button(bf, text="OK", font=FONT_B, bg="#1F6FEB", fg="white",
                  relief=tk.FLAT, padx=16, pady=4, command=commit).pack(side=tk.LEFT, padx=6)
        tk.Button(bf, text="Cancel", font=FONT, bg=C_PANEL, fg=C_DIM,
                  relief=tk.FLAT, padx=16, pady=4, command=dlg.destroy).pack(side=tk.LEFT)
        dlg.bind("<Return>", lambda event: commit())
        e_label.focus_set()

    def _add_group_dialog(self, prefill=None, edit_idx=None):
        dlg = tk.Toplevel(self.root_window())
        dlg.title("Edit Group" if edit_idx is not None else "Add Group")
        dlg.configure(bg=C_BG)
        dlg.geometry("320x145")
        dlg.resizable(False, False)
        dlg.transient(self.root_window())
        dlg.grab_set()

        tk.Label(dlg, text="Group label:", font=FONT, fg=C_DIM, bg=C_BG).pack(anchor="w", padx=12, pady=(12, 4))
        e_label = tk.Entry(dlg, font=FONT, bg=C_PANEL, fg=C_TEXT,
                           insertbackground=C_TEXT, relief=tk.FLAT, bd=4)
        e_label.pack(fill=tk.X, padx=12)
        if prefill:
            e_label.insert(0, prefill.get("label", ""))

        status = tk.StringVar()
        tk.Label(dlg, textvariable=status, font=FONT, fg=C_RED, bg=C_BG).pack(anchor="w", padx=12, pady=(6, 0))

        def commit():
            label = e_label.get().strip()
            if not label:
                status.set("Enter a group label")
                return
            if edit_idx is not None:
                self._entries[edit_idx]["label"] = label
            else:
                self._entries.append({
                    "type": "group",
                    "id": self._new_group_id(),
                    "label": label,
                    "collapsed": False,
                })
            self._refresh_tree()
            dlg.destroy()

        bf = tk.Frame(dlg, bg=C_BG)
        bf.pack(pady=10)
        tk.Button(bf, text="OK", font=FONT_B, bg="#1F6FEB", fg="white",
                  relief=tk.FLAT, padx=16, pady=4, command=commit).pack(side=tk.LEFT, padx=6)
        tk.Button(bf, text="Cancel", font=FONT, bg=C_PANEL, fg=C_DIM,
                  relief=tk.FLAT, padx=16, pady=4, command=dlg.destroy).pack(side=tk.LEFT)
        dlg.bind("<Return>", lambda event: commit())
        e_label.focus_set()

    def _new_group_id(self):
        group_id = f"g{self._next_group_id}"
        self._next_group_id += 1
        return group_id

    def _on_double_click(self, event):
        entry = self._selected_entry()
        index = self._selected_index()
        if entry is None or index is None:
            return
        if entry["type"] == "group":
            self._add_group_dialog(prefill=entry, edit_idx=index)
        else:
            self._add_dialog(prefill=entry, edit_idx=index)

    def _on_right_click(self, event):
        row = self._tree.identify_row(event.y)
        if not row:
            return
        self._tree.selection_set(row)
        entry = self._selected_entry()
        if entry is None:
            return

        self._menu.delete(0, tk.END)
        if entry["type"] == "group":
            self._menu.add_command(label="Add watch here", command=lambda gid=entry["id"]: self._add_dialog(default_group_id=gid))
            self._menu.add_command(label="Edit group", command=self._edit_selected)
            self._menu.add_command(label="Delete group", command=self._delete_selected)
        else:
            self._menu.add_command(label="Edit", command=self._edit_selected)
            self._menu.add_command(label="Toggle freeze", command=self._toggle_freeze)
            self._menu.add_command(label="Set value now", command=self._set_value_dialog)
            self._menu.add_separator()
            self._menu.add_command(label="Delete", command=self._delete_selected)
        self._menu.post(event.x_root, event.y_root)

    def _on_delete_key(self, event):
        self._delete_selected()

    def _on_tree_open(self, event):
        entry = self._selected_entry()
        if entry and entry["type"] == "group":
            entry["collapsed"] = False

    def _on_tree_close(self, event):
        entry = self._selected_entry()
        if entry and entry["type"] == "group":
            entry["collapsed"] = True

    def _edit_selected(self):
        entry = self._selected_entry()
        index = self._selected_index()
        if entry is None or index is None:
            return
        if entry["type"] == "group":
            self._add_group_dialog(prefill=entry, edit_idx=index)
        else:
            self._add_dialog(prefill=entry, edit_idx=index)

    def _toggle_freeze(self):
        entry = self._selected_entry()
        if entry is None or entry["type"] != "watch":
            return
        entry["frozen"] = not entry["frozen"]
        if entry["frozen"] and not entry.get("freeze_val"):
            entry["freeze_val"] = entry.get("value", 0)
        self._refresh_tree()

    def _set_value_dialog(self):
        index = self._selected_index()
        entry = self._selected_entry()
        if entry is None or entry["type"] != "watch" or index is None:
            return

        dlg = tk.Toplevel(self.root_window())
        dlg.title("Set Value")
        dlg.configure(bg=C_BG)
        dlg.geometry("290x125")
        dlg.resizable(False, False)
        dlg.transient(self.root_window())
        dlg.grab_set()

        tk.Label(dlg, text=f"New value for {entry['label']} (hex):",
                 font=FONT, fg=C_TEXT, bg=C_BG).pack(padx=12, pady=(12, 4), anchor="w")
        e_value = tk.Entry(dlg, font=FONT, bg=C_PANEL, fg=C_TEXT,
                           insertbackground=C_TEXT, relief=tk.FLAT, bd=4)
        width = 2 if entry["size"] == 1 else 4
        e_value.insert(0, f"0x{entry.get('value', 0):0{width}X}")
        e_value.pack(fill=tk.X, padx=12)
        e_value.focus_set()
        e_value.select_range(0, tk.END)

        status = tk.StringVar()
        tk.Label(dlg, textvariable=status, font=FONT, fg=C_RED, bg=C_BG).pack(padx=12)

        def commit():
            try:
                value = int(e_value.get().strip(), 16)
            except ValueError:
                status.set("Invalid hex value")
                return
            max_value = 0xFF if entry["size"] == 1 else 0xFFFF
            if not (0 <= value <= max_value):
                status.set(f"Value out of range (0x{max_value:X} max)")
                return
            if not self._reader or not self._reader.connected:
                status.set("No live reader connected")
                return

            ok = self._reader.write_byte(entry["addr"], value) if entry["size"] == 1 else self._reader.write_word(entry["addr"], value)
            if not ok:
                status.set("Write failed")
                return

            self._entries[index]["value"] = value
            self._entries[index]["freeze_val"] = value
            self._refresh_tree()
            dlg.destroy()

        bf = tk.Frame(dlg, bg=C_BG)
        bf.pack(pady=4)
        tk.Button(bf, text="Set", font=FONT_B, bg="#1F6FEB", fg="white",
                  relief=tk.FLAT, padx=12, pady=3, command=commit).pack(side=tk.LEFT, padx=4)
        tk.Button(bf, text="Cancel", font=FONT, bg=C_PANEL, fg=C_DIM,
                  relief=tk.FLAT, padx=12, pady=3, command=dlg.destroy).pack(side=tk.LEFT)
        dlg.bind("<Return>", lambda event: commit())

    def _delete_selected(self):
        index = self._selected_index()
        entry = self._selected_entry()
        if index is None or entry is None:
            return

        if entry["type"] == "group":
            group_id = entry["id"]
            for child in self._entries:
                if child.get("group_id") == group_id:
                    child["group_id"] = None
        del self._entries[index]
        self._refresh_tree()

    def _save(self, path=None):
        path = path or WATCHES_FILE
        data = []
        for entry in self._entries:
            if entry["type"] == "group":
                data.append({
                    "type": "group",
                    "id": entry["id"],
                    "label": entry["label"],
                    "collapsed": entry.get("collapsed", False),
                })
            else:
                data.append({
                    "type": "watch",
                    "label": entry["label"],
                    "addr": entry["addr"],
                    "size": entry["size"],
                    "group_id": entry.get("group_id"),
                    "frozen": entry["frozen"],
                    "freeze_val": entry.get("freeze_val", 0),
                })
        with open(path, "w") as file_obj:
            json.dump(data, file_obj, indent=2)

    def _load(self, path=None):
        path = path or WATCHES_FILE
        if not os.path.exists(path):
            return
        try:
            with open(path) as file_obj:
                data = json.load(file_obj)
        except Exception as exc:
            print(f"[watches] load failed: {exc}")
            return

        entries = []
        max_group_num = 0
        for item in data:
            if item.get("type") == "group":
                group_id = item.get("id") or self._new_group_id()
                if group_id.startswith("g") and group_id[1:].isdigit():
                    max_group_num = max(max_group_num, int(group_id[1:]))
                entries.append({
                    "type": "group",
                    "id": group_id,
                    "label": item.get("label", "Group"),
                    "collapsed": item.get("collapsed", False),
                })
            else:
                entries.append({
                    "type": "watch",
                    "label": item.get("label", "Watch"),
                    "addr": item["addr"],
                    "size": item.get("size", 1),
                    "group_id": item.get("group_id"),
                    "frozen": item.get("frozen", False),
                    "freeze_val": item.get("freeze_val", 0),
                    "value": 0,
                })
        self._entries = entries
        self._next_group_id = max(self._next_group_id, max_group_num + 1)
        self._refresh_tree()

    def _load_dialog(self):
        path = filedialog.askopenfilename(
            title="Load watches",
            filetypes=[("JSON", "*.json"), ("All", "*.*")],
            initialdir=os.path.dirname(WATCHES_FILE),
        )
        if path:
            self._load(path)
