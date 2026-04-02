#!/bin/bash

source "$BASEDIR/setup/_common.sh"

# Deps
source "$BASEDIR/setup/fonts.sh"

install_nvim() {
  echo_yellow ">>> Installing nvim and dependencies ..."
  brew_install neovim ripgrep luarocks
  dnf_install neovim ripgrep luarocks
}

configure_nvim() {
  echo_yellow ">>> Configuring nvim ..."
  link_config "$BASEDIR/config/nvim/init.lua" "$HOME/.config/nvim/init.lua"
  link_config "$BASEDIR/config/nvim/lazy-lock.json" "$HOME/.config/nvim/lazy-lock.json"
  link_config "$BASEDIR/config/nvim/lua" "$HOME/.config/nvim/lua"
}

install_nvim
configure_nvim

