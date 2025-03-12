#!/bin/bash

defaults write NSGlobalDomain AKLastIDMSEnvironment -int 0
defaults write NSGlobalDomain AKLastLocale -string "en_BR"
defaults write NSGlobalDomain AppleActionOnDoubleClick -string "Maximize"
defaults write NSGlobalDomain AppleAntiAliasingThreshold -int 4
defaults write NSGlobalDomain AppleEnableMouseSwipeNavigateWithScrolls -bool true
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2
defaults write NSGlobalDomain AppleLanguages -array "en-US"
defaults write NSGlobalDomain AppleLanguagesSchemaVersion -int 4000
defaults write NSGlobalDomain AppleLocale -string "en_BR"
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain AppleWindowTabbingMode -string "always"
defaults write NSGlobalDomain CGDisableCursorLocationMagnification -bool true
defaults write NSGlobalDomain InitialKeyRepeat -int 12
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticInlinePredictionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelFileLastListModeForOpenModeKey -int 2
defaults write NSGlobalDomain NSNavPanelFileListModeForOpenMode2 -int 2
defaults write NSGlobalDomain NavPanelFileListModeForOpenMode -int 2
defaults write NSGlobalDomain "com.apple.keyboard.fnState" -bool false
defaults write NSGlobalDomain "com.apple.mouse.scaling" -float 3
defaults write NSGlobalDomain "com.apple.sound.beep.flash" -bool false
defaults write NSGlobalDomain "com.apple.springing.delay" -float 0.2
defaults write NSGlobalDomain "com.apple.springing.enabled" -bool true
defaults write NSGlobalDomain "com.apple.trackpad.forceClick" -bool true
defaults write NSGlobalDomain "com.apple.trackpad.scaling" -float 3
defaults write NSGlobalDomain shouldShowRSVPDataDetectors -bool false

defaults write NSGlobalDomain NSLinguisticDataAssetsRequested -array "en" "pt" "es" "fr" "it" "nl" "fi" "de" "da" "en_US" "en_BR" "ru" "ro"
defaults write NSGlobalDomain NSLinguisticDataAssetsRequestedByChecker -array "pt" "en" "es" "fr" "it" "nl" "fi" "de" "da" "ru" "ro"

defaults write NSGlobalDomain NSUserDictionaryReplacementItems -array '{ on = 1; replace = "omw"; with = "On my way!"; }'
defaults write NSGlobalDomain NSUserQuotesArray -array "\U201c" "\U201d" "\U2018" "\U2019"

defaults write com.apple.finder SyncExtensions -dict \
    collaborationMap -dict "com.google.drivefs.finderhelper.findersync" -int 0 \
    dirMap -dict "com.google.drivefs.finderhelper.findersync" -array \
    "file:///Users/arthurgehrke/repositories/doare/steganography/" \
    "file:///Users/arthurgehrke/Alfred/" \
    "file:///Users/arthurgehrke/cloud-sync/" \
    "file:///" \
    "file:///Users/arthurgehrke/repositories/doare/doare-python-scripts/" \
    "file:///Users/arthurgehrke/Documents/Screenshots/"

killall Finder

echo "Configurações aplicadas. Reinicie o sistema para garantir que todas as alterações tenham efeito."
