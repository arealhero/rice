#!/bin/sh

set -e

yes | pacman -S --needed $(cat packages)

