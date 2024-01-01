#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_nvim() {
  echo_yellow ">>> Installing nvim and dependencies ..."
  # ripgrep is a fast, alternate grep implementation that's used in the nvim fuzzy finder
  install_package neovim neovim-qt ripgrep
}

configure_nvim() {
  echo_yellow ">>> Configuring nvim ..."
  mkdir -p "$HOME/.config/nvim"
  ln -fs "$BASEDIR/config/nvim/init.lua" "$HOME/.config/nvim/init.lua"
}

install_nvim
configure_nvim

