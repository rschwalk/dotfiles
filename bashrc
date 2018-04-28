# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

[[ $- != *i* ]] && return

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Setting Bash prompt.
export PS1="\[$(tput bold)\]\[$(tput setaf 4)\][\[$(tput setaf 3)\]\u\[$(tput setaf 7)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 4)\]\[$(tput setaf 4)\]]\\$ \[$(tput sgr0)\]"

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion


# My personal settings #

export EDITOR=nvim
export MAKEFLAGS='-j 4'

# alias python='/opt/python/bin/python3.5'
# alias pyvenv='/opt/python/bin/pyvenv-3.5'

export WORKON_HOME=$HOME/tools/venv   # optional
export PROJECT_HOME=$HOME/projects      # optional
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/bin/virtualenvwrapper.sh

# xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
screenfetch
#neofetch

#export TERM=screen-256color-bce
#export TERM=rxvt-unicode-256colors
#export TERM=konsole-256color
#export TERM=rxvt-256color

#alias tup='sudo zypper dup --no-allow-vendor-change'

test -s ~/.alias && . ~/.alias || true
