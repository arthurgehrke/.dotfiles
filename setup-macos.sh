#!/bin/zsh
echo Time to install all apps at once!
read -p "Press any key to continue... " -n1 -s
echo  '\n'

echo Installing Homebrew...
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo Installing taps...
# Configure Homebrew
brew dump restore

echo Installing Apps from the App Store...

mas install 1320666476 # Wipr
mas install 1147396723 # WhatsApp
mas install 937984704 # Amphetamine
mas install 425424353 # The Unarchiver
mas install 419330170 # Moom
mas install 522324709 # Multimon
mas install 1295203466 # Microsoft Remote Desktop
mas install 823766827 # OneDrive
mas install 1507246666 # Presentify
mas install 409201541 # Pages
mas install 405399194 # Kindle
mas install 1289197285 # MindNode
mas install 409203825 # Numbers

echo Everything is ready. Enjoy your new Mac!

#################
# Tmux
#################
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#############################################
### Set OSX Preferences - Borrowed from https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#############################################

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

##################
### Finder, Dock, & Menu Items
##################

# Show absolute path in finder's title bar
defaults write com.apple.finder _FXShowPosixPathInTitle true

# show all files in finder
defaults write com.apple.finder AppleShowAllFiles true

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Only Show Open Applications In The Dock  
defaults write com.apple.dock static-only -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

##################
### Text Editing / Keyboards
##################

# Disable smart quotes and smart dashes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Use function F1, F, etc keys as standard function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

echo "🖱️ Configurando Trackpad..."

defaults write com.apple.AppleMultitouchTrackpad ActuateDetents -int 1
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
defaults write com.apple.AppleMultitouchTrackpad DragLock -int 0
defaults write com.apple.AppleMultitouchTrackpad Dragging -int 0
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 2
defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -int 0
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadFiveFingerPinchGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadHandResting -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadHorizScroll -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadMomentumScroll -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadScroll -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 0
defaults write com.apple.AppleMultitouchTrackpad USBMouseStopsTrackpad -int 0
defaults write com.apple.AppleMultitouchTrackpad UserPreferences -int 1
defaults write com.apple.AppleMultitouchTrackpad version -int 12

echo "🖱️ Configurando Mouse Multitouch..."

defaults write com.apple.AppleMultitouchMouse MouseButtonDivision -int 55
defaults write com.apple.AppleMultitouchMouse MouseButtonMode -string "TwoButton"
defaults write com.apple.AppleMultitouchMouse MouseHorizontalScroll -bool true
defaults write com.apple.AppleMultitouchMouse MouseMomentumScroll -bool true
defaults write com.apple.AppleMultitouchMouse MouseOneFingerDoubleTapGesture -int 1
defaults write com.apple.AppleMultitouchMouse MouseTwoFingerDoubleTapGesture -int 3
defaults write com.apple.AppleMultitouchMouse MouseTwoFingerHorizSwipeGesture -int 2
defaults write com.apple.AppleMultitouchMouse MouseVerticalScroll -bool true
defaults write com.apple.AppleMultitouchMouse UserPreferences -int 1
defaults write com.apple.AppleMultitouchMouse version -int 1

echo "✅ Configurações do Mouse Multitouch aplicadas!"

defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Paste and Match Style" -string "@v"
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false
defaults write NSGlobalDomain AppleShowScrollBars WhenScrolling
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool true
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSPersonNameDefaultDisplayNameOrder -int 1
defaults write NSGlobalDomain com.apple.mouse.scaling -real 1
defaults write NSGlobalDomain com.apple.sound.beep.flash -int 0
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool false
defaults write NSGlobalDomain com.apple.trackpad.scaling 0.9
defaults write NSGlobalDomain ContextMenuGesture -int 1
defaults write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
defaults write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
defaults write NSGlobalDomain com.apple.trackpad.fiveFingerPinchSwipeGesture -int 2
defaults write NSGlobalDomain com.apple.trackpad.fourFingerHorizSwipeGesture -int 2
defaults write NSGlobalDomain com.apple.trackpad.fourFingerPinchSwipeGesture -int 2
defaults write NSGlobalDomain com.apple.trackpad.fourFingerVertSwipeGesture -int 2
defaults write NSGlobalDomain com.apple.trackpad.momentumScroll -bool true
defaults write NSGlobalDomain com.apple.trackpad.pinchGesture -bool true
defaults write NSGlobalDomain com.apple.trackpad.rotateGesture -bool true
defaults write NSGlobalDomain com.apple.trackpad.scrollBehavior -int 2
defaults write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 2
defaults write NSGlobalDomain com.apple.trackpad.threeFingerDragGesture -bool false
defaults write NSGlobalDomain com.apple.trackpad.threeFingerTapGesture -int 0
defaults write NSGlobalDomain com.apple.trackpad.threeFingerVertSwipeGesture -int 2
defaults write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 0
defaults write NSGlobalDomain com.apple.trackpad.twoFingerDoubleTapGesture -int 0
defaults write NSGlobalDomain com.apple.trackpad.twoFingerFromRightEdgeSwipeGesture -int 


# Double clicking menu bar doesn't do anything
defaults write NSGlobalDomain AppleActionOnDoubleClick -string "None"

# Allow Handoff between this Mac and your iCloud devices
defaults write ~/Library/Preferences/ByHost/com.apple.coreservices.useractivityd ActivityAdvertisingAllowed -bool true
defaults write ~/Library/Preferences/ByHost/com.apple.coreservices.useractivityd ActivityReceivingAllowed -bool true


# Disable Siri
defaults write com.apple.assistant.support "Assistant Enabled" -bool false

# Prevent Photos from opening automatically when a device is plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

killall Finder
