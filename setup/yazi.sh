#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_yazi() {
  echo_yellow ">>> Installing yazi ..."
  dnf_enable lihaohong/yazi && dnf_install yazi
  brew_install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick
}

configure_yazi() {
  echo_yellow '>>> Configuring yazi ...'
  link_config "$BASEDIR/config/yazi/init.lua" "$HOME/.config/yazi/init.lua"
  link_config "$BASEDIR/config/yazi/keymap.toml" "$HOME/.config/yazi/keymap.toml"
  link_config "$BASEDIR/config/yazi/theme.toml" "$HOME/.config/yazi/theme.toml"
  link_config "$BASEDIR/config/yazi/yazi.toml" "$HOME/.config/yazi/yazi.toml"
}

install_yazi_plugins() {
  echo_yellow '>>> Installing yazi addons ...'
  ya pkg add BennyOe/tokyo-night
  ya pkg add yazi-rs/plugins:full-border
  ya pkg add yazi-rs/plugins:git
  ya pkg add yazi-rs/plugins:smart-enter
}

install_yazi
configure_yazi
install_yazi_plugins

