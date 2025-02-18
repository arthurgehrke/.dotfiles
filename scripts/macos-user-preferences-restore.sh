#!/bin/bash

# Import all Keyboard Shortcuts
defaults import com.apple.symbolichotkeys "$HOME/private/preferences/keyboard_shortcuts.plist"
defaults import com.apple.universalaccess "$HOME/private/preferences/universal_access_shortcuts.plist"

# Remove default Dock and import all Dock settings
defaults delete com.apple.dock persistent-apps
defaults delete com.apple.dock persistent-others
defaults import com.apple.dock "$HOME/private/preferences/dock.plist"

# Alfred
cp "$HOME/private/preferences/com.runningwithcrayons.Alfred.plist" "$HOME/Library/Preferences/"
cp "$HOME/private/preferences/com.runningwithcrayons.Alfred-Preferences.plist" "$HOME/Library/Preferences/"

# Bartender (restaurando configurações)
cp -r "$HOME/private/preferences/Bartender/" "$HOME/Library/Application Support/Bartender/"
cp "$HOME/private/preferences/com.surteesstudios.Bartender.plist" "$HOME/Library/Preferences/"

# CleanShot (restaurando configurações)
cp -r "$HOME/private/preferences/CleanShot/" "$HOME/Library/Application Support/CleanShot/"
cp "$HOME/private/preferences/pl.maketheweb.cleanshotx.plist" "$HOME/Library/Preferences/"

# BetterSnapTool (restaurando configurações)
cp -r "$HOME/private/preferences/BetterSnapTool/" "$HOME/Library/Application Support/BetterSnapTool/"
cp "$HOME/private/preferences/com.hegenberg.BetterSnapTool.plist" "$HOME/Library/Preferences/"
