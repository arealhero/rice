#!/bin/sh

set -e

yay -S --needed $(cat arch/packages)

