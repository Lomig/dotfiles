#!/usr/bin/env ruby

=begin

Installation Scripts — Dotfiles and Dev Tools
-- Réglages de macOS X

=end

require 'colorize'

puts "Réglages systèmes de MacOS X...".green

# Finder: show all filename extensions
%x( defaults write NSGlobalDomain AppleShowAllExtensions -bool true )

# Show hidden files by default
%x( defaults write com.apple.Finder AppleShowAllFiles -bool false )

# Only use UTF-8 in Terminal.app
%x( defaults write com.apple.terminal StringEncodings -array 4 )

# Expand save dialog by default
%x( defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true )

# Show the ~/Library folder in Finder
# %x( chflags nohidden ~/Library )

# Use current directory as default search scope in Finder
%x( defaults write com.apple.finder FXDefaultSearchScope -string "SCcf" )

# Show Path bar in Finder
%x( defaults write com.apple.finder ShowPathbar -bool true )

#Show Status bar in Finder
# defaults write com.apple.finder ShowStatusBar -bool true

# Enable Safari’s debug menu
%x( defaults write com.apple.Safari IncludeInternalDebugMenu -bool true )

# Restart modified applications
puts "Killing affected applications..."
["Safari", "Finder", "Dock", "Mail", "SystemUIServer"].each do |app|
  %x( killall #{app} > /dev/null 2>&1 )
end
