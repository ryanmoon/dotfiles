export PS1="\[$(tput bold)\]\[$(tput setaf 7)\]🍕  \T \[$(tput setaf 9)\]\! \[$(tput setaf 3)\]\[$(tput sgr0)\] \w  \n👾   "

export PATH=/Users/moonr/bin:/usr/local/bin:/usr/local/sbin:/usr/local/munki:/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin:$PATH
export EDITOR='subl -w'


# bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
  

FIGNORE=".o:~:Application Scripts"
alias log="usr/local/bin/logtodayone.rb"
alias git=hub

# Add current folder to ~/.gitlogger with name specified as argument 1
# For use with gitlogger.sh
function glog () {
	(echo "$1:`pwd`";grep -v "`pwd`$" ~/.gitlogger) | sort > ~/.gitlogger.tmp
	mv ~/.gitlogger.tmp ~/.gitlogger
}
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend
export HISTIGNORE="&:[ ]*:clear"
export PROMPT_COMMAND='history -a'
eval "$(rbenv init -)"
