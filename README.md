# Kiwi Menu

Kiwi Menu replaces the Activities button with a compact, macOS-inspired launcher that keeps your most common session actions one click away.

[<img width="228" height="106" alt="Get it on GNOME Extensions" src="https://github.com/user-attachments/assets/8aa08f2b-a902-48ca-999d-149591b49da7" />](https://github.com/kem-a/kiwimenu-kemma/releases)

## Features

- **macOS-style panel button**: Swaps the Activities label for a tidy icon-only trigger that blends into GNOME Shell.
- **Curated session controls**: Sleep, restart, shut down, lock, and log out entries mirror the macOS Apple menu workflow.
- **Recent items submenu**: Hover or click to browse recent files and folders with automatic section headers and quick launch support.
- **Force Quit overlay**: Launches the built-in xkill helper from the menu when an app misbehaves.
- **Adaptive logout label**: Personalizes the log out entry with your full name when available.
- **Hide Activities**: Hide activities button in top panel.

<img width="599" height="450" alt="Screenshot From 2025-10-24 17-31-09" src="https://github.com/user-attachments/assets/bc2c7893-42a0-4f74-bf98-4764224f9985" />


## Testing changes

1. Apply your edits.
2. Recompile the schema if keys changed.
3. Reload the extension:
   ```bash
   gnome-extensions disable kiwimenu@kemma
   gnome-extensions enable kiwimenu@kemma
   ```
4. Tail GNOME Shell logs when debugging:
   ```bash
   journalctl --user-unit gnome-shell -f
   ```

## Known issues

- Recent files require GNOME to populate `recently-used.xbel`; newly installed systems may need activity before entries appear.

## License

Kiwi Menu is distributed under the terms of the GNU General Public License v3.0 or later. See `LICENSE` for details.
