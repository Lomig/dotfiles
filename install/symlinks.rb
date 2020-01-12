#!/usr/bin/env ruby
# frozen_string_literal: true

#
# Installation Scripts — Dotfiles and Dev Tools
# -- Symlinks for dotfiles
#

require 'fileutils'
require 'colorize'

user_dir = File.expand_path('~/')
dotfiles = "#{user_dir}/.dotfiles"
links = {}

# General Symlinks
# Any file.symlink in any subdirectory is converted to a ~/.file
Dir.glob("#{dotfiles}/**/*.symlink") do |item|
  links[".#{File.basename(item, '.*')}"] = item.to_s
end

# .config Symlinks
puts "Creating ~/.config directory..."
FileUtils.mkdir_p "#{user_dir}/.config"

Dir.foreach("#{dotfiles}/config") do |item|
  next if item == "." || item == ".."

  links[".config/#{item}"] = "#{dotfiles}/config/#{item}"
end

## Vim / Neovim Symlinks
links[".vim"] = "#{user_dir}/.config/nvim"
links[".vimrc"] = "#{user_dir}/.config/nvim/init.vim"

links.each do |key, value|
  if File.exist?("#{user_dir}/#{key}")
    puts "#{user_dir}/#{key} already exists. Skipped.".yellow
    next
  end

  puts "Creating symlink for #{key}...".magenta
  `ln -s #{value}  #{user_dir}/#{key}`
end
