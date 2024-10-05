#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

RED="\[\e[1;31m\]"
BLUE="\[\e[1;34m\]"
WHITE="\[\e[1;37m\]"
RESET="\[\e[0m\]"

PS1="${WHITE}\@|${RESET}${RED}\u${RESET}${WHITE}\
:${RESET}${BLUE}\W${RESET}${WHITE}\$${RESET} "

# Start Hyprland
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
	exec Hyprland
fi

export XDG_CONFIG_HOME="$HOME/.config"
export QEMU_AUDIO_DRV=pa
