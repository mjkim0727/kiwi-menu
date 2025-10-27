#!/bin/bash
# Script to compile translation files for Kiwi Menu extension

set -e

EXTENSION_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PO_DIR="$EXTENSION_DIR/po"
LOCALE_DIR="$EXTENSION_DIR/locale"

echo "Compiling translations for Kiwi Menu..."

# Create locale directory if it doesn't exist
mkdir -p "$LOCALE_DIR"

# Compile each .po file to .mo
for po_file in "$PO_DIR"/*.po; do
    if [ -f "$po_file" ]; then
        # Extract language code from filename (e.g., es.po -> es)
        lang=$(basename "$po_file" .po)
        
        # Create directory for this language
        lang_dir="$LOCALE_DIR/$lang/LC_MESSAGES"
        mkdir -p "$lang_dir"
        
        # Compile .po to .mo
        echo "Compiling $lang..."
        msgfmt "$po_file" -o "$lang_dir/gnome-shell-extensions-kiwimenu.mo"
    fi
done

echo "Translation compilation complete!"
echo "Compiled translations are in: $LOCALE_DIR"
