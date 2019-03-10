#!/usr/bin/env ruby

=begin

Installation Scripts — Dotfiles and Dev Tools

=end

require 'fileutils'
require 'ptools'
require 'colorize'

puts "Installing dotfiles...".green

# Git Submodules (if any)
puts "Initializing Git Submodules..."
%x( git submodule update --init --recursive )
# Symlinks creation
eval File.read("./install/symlinks.rb")

# Git Setup
eval File.read("./install/git.rb")

# MacOS specific install
if %x( uname ).chomp == "Darwin"
  puts "\nMacOS detected. Specific install...".blue
  eval File.read("./install/brew.rb")
  eval File.read("./install/osx.rb")
  puts "\nBack to standard install...".blue
end

# Vim directories
puts "Creating  Vim directories..."
FileUtils.mkdir_p File.expand_path('~/.vim-tmp')

unless File.which("zsh")
  puts "Zsh not found. Please install and then re-run installation scripts.".red
  abort
end

unless ENV['SHELL'].include? "zsh"
  puts "Configuring zsh as default shell..."
  %x( chsh -s "$(command -v zsh)" )
end

puts "Installation done; please restart your terminal!".green
