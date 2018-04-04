#
# ~/.bashrc
#

[[ $- != *i* ]] && return

#colors() {
#	local fgc bgc vals seq0
#
#	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
#	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
#	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
#	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"
#
#	# foreground colors
#	for fgc in {30..37}; do
#		# background colors
#		for bgc in {40..47}; do
#			fgc=${fgc#37} # white
#			bgc=${bgc#40} # black
#
#			vals="${fgc:+$fgc;}${bgc}"
#			vals=${vals%%;}
#
#			seq0="${vals:+\e[${vals}m}"
#			printf "  %-9s" "${seq0:-(default)}"
#			printf " ${seq0}TEXT\e[m"
#			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
#		done
#		echo; echo
#	done
#}

[[ -f ~/.extend.bashrc ]] && . ~/.extend.bashrc

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
#screenfetch

#export TERM=screen-256color-bce
#export TERM=rxvt-unicode-256colors
export TERM=xterm-256color
#export TERM=rxvt-256color

test -s ~/.alias && . ~/.alias || true
