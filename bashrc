export HISTTIMEFORMAT='%F %T '
PATH=$PATH:/Users/moonr/bin:/usr/local/bin:/usr/local/sbin:/usr/local/munki:/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend
export HISTIGNORE="&:[ ]*:clear"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

###Git Autocomplete
source `brew --prefix git`/etc/bash_completion.d/git-completion.bash
