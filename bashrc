export HISTFILE=~/.history/$(date +%Y%m%d).hist
if [[ ! -e $HISTFILE ]]; then
    LASTHIST=~/.history/$(ls -tr ~/.history/ | tail -1)
    if [[ -e $LASTHIST ]]; then
        tail -50 $LASTHIST > $HISTFILE
        # Write a divider to identify where the prior day's session history ends
        echo "##########################################################" >> $HISTFILE
    fi
fi
export HISTTIMEFORMAT='%F-%T%t'
export HISTCONTROL=ignoredups:erasedups
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
shopt -s histappend # append new history items to .bash_history
export HISTIGNORE="&:[ ]*:clear"
export PATH=~/bin:/usr/local/opt/coreutils/libexec/gnubin:~/.rbenv/versions/1.9.3-p448/bin:/usr/local/bin:/usr/local/sbin:/usr/local/munki:/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin:/Users/moonr/google-cloud-sdk/bin:$PATH
export PROMPT_COMMAND='history -a'
shopt -s histappend

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

