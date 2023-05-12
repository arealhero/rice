#!/bin/sh

set -e

yes | pacman -Syy
yes | pacman -S archlinux-keyring
yes | pacman -Su
yes | pacman -S $(cat packages)

