#!/bin/bash

# Export all Keyboard Shortcuts
defaults export com.apple.symbolichotkeys "$HOME/private/preferences/keyboard_shortcuts.plist"
defaults export com.apple.universalaccess "$HOME/private/preferences/universal_access_shortcuts.plist"

# Export all Dock settings
defaults export com.apple.dock "$HOME/private/preferences/dock.plist"

# Alfred
cp -r "$HOME/Library/Preferences/com.runningwithcrayons.Alfred.plist" "$HOME/private/preferences/"
cp -r "$HOME/Library/Preferences/com.runningwithcrayons.Alfred-Preferences.plist" "$HOME/private/preferences/"

# Criar diretórios apenas se não existirem
[ ! -d "$HOME/private/preferences/Bartender" ] && mkdir -p "$HOME/private/preferences/Bartender"
[ ! -d "$HOME/private/preferences/CleanShot" ] && mkdir -p "$HOME/private/preferences/CleanShot"
[ ! -d "$HOME/private/preferences/BetterSnapTool" ] && mkdir -p "$HOME/private/preferences/BetterSnapTool"

# Bartender (corrigindo caminho com aspas)
cp -r "$HOME/Library/Application Support/Bartender" "$HOME/private/preferences/Bartender/"

# CleanShot (corrigindo caminho com aspas)
cp -r "$HOME/Library/Application Support/CleanShot" "$HOME/private/preferences/CleanShot/"

# BetterSnapTool (adicionando backup com aspas)
cp -r "$HOME/Library/Application Support/BetterSnapTool" "$HOME/private/preferences/BetterSnapTool/"
