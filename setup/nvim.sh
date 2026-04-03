#!/bin/bash

source "$BASEDIR/setup/_common.sh"

# Deps
source "$BASEDIR/setup/fonts.sh"
source "$BASEDIR/setup/mise.sh"

configure_nvim() {
  echo_yellow ">>> Configuring nvim ..."
  link_config "$BASEDIR/config/nvim/init.lua" "$HOME/.config/nvim/init.lua"
  link_config "$BASEDIR/config/nvim/nvim-pack-lock.json" "$HOME/.config/nvim/nvim-pack-lock.json"
  link_config "$BASEDIR/config/nvim/lua" "$HOME/.config/nvim/lua"
}

configure_nvim

