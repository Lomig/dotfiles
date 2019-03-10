#!/usr/bin/env ruby

=begin

Installation Scripts — Dotfiles and Dev Tools
-- Git configuration

=end

require 'colorize'

puts "\nSetting up Git...".green

git_name = %x( git config --global user.name )
git_name = "Lomig Enfroy" if git_name.empty?
print "Name [#{git_name}]: ".blue
tmp = gets.chomp
git_name = tmp unless tmp.empty?

git_email = %x( git config --global user.email )
git_email = "dunwael@gmail.com" if git_email.empty?
print "Email [#{git_email}]: ".blue
tmp = gets.chomp
git_email = tmp unless tmp.empty?

github_account = %x( git config --global github.user )
github_account = "Lomig" if github_account.empty?
print "Github Account [#{github_account}]: ".blue
tmp = gets.chomp
github_account = tmp unless tmp.empty?


%x( git config --global user.name #{git_name})
%x( git config --global user.email #{git_email} )
%x( git config --global github.user #{github_account} )
%x( git config --global core.excludesfile ~/.gitignore_global )

if %x( uname ).chomp == "Darwin"
  %x( git config --global credential.helper "osxkeychain" )
else
  %x( git config --global credential.helper "store" )
end
