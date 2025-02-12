#!/usr/bin/env bash

if [ -t 1 ]; then
  exec zsh
fi

source /Users/arthurgehrke/.config/broot/launcher/bash/br
if [ -f $(brew --prefix)/etc/bash_completion ]; then source $(brew --prefix)/etc/bash_completion; fi
