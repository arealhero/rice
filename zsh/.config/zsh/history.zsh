#!/bin/zsh

function fzf-history()
{
  history 0 | fzf
}

zle -N fzf-history
bindkey '^r' fzf-history

HISTSIZE=10000000
SAVEHIST=10000000
export HISTTIMEFORMAT="%F %T "
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
unsetopt HIST_EXPIRE_DUPS_FIRST
unsetopt EXTENDED_HISTORY

