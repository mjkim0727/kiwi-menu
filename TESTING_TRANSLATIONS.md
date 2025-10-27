# Quick Start: Testing Translations

## Prerequisites
- GNOME Shell 48 or 49
- gettext utilities installed (for development)

## Installation with Translations

1. **Clone or download the extension:**
   ```bash
   cd ~/github
   git clone https://github.com/kem-a/kiwimenu-kemma.git
   cd kiwimenu-kemma
   ```

2. **Compile translations:**
   ```bash
   ./compile-translations.sh
   ```

3. **Install the extension:**
   ```bash
   # Create symlink to GNOME extensions directory
   ln -s "$(pwd)" "$HOME/.local/share/gnome-shell/extensions/kiwimenu@kemma"
   ```

4. **Compile GSettings schema:**
   ```bash
   glib-compile-schemas schemas/
   ```

5. **Reload GNOME Shell:**
   - Press `Alt+F2`
   - Type `r` and press Enter
   - Or log out and log back in

6. **Enable the extension:**
   ```bash
   gnome-extensions enable kiwimenu@kemma
   ```

## Testing Different Languages

### Method 1: Change System Language
1. Open Settings → Region & Language
2. Add your target language
3. Log out and log back in
4. The extension will use the new language automatically

### Method 2: Test with Environment Variable (Temporary)
```bash
# Test German
LANGUAGE=de_DE.UTF-8 gnome-shell --replace &

# Test Spanish
LANGUAGE=es_ES.UTF-8 gnome-shell --replace &

# Return to English
LANGUAGE=en_US.UTF-8 gnome-shell --replace &
```

**Warning:** This method restarts GNOME Shell - save your work first!

### Method 3: Test Specific Locale (Development)
```bash
# Set locale for current terminal session
export LANGUAGE=de_DE.UTF-8
export LC_ALL=de_DE.UTF-8

# Reload extension
gnome-extensions disable kiwimenu@kemma
gnome-extensions enable kiwimenu@kemma
```

## Verifying Translations

### Check Menu Items
1. Click the Kiwi Menu icon
2. Verify all menu items are translated:
   - About This PC
   - System Settings
   - Recent Items
   - Force Quit
   - Sleep/Restart/Shut Down
   - Lock Screen
   - Log Out

### Check Recent Items Submenu
1. Hover over "Recent Items"
2. Check submenu translations:
   - "Files" section header
   - "Folders" section header
   - "Clear menu" button
   - "No recent items" placeholder (if no items)

### Check Preferences Window
1. Open extension preferences:
   ```bash
   gnome-extensions prefs kiwimenu@kemma
   ```
2. Verify translations in:
   - Page titles (Options, About)
   - Group descriptions
   - Switch labels
   - About page content
   - Legal dialog

## Checking Logs

If translations don't appear:

```bash
# Check GNOME Shell logs
journalctl --user-unit gnome-shell -f

# Look for errors related to:
# - gettext domain
# - locale directory
# - .mo files
```

## Common Issues

### Translations Not Loading
1. **Check .mo files exist:**
   ```bash
   ls -la locale/*/LC_MESSAGES/
   ```
   Should show: `gnome-shell-extensions-kiwimenu.mo`

2. **Verify locale directory structure:**
   ```
   locale/
   ├── de/
   │   └── LC_MESSAGES/
   │       └── gnome-shell-extensions-kiwimenu.mo
   └── es/
       └── LC_MESSAGES/
           └── gnome-shell-extensions-kiwimenu.mo
   ```

3. **Recompile translations:**
   ```bash
   cd po
   make clean
   make compile
   ```

4. **Restart extension:**
   ```bash
   gnome-extensions disable kiwimenu@kemma
   gnome-extensions enable kiwimenu@kemma
   ```

### Partial Translations
If some strings are translated but others aren't:

1. Check for missing translations in .po file
2. Verify format strings are correct (e.g., `%s`)
3. Recompile translations

### Wrong Language Displayed
1. Check your system language settings
2. Verify LANGUAGE environment variable
3. Check available locales:
   ```bash
   locale -a
   ```

## Development Workflow

### Adding New Translatable Strings

1. **Wrap string in code:**
   ```javascript
   // In extension code
   const text = this._gettext('New string');
   
   // In prefs code
   const text = _('New string');
   ```

2. **Update POT file:**
   ```bash
   cd po
   make pot
   ```

3. **Update existing translations:**
   ```bash
   make update
   ```

4. **Edit .po files** to translate new strings

5. **Compile and test:**
   ```bash
   make compile
   ```

## Debugging Tips

1. **Check if gettext is working:**
   ```javascript
   // Add temporary debug line
   console.log(this._gettext('Test'));
   ```

2. **Verify .mo files are readable:**
   ```bash
   msgunfmt locale/de/LC_MESSAGES/gnome-shell-extensions-kiwimenu.mo
   ```

3. **Check translation domain matches:**
   - Code: Uses domain from extension.gettext()
   - Schema: `gettext-domain="gnome-shell-extensions-kiwimenu"`
   - Files: Named `gnome-shell-extensions-kiwimenu.mo`

## Success Indicators

✅ Menu items appear in target language  
✅ Preferences window is fully translated  
✅ Recent items submenu uses translated headers  
✅ No console errors related to translations  
✅ Dynamic text (like username in Log Out) is properly formatted  

## Getting Help

- Check GNOME Shell logs for errors
- Review the [Translation Guide](po/README.md)
- Open an issue on GitHub with:
  - Your GNOME Shell version
  - Your system locale
  - Relevant log output

## References

- [GNOME Shell Extension Guide](https://gjs.guide/extensions/)
- [GNU gettext Manual](https://www.gnu.org/software/gettext/manual/)
- [GNOME Translation Project](https://wiki.gnome.org/TranslationProject)
