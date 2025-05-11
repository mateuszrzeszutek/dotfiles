#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_nvim() {
  echo_yellow ">>> Installing nvim and dependencies ..."
  # ripgrep is a fast, alternate grep implementation that's used in the nvim fuzzy finder
  install_with_brew neovim neovim-qt ripgrep luarocks
}

install_fonts() {
  echo ">>> Installing modded DejaVu Sans Mono fonts ..."
  install_on_macos font-dejavu-sans-mono-nerd-font
  install_on_arch ttf-dejavu-nerd
  # TODO https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#option-7-install-script
  # # TODO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/DejaVuSansMono.zip
}

configure_nvim() {
  echo_yellow ">>> Configuring nvim ..."
  mkdir -p "$HOME/.config/nvim"
  ln -fs "$BASEDIR/config/nvim/init.lua" "$HOME/.config/nvim/init.lua"
}

install_nvim
install_fonts
configure_nvim

