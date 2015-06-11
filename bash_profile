#=======================#
# RYAN MOON BASH_PROMPT #
#=======================#

#========#
# PROMPT #
#========#

if [ -z "$TMUX" ]; then
export PS1="🍕  \[\e[33;1m\]\T 📓 \[\e[31;1m\]\! \[\e[30;1m\]\$(airprompt) \[\e[32;1m\]\$(batterycharge) 📍 \[\e[35;1m\]\W  \[\e[37;1m\]\$(parse_git_branch) \n👾 \[\e[0m\] "
fi
if [ -n "$TMUX" ]; then
export PS1="🍕  \[\e[33;1m\]\T  📓  \[\e[31;1m\]\!📍  \[\e[35;1m\]\W \[\e[37;1m\]\$(parse_git_branch) \n👾  \[\e[0m\] "
fi

#======#
# PATH #
#======#

export PATH=/usr/local/bin:/usr/local/sbin:$HOME/bin:/opt/chefdk/bin:/opt/chefdk/embedded/bin:${HOME}/.chefdk/gem/ruby/2.1.0/bin:/usr/local/munki:/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin:/usr/local/google-cloud-sdk/bin:/usr/local/go/bin:/usr/local/opt/coreutils/libexec/gnubin:$PATH

#=======#
# COLOR #
#=======#

export CLICOLOR=1
export LSCOLORS=ExxxxxDxBxegedabxxacad
# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

#========#
# EDITOR #
#========#

export EDITOR=/usr/local/bin/subl

#=================#
# BASH COMPLETION #
#=================#

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi

## TO IGNORE ~/LIBRARY/APPLICATION\ SCRIPTS/ WHEN USING BASH COMPLETION
FIGNORE=".o:~:Application Scripts"

#============================#
# TMUXINATOR BASH COMPLETION #
#============================#

source ~/bin/tmuxinator.bash

#=======================#
# BASH HISTORY SETTINGS #
#=======================#

export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups:erasedups
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
shopt -s histappend # append new history items to .bash_history
export HISTIGNORE="&:[ ]*:clear"

#====#
# HH #
#====#

export HH_CONFIG=hicolor         # get more colors
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"   # mem/file sync
# if this is interactive shell, then bind hh to Ctrl-r
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hh \C-j"'; fi

#====================================#
# PUT CURRENT DIRECTORY IN SHELL TAB #
#====================================#

export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

#===========#
# FUNCTIONS #
#===========#

