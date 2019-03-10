#!/usr/bin/env ruby

=begin

Installation Scripts — Dotfiles and Dev Tools
-- Symlinks for dotfiles

=end

require 'fileutils'
require 'colorize'

user_dir = File.expand_path('~/')
dotfiles = "#{user_dir}/.dotfiles"
links = Hash.new

# General Symlinks
Dir.glob("#{dotfiles}/**/*.symlink") do |item|
	links[".#{File.basename(item, '.*')}"] = "#{item}"
end

# .config Symlinks
puts "Creating ~/.config directory..."
FileUtils.mkdir_p "#{user_dir}/.config"

Dir.foreach("#{dotfiles}/config") do |item|
  next if item == "." || item == ".."
  links[".config/#{item}"] = ".dotfiles/config/#{item}"
end

## Vim / Neovim Symlinks
links[".vim"] = ".config/nvim"
links[".vimrc"] = ".config/nvim/init.vim"

links.each do |key, value|
  next if File.exist?("#{user_dir}/#{key}")

  puts "Creating symlink for #{key}...".magenta
  %x( ln -s #{user_dir}/#{key} #{value} )
end

