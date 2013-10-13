# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt
color_prompt=yes
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export PS1='\[\033[0;32m\]┌┼─┼─ \[\033[0m\033[0;32m\]\u\[\033[0m\] @ \[\033[0;36m\]$(hostname -f)\[\033[0m\033[0;32m\] ─┤├─ \[\033[0m\]\t \d\[\033[0;32m\] ─┤├─ \[\033[0;31m\]\w\[\033[0;32m\] ─┤>\[\033[0m\] '

# bash completion
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# colors
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# aliases
alias lll='ls -laF'
alias ll='ls -lF'
alias l='ls -F'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias free='free -m'
alias myxargs='perl -p -e "s/\n/\0/;" | xargs -0'

umask 022

