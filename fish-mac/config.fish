# Base16 Shell
# if status --is-interactive
#      set BASE16_SHELL "$HOME/.config/base16-shell/"
#      source "$BASE16_SHELL/profile_helper.fish"
# end

set -x PATH /opt/homebrew/bin /Users/rschwalk/bin $HOME/.cargo/bin /usr/local/share/dotnet $PATH
set -x LIBRARY_PATH /opt/homebrew/lib $LIBRARY_PATH

set -x LC_ALL en_US.UTF-8

set -x EDITOR nvim

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

# Fish should not add things to clipboard when killing
# See https://github.com/fish-shell/fish-shell/issues/772
set FISH_CLIPBOARD_CMD "cat"

function fish_user_key_bindings
	bind \cz 'fg>/dev/null ^/dev/null'
	if functions -q fzf_key_bindings
		fzf_key_bindings
	end
end

function fish_prompt
	set_color $fish_color_normal # foreground
	echo -n "["(date "+%H:%M")"] "
	set_color $fish_color_host # blue
	echo -n (hostname)
	if [ $PWD != $HOME ]
		set_color $fish_color_normal # foreground
		echo -n ':'
		set_color $fish_color_cwd # yellow
		echo -n (basename $PWD)
	end
	set_color $fish_color_user # green
	printf '%s ' (__fish_git_prompt)
	set_color $fish_color_prompt # red
	echo -n '| '
	set_color $fish_color_normal
end

function neomutt
    bash --login -c 'cd ~/Desktop; /usr/bin/neomutt' $argv;
end

#source $HOME/.cargo/env
source ~/.asdf/asdf.fish

