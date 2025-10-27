# Makefile for Kiwi Menu translations

DOMAIN = gnome-shell-extensions-kiwimenu
POTFILE = kiwimenu.pot
POFILES = $(wildcard *.po)
MOFILES = $(POFILES:.po=.mo)
LOCALEDIR = ../locale

# Source files containing translatable strings
SOURCES = \
	../extension.js \
	../prefs.js \
	../src/kiwimenu.js \
	../src/recentItemsSubmenu.js \
	../src/forceQuitOverlay.js

.PHONY: all pot update compile clean install

# Default target: compile all translations
all: compile

# Extract translatable strings to POT file
pot:
	@echo "Extracting translatable strings..."
	xgettext --from-code=UTF-8 \
		--language=JavaScript \
		--keyword=_ \
		--keyword=gettext \
		--add-comments=Translators \
		--package-name="Kiwi Menu" \
		--package-version="1.0" \
		--msgid-bugs-address="https://github.com/kem-a/kiwimenu-kemma/issues" \
		--copyright-holder="Arnis Kemlers" \
		-o $(POTFILE) \
		$(SOURCES)
	@echo "POT file updated: $(POTFILE)"

# Update all PO files from POT
update: pot
	@echo "Updating translation files..."
	@for po in $(POFILES); do \
		echo "Updating $$po..."; \
		msgmerge -U $$po $(POTFILE); \
	done
	@echo "All PO files updated"

# Compile PO files to MO format
compile: $(MOFILES)

%.mo: %.po
	@echo "Compiling $<..."
	@lang=$$(basename $< .po); \
	mkdir -p $(LOCALEDIR)/$$lang/LC_MESSAGES; \
	msgfmt -c $< -o $(LOCALEDIR)/$$lang/LC_MESSAGES/$(DOMAIN).mo

# Install compiled translations (for development testing)
install: compile
	@echo "Translations compiled to $(LOCALEDIR)"

# Check PO files for errors
check:
	@for po in $(POFILES); do \
		echo "Checking $$po..."; \
		msgfmt -c --check-accelerators $$po -o /dev/null; \
	done

# Show translation statistics
stats:
	@for po in $(POFILES); do \
		echo "Statistics for $$po:"; \
		msgfmt --statistics $$po -o /dev/null 2>&1; \
	done

# Clean compiled files
clean:
	@echo "Cleaning compiled files..."
	@rm -rf $(LOCALEDIR)
	@rm -f *.mo
	@echo "Clean complete"

# Help target
help:
	@echo "Kiwi Menu Translation Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  all      - Compile all translations (default)"
	@echo "  pot      - Extract strings and update POT file"
	@echo "  update   - Update all PO files from POT"
	@echo "  compile  - Compile PO files to MO format"
	@echo "  check    - Check PO files for errors"
	@echo "  stats    - Show translation statistics"
	@echo "  clean    - Remove compiled files"
	@echo "  help     - Show this help message"
