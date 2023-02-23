#!/bin/zsh

function block-cursor() {
	echo -ne '\e[1 q'
}

function beam-cursor() {
	echo -ne '\e[5 q'
}

function zle-line-init () {
	zle -K viins	# Initiate `vi insert` as keymap.
	beam-cursor
}

# Change cursor shape for different vi modes.
function zle-keymap-select () {
	case $KEYMAP in
		vicmd) block-cursor;;		  # Block
		viins|main) beam-cursor;;	# Beam
	esac
}

# Edit line in vi with <C-e>
autoload edit-command-line

zle -N edit-command-line
zle -N zle-keymap-select
zle -N zle-line-init

bindkey -v
bindkey '^e' edit-command-line
bindkey "^?" backward-delete-char

# Use vi keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

export KEYTIMEOUT=1

beam-cursor 			# Use beam cursor on startup.
preexec() { beam-cursor ;}	# Use beam cursor for each new prompt.

