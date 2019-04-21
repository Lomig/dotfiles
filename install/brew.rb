#!/usr/bin/env ruby

=begin

Installation Scripts — Dotfiles and Dev Tools
-- Brew Packages

=end

require 'fileutils'
require 'ptools'
require 'open-uri'
require 'colorize'

unless File.which("brew")
  puts "Installing Homebrew...".green
  eval open("https://raw.githubusercontent.com/Homebrew/install/master/install", &:read)
end

formulae = [
  "bat",
  "editorconfig",
  "diff-so-fancy",
  "fzf",
  "git",
  "grep",
  "mas",
  "neovim",
  "node",
  "python",
  "reattach-to-user-namespace",
  "tmux",
  "trash",
  "wget",
  "vim",
  "z",
  "zsh",
  "ripgrep",
  "entr",
  "zplug",
  "ocaml",
  "opam",
]

formulae.each do |formula|
  if system "brew list #{formula.split.first} 2>&1"
    puts "#{formula.split.first} is already installed — skipped.".yellow
  else
    %x( brew install "#{formula}" )
  end
end

# Installing fonts
puts "Installing fonts...".green
%x( brew tap caskroom/fonts )
%x( brew cask install font-hack-nerd-font )

# Setup fzf after install
puts "Setting up fzf...".green
%x( /usr/local/opt/fzf/install --all --no-bash --no-fish )

# Neovim Python install
puts "Setting up Python with Vim...".green
%x( pip3 install --user neovim )

# Zsh installation
puts "Setting up zsh...".green

zsh_path = %x( command -v zsh ).chomp
unless system("grep #{zsh_path} /etc/shells")
  puts "Adding #{zsh_path} to /etc/shells..."
  File.open("/etc/shells", "a") { |f|
    f.puts zsh_path
  }
end

unless ENV['SHELL'] == zsh_path
  %x( chsh -s "#{zsh_path}" )
  puts "Default shell changed to #{zsh_path}"
end
