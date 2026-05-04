echo "Finder: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "show hidden files by default"
defaults write com.apple.Finder AppleShowAllFiles -bool false

echo "expand save dialog by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# echo "show the ~/Library folder in Finder"
chflags nohidden ~/Library

echo "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo "Enable subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

echo "Disable window animations and Get Info animations in Finder"
defaults write com.apple.finder DisableAllAnimations -bool true

echo "Show Path bar in Finder"
defaults write com.apple.finder ShowPathbar -bool true

echo "Show Status bar in Finder"
defaults write com.apple.finder ShowStatusBar -bool true

echo "Don’t animate opening applications from the Dock"
defaults write com.apple.dock launchanim -bool false

echo "Disable opening and closing window animations"
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

echo "Enable tap to click (Trackpad)"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

echo "Enable Safari’s debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

#
# To disable desktop rearrangement:
defaults write com.apple.dock "mru-spaces" -bool "false"

# To disable Dock (delay 1000s):
defaults write com.apple.dock autohide-delay -float 1000

echo "Kill affected applications"
for app in Safari Finder Dock Mail SystemUIServer; do killall "$app" >/dev/null 2>&1; done

# echo "Start yabai and skhd"
# skhd --start-service
# yabai --start-service
defaults write -g NSWindowShouldDragOnGesture -bool true

# disable windows opening animations
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
