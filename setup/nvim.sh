#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_nvim() {
  echo_yellow ">>> Installing nvim ..."
  install_package neovim neovim-qt
}

configure_nvim() {
  echo_yellow ">>> Configuring nvim ..."
  mkdir -p "$HOME/.config/nvim"
  ln -fs "$BASEDIR/config/nvim/init.lua" "$HOME/.config/nvim/init.lua"
}

install_nvim
configure_nvim

