export PS1="\[$(tput bold)\]\[$(tput setaf 7)\]🍕  \T \[$(tput setaf 9)\]\! $(tput setaf 3)\]\$(batterycharge) \[$(tput setaf 5)\] PWD:\w \[$(tput sgr0)\] BRANCH:$(__git_ps1 " (%s)") \n👾   "

export PATH=/Users/moonr/bin:/Users/moonr/.rbenv/versions/1.9.3-p448/bin:/usr/local/bin:/usr/local/sbin:/usr/local/munki:/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin:$PATH
export EDITOR="/Users/moonr/bin/editor.sh"
export CLICOLOR=1
export LSCOLORS=ExxxxxDxBxegedabxxacad

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
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=10000
shopt -s histappend
export HISTIGNORE="&:[ ]*:clear"
export PROMPT_COMMAND='history -a'
eval "$(rbenv init -)"

# For Git Branch in prompt
source ~/bin/git_prompt.sh

# For Battery Status in prompt
function batterycharge {
	/Users/moonr/bin/batterycharge.sh
}

# For ARD to launch
function ard {
	/Users/moonr/bin/ard_launch.sh
}

# To Fix HomeBrew
function brewfix {
	/Users/moonr/bin/brew_fix.sh
}

# Traceroute Test to Google Public DNS
function ntest {
	/Users/moonr/bin/net-test.sh
}

