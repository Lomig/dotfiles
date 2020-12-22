#!/usr/bin/env ruby

=begin

Installation Scripts — Dotfiles and Dev Tools
-- Git configuration

=end

require 'colorize'

puts "\nSetting up Git...".green

if %x( uname ).chomp == "Darwin"
  %x( git config --global credential.helper "osxkeychain" )
else
  %x( git config --global credential.helper "store" )
end
