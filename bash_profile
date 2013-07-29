export PS1="\[$(tput bold)\]\[$(tput setaf 2)\]🍕  \T \[$(tput setaf 4)\]\! \[$(tput setaf 6)\]\j \[$(tput sgr0)\] \w  👾  > "
# MacPorts Installer addition on 2011-11-29_at_18:04:42: adding an appropriate PATH variable for use with MacPorts.
export PATH=~/.rvm/bin:~/.rvm:~/bin:/usr/local/bin:/usr/local/sbin:/usr/local/munki:/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin:$PATH
#export EDITOR="usr/local/bin/mate -w"
export EDITOR='subl -w'
# Finished adapting your PATH environment variable for use with MacPorts.

# bash-completion
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

FIGNORE=".o:~:Application Scripts"
alias fcs="telnet 192.168.37.211"
alias log="~/bin/logtodayone.rb"

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

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
