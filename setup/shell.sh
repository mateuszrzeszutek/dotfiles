#!/bin/bash

source "$BASEDIR/setup/_common.sh"

configure_common_shell() {
  echo_yellow ">>> Configuring common shell settings ..."
  link_config "$BASEDIR/config/shell/shell-aliases.sh" "$HOME/.shell-aliases"
  link_config "$BASEDIR/config/shell/shell-env.sh" "$HOME/.shell-env"
  link_config "$BASEDIR/config/shell/shell-functions.sh" "$HOME/.shell-functions"
}

configure_bash() {
  echo_yellow ">>> Configuring bash ..."
  link_config "$BASEDIR/config/shell/bashrc" "$HOME/.bashrc"
}

configure_zsh() {
  echo_yellow ">>> Configuring zsh ..."
  link_config "$BASEDIR/config/shell/zshrc" "$HOME/.zshrc"
}

install_fish() {
  echo_yellow ">>> Installing fish ..."
  brew_install fish
  dnf_install fish
}

install_starship() {
  echo_yellow ">>> Installing starship ..."
  brew_install starship
  dnf_enable atim/starship && dnf_install starship
}

install_fastfetch() {
  echo_yellow ">>> Installing fastfetch ..."
  brew_install fastfetch
  dnf_install fastfetch
}

configure_fish() {
  echo_yellow ">>> Configuring fish ..."
  link_config "$BASEDIR/config/fish/config.fish" "$HOME/.config/fish/config.fish"
  link_config "$BASEDIR/config/fish/conf.d" "$HOME/.config/fish/conf.d"
  link_config "$BASEDIR/config/fish/functions" "$HOME/.config/fish/functions"
}

configure_starship() {
  echo_yellow ">>> Configuring starship ..."
  link_config "$BASEDIR/config/starship/starship.toml" "$HOME/.config/starship.toml"
}

configure_common_shell
configure_bash
configure_zsh

install_fish
install_starship
install_fastfetch
configure_fish
configure_starship

