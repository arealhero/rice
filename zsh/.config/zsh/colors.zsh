#!/bin/zsh

autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Load the pywal colorscheme
[ -f ~/.cache/wal/sequences ] && (cat ~/.cache/wal/sequences &)

# Load syntax highlighting; should be last.
source "$HOME/.local/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" 2>/dev/null

