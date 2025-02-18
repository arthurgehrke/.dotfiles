#!/bin/bash

echo "Aplicando otimizações do macOS..."

defaults write -g AKLastIDMSEnvironment -int 0
defaults write -g AKLastLocale -string "en_BR"
defaults write -g AppleActionOnDoubleClick -string "Maximize"
defaults write -g AppleAntiAliasingThreshold -int 4
defaults write -g AppleEnableMouseSwipeNavigateWithScrolls -bool true
defaults write -g AppleInterfaceStyle -string "Dark"
defaults write -g AppleKeyboardUIMode -int 2
defaults write -g AppleLanguages -array "en-US"
defaults write -g AppleLanguagesSchemaVersion -int 4000
defaults write -g AppleLocale -string "en_BR"
defaults write -g AppleMiniaturizeOnDoubleClick -bool false
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g AppleWindowTabbingMode -string "always"
defaults write -g CGDisableCursorLocationMagnification -bool true
defaults write -g InitialKeyRepeat -int 12
defaults write -g InitialKeyRepeat_Level_Saved -int 0
defaults write -g KB_DoubleQuoteOption -string "“abc”"
defaults write -g KB_SingleQuoteOption -string "‘abc’"
defaults write -g KeyRepeat -int 1

defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticInlinePredictionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticTextCompletionEnabled -bool false
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

defaults write -g NSLinguisticDataAssetsRequestLastInterval -int 86400
defaults write -g NSLinguisticDataAssetsRequested -array en pt es fr it nl fi de da "en_US" "en_BR" ru ro
defaults write -g NSLinguisticDataAssetsRequestedByChecker -array pt en es fr it nl fi de da ru ro

defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder SyncExtensions -dict-add collaborationMap '{"com.google.drivefs.finderhelper.findersync"=0; "mega.mac.MEGAShellExtFinder"=0;}'
defaults write com.apple.finder SyncExtensions -dict-add dirMap '{"com.google.drivefs.finderhelper.findersync"=("file:///Users/arthurgehrke/repositories/doare/steganography/", "file:///Users/arthurgehrke/cloud-sync/", "file:///", "file:///Users/arthurgehrke/repositories/doare/doare-python-scripts/", "file:///Users/arthurgehrke/Documents/Screenshots/"); "mega.mac.MEGAShellExtFinder"=("file:///Users/arthurgehrke/Documents/MEGA/");}'

defaults write -g com.apple.mouse.scaling -float 3
defaults write -g com.apple.trackpad.scaling -float 3
defaults write -g com.apple.trackpad.forceClick -bool true
defaults write -g com.apple.springing.delay -float 0.2
defaults write -g com.apple.springing.enabled -bool true

defaults write com.apple.sound.beep.flash -bool false
defaults write -g shouldShowRSVPDataDetectors -bool false

defaults write com.apple.suggestions SiriSuggestionsEnabled -bool false
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false
sudo mdutil -a -i off

# General > Show these items on the desktop: Hard disks, External disks, Removable media, Connected servers
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Reiniciar serviços para aplicar mudanças
killall Finder
killall Dock

echo "Otimizações aplicadas com sucesso! 🚀"
