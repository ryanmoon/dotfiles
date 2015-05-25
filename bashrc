export HISTTIMEFORMAT='%F %T '
export PATH=~/bin:/usr/local/opt/coreutils/libexec/gnubin:~/.rbenv/versions/1.9.3-p448/bin:/usr/local/bin:/usr/local/sbin:/usr/local/munki:/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin:/Users/moonr/google-cloud-sdk/bin:$PATH
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=10000
shopt -s histappend
export HISTIGNORE="&:[ ]*:clear"
export PROMPT_COMMAND='history -a'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

###Git Autocomplete
source `brew --prefix git`/etc/bash_completion.d/git-completion.bash

case $- in
   *i*) source ~/.bashrc
esac
eval "#(chef shell-init bash)"


# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh


source ~/.xsh

