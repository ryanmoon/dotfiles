export HISTTIMEFORMAT='%F %T '
PATH=$PATH:/Users/moonr/bin:/usr/local/bin:/usr/local/sbin:/usr/local/munki:/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin
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
