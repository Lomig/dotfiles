#!/usr/bin/env ruby

=begin

Installation Scripts — Dotfiles and Dev Tools
-- Git configuration

=end

require 'colorize'

puts "\nSetting up Git...".green

git_name = %x( git config --global user.name )
git_email = %x( git config --global user.email )
github_account = %x( git config --global github.user )

git_name = "Lomig Enfroy" if git_name.empty?
git_email = "dunwael@gmail.com" if git_email.empty?
github_account = "Lomig" if github_account.empty?

print "Name [#{git_name}]: ".blue
tmp = gets.chomp
git_name = tmp unless tmp.empty?
print "Email [#{git_email}]: ".blue
tmp = gets.chomp
git_email = tmp unless tmp.empty?
print "Github Account [#{github_account}]: ".blue
tmp = gets.chomp
git_name = tmp unless tmp.empty?

if %x( uname ) == "Darwin"
  %x( git config --global credential.helper "osxkeychain" )
else
  %x( git config --global credential.helper "store" )
end
