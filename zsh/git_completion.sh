# this is specific to the location of the current version of git, installed by homebrew
completion=/usr/local/Cellar/git/2.25.0/share/zsh/site-functions/git-completion.zsh

if test -f $completion; then
    source $completion
fi
