#!/bin/sh

set -e

doas pacman -S --needed $(cat arch/packages)

