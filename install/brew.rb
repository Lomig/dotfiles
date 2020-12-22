#!/usr/bin/env ruby
# frozen_string_literal: true

#
# Installation Scripts — Dotfiles and Dev Tools
# -- Brew Packages
#

require 'fileutils'
require 'ptools'
require 'open-uri'
require 'colorize'

unless File.which('brew')
  puts 'Installing Homebrew...'.green
  eval open('https://raw.githubusercontent.com/Homebrew/install/master/install', &:read)
end

formulae = %w[
  asdf
  bat
  editorconfig
  exa
  diff-so-fancy
  fzf
  git
  gh
  grep
  mas
  neovim
  tmux
  trash
  wget
  z
  ripgrep
  entr
  zplug
  postgres
  postgis
  redis
  zsh-syntax-highlighting
  zsh-autosuggestions
  reattach-to-user-namespace
]

cask_formulae = %w[
  mark-text
  keepassxc
]

formulae.each do |formula|
  if system "brew list #{formula.split.first} > /dev/null 2>&1"
    puts "#{formula.split.first} is already installed — skipped.".yellow
  else
    puts "Installing #{formula.split.first}...".green
    `brew install "#{formula}"`
  end
end

cask_formulae.each do |formula|
  puts "Installing #{formula.split.first}...".green
  `brew install "#{formula}"`
end

# Installing Dev Languages through asdf
puts 'Installing asdf modules for Ruby...'.green
`asdf plugin-add ruby`
puts 'Installing Ruby...'.green
`asdf install ruby 2.6.5`
`asdf install ruby 2.7.1`
`asdf global ruby 2.7.1`
`gem install rubocop`
`gem install standardrb`

puts 'Installing asdf modules for Python...'.green
`asdf plugin-add python`
puts 'Installing Python...'.green
`asdf install python 3.8.0`
`asdf global python 3.8.0`

puts 'Installing asdf modules for Javascript...'.green
`asdf plugin-add nodejs`
`asdf plugin-add yarn`
puts 'Installing Nodejs and yarn...'.green
`asdf install nodejs 15.4.0`
`asdf global nodejs 15.4.0`
`asdf install yarn 1.22.5`
`asdf global yarn 1.22.5`

# Installing fonts
puts 'Installing fonts...'.green
`brew tap homebrew/cask-fonts`
`brew cask install font-hack-nerd-font`

# Setup fzf after install
puts 'Setting up fzf...'.green
`/usr/local/opt/fzf/install --all --no-bash --no-fish`

# Neovim Python install
puts 'Setting up Python with Vim...'.green
`pip3 install --user neovim`

