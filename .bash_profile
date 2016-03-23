# .bash_profile
# By Yongheng Lin (yongheng.lin@gmail.com)

# References:
# https://github.com/mathiasbynens/dotfiles
# https://github.com/necolas/dotfiles
# /etc/skel/.bashrc on Ubuntu 12.04 LTS

# Concepts:
# http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html

# =====================================
# Detect OS

osname=$(uname)
osname=${osname:0:6}
if [[ "$osname" == 'Linux' ]]; then
	export OS='linux'
elif [[ "$osname" == 'Darwin' ]]; then
	export OS='osx'
elif [[ "$osname" == 'CYGWIN' ]]; then
	export OS='cygwin'
else
	export OS='unknown'
fi
unset osname

# =====================================
# Fix tmux

# fix terminal in tmux
[ -n "$TMUX" ] && export TERM=screen-256color

# =====================================
# Load

for file in $HOME/.{bash_prompt,bash_paths,bash_aliases,bash_custom}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# =====================================
# History

# don't put duplicate lines or lines starting with space in the history.
# see bash(1) for more options
# HISTCONTROL=ignoreboth
export HISTCONTROL=ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=5000
export HISTFILESIZE=5000

# after each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# =====================================
# Colors

# ls colors
export CLICOLOR=1
export LS_OPTIONS='--color=auto'

# grep colors
# export GREP_OPTIONS='--color=auto'

# man page colors
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# =====================================
# Miscellaneous

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# prefer US English and UTF-8
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
