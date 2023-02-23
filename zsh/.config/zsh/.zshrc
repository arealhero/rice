function source-if-exists()
{
	[ -f "$1" ] && source "$1"
}

function load-config ()
{
  source-if-exists "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/$1.zsh"
}

function load-shared-config ()
{
  source-if-exists "${XDG_CONFIG_HOME:-$HOME/.config}/shell/$1"
}

load-shared-config "env"
load-shared-config "aliasrc"
load-shared-config "shortcutrc"

load-config "completion"
load-config "vi-mode"
load-config "history"
load-config "colors"

setopt autocd
stty stop undef 	# Disable <C-s> to freeze terminal

