#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_yazi() {
  echo_yellow ">>> Installing yazi ..."
  install_with_brew yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide imagemagick
  mkdir -p "$HOME/.config/yazi"
}

install_yazi_plugins() {
  echo_yellow '>>> Installing yazi addons ...'
  ya pkg -a BennyOe/tokyo-night
  ya pkg -a yazi-rs/plugins:full-border
  ya pkg -a yazi-rs/plugins:git
  ya pkg -a yazi-rs/plugins:smart-enter
}

configure_yazi() {
  echo_yellow '>>> Configuring yazi ...'
  mkdir -p "$HOME/.config/yazi"
  ln -fs "$BASEDIR/config/yazi/init.lua" "$HOME/.config/yazi/init.lua"
  ln -fs "$BASEDIR/config/yazi/keymap.toml" "$HOME/.config/yazi/keymap.toml"
  ln -fs "$BASEDIR/config/yazi/theme.toml" "$HOME/.config/yazi/theme.toml"
  ln -fs "$BASEDIR/config/yazi/yazi.toml" "$HOME/.config/yazi/yazi.toml"
}

install_yazi
install_yazi_plugins
configure_yazi

