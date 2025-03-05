#!/bin/bash

echo "Starting macOS config..."

defaults write com.apple.finder _FXShowPosixPathInTitle -bool false
defaults write com.apple.finder AppleShowAllExtensions -bool false

killall Finder

defaults write -g AKLastLocale -string "en_BR"
defaults write -g AppleLocale -string "en_BR"
defaults write -g AppleLanguages -array "en-US"
defaults write -g AppleEnableMouseSwipeNavigateWithScrolls -bool true
defaults write -g AppleInterfaceStyle -string "Dark"
defaults write -g AppleWindowTabbingMode -string "always"

defaults write com.apple.finder WarnOnEmptyTrash -bool false

defaults write -g AppleMiniaturizeOnDoubleClick -bool true
defaults write -g AppleKeyboardUIMode -int 2

defaults write -g ApplePressAndHoldEnabled -bool true
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 12

defaults write -g AppleActionOnDoubleClick -string "Maximize"

defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticInlinePredictionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticTextCompletionEnabled -bool false
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool false
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder QLEnableTextSelection -bool true
# Search scope
# This Mac       : `SCev`
# Current Folder : `SCcf`
# Previous Scope : `SCsp`
# I prefer current folder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf" 
# Arrange by
# Kind, Name, Application, Date Last Opened,
# Date Added, Date Modified, Date Created, Size, Tags, None
defaults write com.apple.finder FXPreferredGroupBy -string "Date Last Opened"
# Preferred view style
# Icon View   : `icnv`
# List View   : `Nlsv`
# Column View : `clmv`
# Cover Flow  : `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# New window target
# Computer     : `PfCm`
# Volume       : `PfVo`
# $HOME        : `PfHm`
# Desktop      : `PfDe`
# Documents    : `PfDo`
# All My Files : `PfAF`
# Other…       : `PfLo`
defaults write com.apple.finder NewWindowTarget -string 'PfHm'
# show full POSIX path as Finder window title, default false
defaults write com.apple.finder _FXShowPosixPathInTitle -bool false
# show status bar in Finder windows
defaults write com.apple.finder ShowStatusBar -bool true
# show path bar in Finder windows
defaults write com.apple.finder ShowPathBar -bool true

# size of Finder sidebar icons, small=1, default=2, large=3
# (TBD: maybe for Catalina 10.15+ only?)
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int "1" 

defaults write -g com.apple.mouse.scaling -float 3
defaults write -g com.apple.trackpad.scaling -float 3
defaults write -g com.apple.trackpad.forceClick -bool true
defaults write -g com.apple.springing.delay -float 0.2
defaults write -g com.apple.springing.enabled -bool true

defaults write com.apple.sound.beep.flash -bool false
defaults write -g shouldShowRSVPDataDetectors -bool false

defaults write com.apple.suggestions SiriSuggestionsEnabled -bool false
sudo mdutil -a -i on
sudo mdutil -a -E

defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop         -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop     -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop     -bool true

# Safari opens with: last session
defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -bool true
# Don't open files in Safari after downloading:
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
# Enable Safari’s Debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

killall Finder
killall Dock

echo "Finished"
