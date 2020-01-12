#!/usr/bin/env ruby

#
# Installation Scripts — Dotfiles and Dev Tools
# -- Réglages de macOS X
#

require "colorize"

puts "Réglages systèmes de MacOS X...".green

# Finder: show all filename extensions
`defaults write NSGlobalDomain AppleShowAllExtensions -bool true`

# Show hidden files by default
`defaults write com.apple.Finder AppleShowAllFiles -bool false`

# Only use UTF-8 in Terminal.app
`defaults write com.apple.terminal StringEncodings -array 4`

# Expand save dialog by default
`defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true`

# Show the ~/Library folder in Finder
# %x( chflags nohidden ~/Library )

# Use current directory as default search scope in Finder
`defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"`

# Show Path bar in Finder
`defaults write com.apple.finder ShowPathbar -bool true`

# Show Status bar in Finder
# defaults write com.apple.finder ShowStatusBar -bool true

# Enable Safari’s debug menu
`defaults write com.apple.Safari IncludeInternalDebugMenu -bool true`

# Remove the Quarantine “Are you sure you want to open this application?” warning window
`defaults write com.apple.LaunchServices LSQuarantine -bool false`

# Enable full keyboard control on modal windows
`defaults write NSGlobalDomain AppleKeyboardUIMode -int 3`

# Keep folders on top while sorting files alphabetically in Finder
`defaults write com.apple.finder _FXSortFoldersFirst -bool true`

# Enable Snap-to-grid anywhare in Finder
`/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist`
`/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist`
`/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist`

# Disable the warning before emptying the Trash
`defaults write com.apple.finder WarnOnEmptyTrash -bool false`

# Don’t show recent applications in Dock
`defaults write com.apple.dock show-recents -bool false`

# Restart modified applications
puts "Killing affected applications..."
["Safari", "Finder", "Dock", "Mail", "SystemUIServer"].each do |app|
  `killall #{app} > /dev/null 2>&1`
end

# Add xterminfo
`tic ~/.dotfiles/resources/xterm-256color-italic.terminfo`
`tic -x ~/.dotfiles/resources/tmux-256color-italic.terminfo`
