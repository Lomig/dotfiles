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
  "asdf",
  "bat",
  "editorconfig",
  "diff-so-fancy",
  "fzf",
  "git",
  "grep",
  "mas",
  "neovim",
  "tmux",
  "trash",
  "wget",
  "z",
  "ripgrep",
  "entr",
  "zplug",
  "opam",
  "ocaml",
  "postgres",
  "postgis",
  "redis",
  "zsh-syntax-highlighting",
]

formulae.each do |formula|
  if system "brew list #{formula.split.first} > /dev/null 2>&1"
    puts "#{formula.split.first} is already installed — skipped.".yellow
  else
    puts "Installing #{formula.split.first}...".green
    %x( brew install "#{formula}" )
  end
end

# Installing Dev Languages through asdf
puts "Installing asdf modules for Ruby...".green
%x( asdf plugin-add ruby )
puts "Installing Ruby...".green
%x( asdf install ruby 2.6.5 )
%x( asdf global ruby 2.6.5 )

puts "Installing asdf modules for Python...".green
%x( asdf plugin-add python )
puts "Installing Python...".green
%x( asdf install python 3.8.0 )
%x( asdf global python 3.8.0 )

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

# zsh is the new default shell on MacOS 10.15+
# Not useful anymore to configure it.
=begin
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
=end