# PUSHOVER
function push {
    curl -s -F "token=$PUSHOVERTOKEN" \
    -F "user=$PUSHOVERUSER" \
    -F "title=iTerm2" \
    -F "message=$1" https://api.pushover.net/1/messages.json
}
# OPEN DIRECTORY D ISSUE
function odkiller {
    sudo kill $(ps -ax | grep opendirectoryd | head -1 | awk '{print $1}')
}
# FOR BATTERY STATUS IN PROMPT
function batterycharge {
    "$HOME/bin/batterycharge.sh"
}
# ADD HORIZONTAL LINE
rule() {
    printf -v _hr "%*s" $(tput cols) && echo ${_hr// /${1--}}
}
# COPY
copy() {
    if [[ $1 =~ ^-?[hH] ]]; then

        echo "Intelligently copies command results, text file, or raw text to"
        echo "OS X clipboard"
        echo
        echo "Usage: copy [command or text]"
        echo "  or pipe a command: [command] | copy"
        return
    fi

    local output
    local res=false
    local tmpfile="${TMPDIR}/copy.$RANDOM.txt"
    local msg=""

    if [[ $# == 0 ]]; then
        output=$(cat)
        msg="So, the input was copied to clipboard"
        res=true
    else
        local cmd=""
        for arg in $@; do
            cmd+="\"$(echo -en $arg|sed -E 's/"/\\"/g')\" "
        done
        output=$(eval "$cmd" 2> /dev/null)
        if [[ $? == 0 ]]; then
            msg="Results of command are in the clipboard"
            res=true
        else
            if [[ -f $1 ]]; then
                output=""
                for arg in $@; do
                    if [[ -f $arg ]]; then
                        type=`file "$arg"|grep -c text`
                        if [ $type -gt 0 ]; then
                            output+=$(cat $arg)
                            msg+="Contents of $arg are in the clipboard.\n"
                            res=true
                        else
                            msg+="File \"$arg\" is not plain text.\n"
                        fi
                    fi
                done
            else
                output=$@
                msg="Text copied to clipboard"
                res=true
            fi
        fi
    fi

    $res && echo -ne "$output" | pbcopy -Prefer txt
    echo -e "$msg"
}
# TO FIX HOMEBREW
function brewfix {
    "$HOME/bin/brew_fix.sh"
}

# OPEN ARGUMENT IN DASH
function dash() {
    open "dash://$*"
}

function dman() {
    open "dash://man:$*"
}


# GIT BRANCH
function parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo " 🔥"
}
function parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/📛  \1$(parse_git_dirty)/"
}

# IP ADDRESS WALRUS
function walrus {
    sudo "$HOME/bin/ip_walrus.sh"
}

# DISPLAY WIRELESS NETWORK IN BASH PROMPT
function airprompt() {
    "$HOME/bin/airprompt.sh"
}

# ADD CURRENT FOLDER TO ~/.GITLOGGER WITH NAME SPECIFIED AS ARGUMENT 1
# FOR USE WITH GITLOGGER.SH
function glog () {
    (echo "$1:`pwd`";grep -v "`pwd`$" ~/.gitlogger) | sort > ~/.gitlogger.tmp
    mv ~/.gitlogger.tmp ~/.gitlogger
}
# TREE WITH A PRETTY OUTPUT
ltree()
{
    tree -C $* | less -R
}

# NOT SURE WHAT THESE WERE FOR
# function cdo(){
#   msg=$*
#   GIT_DIR=$(git rev-parse --git-dir)
#   if ! (( $? )); then
#       GIT_DIR=$(echo "$GIT_DIR" | awk -F/ '{nlast = NF -1;print $nlast}')
#       if [ -z "$GIT_DIR" ]; then
#                 path=$(pwd)
#                 GIT_DIR=${path##*/}
#       fi
#             $HOME/bin/logtodayone.rb "@$GIT_DIR $msg"
#   fi

#   git commit -am "$msg"
# }

# git() {
#   cmd=$1
#   shift
#   extra=""

#   quoted_args=""
#   whitespace="[[:space:]]"
#   for i in "$@"
#   do
#       quoted_args="$quoted_args \"$i\""
#   done

#   cmdToRun="`which git` "$cmd" $quoted_args"
#   cmdToRun=`echo $cmdToRun | sed -e 's/^ *//' -e 's/ *$//'`
#   bash -c "$cmdToRun"
#   if [ $? -eq 0 ]; then
#     # Commit stats
#     if [ "$cmd" == "commit" ]; then
#       commit_hash=`git rev-parse HEAD`
#       repo_url=`git config --get remote.origin.url`
#       commit_date=`git log -1 --format=%cd`
#       commit_data="\"{ \"date\": \"$commit_date\", \"url\": \"$repo_url\", \"hash\": \"$commit_hash\" }\""
#       git-stats --record "$commit_data"
#     fi
#   fi
# }

#=========#
# ALIASES #
#=========#

alias b='bundle exec' # Save time for executing bundle exec
alias cd='cd ' # cd with the ability to use alias shortcuts
alias tdlist='/Users/moonr/Documents/GitHub-Ryan/cliist/cliist.py' # Alias for cliist
alias ct='pygmentize -O style=monokai -f console256 -g' # Pretty cat, requires sudo easy_install Pygments
alias dlog="usr/local/bin/logtodayone.rb" # Log to Day One
alias dsd='find . -name '*.DS_Store' -type f -delete'
alias ebp='subl $HOME/.bash_profile'
alias fuck='$(thefuck $(fc -ln -1))'
alias FUCK='fuck'
alias gaa='git add --all' # Git Add All
alias gc='git commit -asv' # Git Commit
alias gl='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
alias gpb='git push --set-upstream origin $(parse_git_branch | cut -c 4-)'
alias gs='git status' # Git Status
alias gt='cd $(git rev-parse --show-toplevel 2>/dev/null || (echo "."; echo "Not within a git repository" >&2))' # Get to the top level of a git repo
alias hgrep='history | grep '"${1}"'' # Search History
alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend' # Lock the screen
alias log='$HOME/bin/logtodayone.rb'
alias ls='ls -lahG' # How I prefer ls
alias png='ping -c 5' # Ping 5 times
alias sbp='source $HOME/.bash_profile' # Source the bash profile
alias vdf+='vagrant destroy -f && vagrant up'
alias vdf='vagrant destroy -f'
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
alias vpro='vagrant provision'
alias vs='vagrant status'
alias vuvb='vagrant up --provider virtualbox'
alias vuvf='vagrant up --provider vmware_fusion'

#===#
# Z #
#===#

. "$HOME/bin/z.sh"

#==========================#
# VAGRANT DEFAULT PROVIDER #
#==========================#

export VAGRANT_DEFAULT_PROVIDER=vmware_fusion

#==================#
# GOOGLE CLOUD SDK #
#==================#

source '/usr/local/bin/google-cloud-sdk/path.bash.inc'
source '/usr/local/bin/google-cloud-sdk/completion.bash.inc'

#===========#
# BREW CASK #
#===========#

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

#======#
# XIKI #
#======#

source ~/.xsh

#======================================#
# IDENTITY / KEY / PRIVATE INFO SOURCE #
#======================================#

#============================#
# GITHUB CHANGELOG GENERATOR #
#============================#

#====================#
# CHEF CONFIGURATION #
#====================#

source "$HOME/.moon-identities"


