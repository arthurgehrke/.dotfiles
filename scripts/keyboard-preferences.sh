#!/bin/sh
defaults read NSGlobalDomain KeyRepeat
defaults read NSGlobalDomain InitialKeyRepeat
defaults write -g ApplePressAndHoldEnabled -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write NSGlobalDomain KeyRepeat -int 0.02
defaults write NSGlobalDomain InitialKeyRepeat -int 12
defaults read NSGlobalDomain KeyRepeat
defaults read NSGlobalDomain InitialKeyRepeat


# disable screenshot shadows
defaults write com.apple.screencapture disable-shadow -bool TRUE
defaults write com.apple.screencapture disable-shadow -bool FALSE

# reset finder
killall Finder
killall SystemUIServer

# show/hide hidden folder
defaults write com.apple.finder AppleShowAllFiles -bool TRUE

#Show the ~/Library folder
chflags nohidden ~/Library

# Make the Icon of Any Hidden App in the Dock Translucent
defaults write com.apple.Dock showhidden -bool TRUE
killall Dock
