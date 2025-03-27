#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_yazi() {
  echo_yellow ">>> Installing yazi ..."
  install_on_linux yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide imagemagick
  install_on_macos yazi
  mkdir -p "$HOME/.config/yazi"
}

install_yazi_plugins() {
  echo_yellow '>>> Installing yazi addons ...'
  ya pack -a BennyOe/tokyo-night
  ya pack -a yazi-rs/plugins:git
}

configure_yazi() {
  echo_yellow '>>> Configuring yazi ...'
  mkdir -p "$HOME/.config/yazi"
  ln -fs "$BASEDIR/config/yazi/init.lua" "$HOME/.config/yazi/init.lua"
  ln -fs "$BASEDIR/config/yazi/yazi.toml" "$HOME/.config/yazi/yazi.toml"
  ln -fs "$BASEDIR/config/yazi/theme.toml" "$HOME/.config/yazi/theme.toml"
}

install_yazi
install_yazi_plugins
configure_yazi

