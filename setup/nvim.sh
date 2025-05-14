#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_nvim() {
  echo_yellow ">>> Installing nvim and dependencies ..."
  # ripgrep is a fast, alternate grep implementation that's used in the nvim fuzzy finder
  install_with_brew neovim neovim-qt ripgrep luarocks
}

install_fonts() {
  echo ">>> Installing modded DejaVu Sans Mono fonts ..."
  if (is_macos)
  then
    install_with_brew font-dejavu-sans-mono-nerd-font
  else
    local temp_dir="$(mktemp -d)"
    pushd "$temp_dir"
    git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
    pushd nerd-fonts
    ./install.sh DejaVuSansMono
    popd
    popd
    rm -rf "$temp_dir"
  fi
}

configure_nvim() {
  echo_yellow ">>> Configuring nvim ..."
  mkdir -p "$HOME/.config/nvim"
  ln -fs "$BASEDIR/config/nvim/init.lua" "$HOME/.config/nvim/init.lua"
}

install_nvim
install_fonts
configure_nvim

