#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_yazi() {
  echo_yellow ">>> Installing yazi ..."
  install_on_linux yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide imagemagick
  install_on_macos yazi
  mkdir -p "$HOME/.config/yazi"
}

install_yazi_flavors() {
  echo_yellow '>>> Configuring yazi ...'
  mkdir -p "$HOME/.config/yazi/flavors"
  if [[ ! -d "$HOME/.config/yazi/flavors/tokyo-night.yazi" ]]
  then
    git clone https://github.com/BennyOe/tokyo-night.yazi.git "$HOME/.config/yazi/flavors/tokyo-night.yazi"
  fi
}

configure_yazi() {
  echo_yellow '>>> Configuring yazi ...'
  mkdir -p "$HOME/.config/yazi"
  ln -fs "$BASEDIR/config/yazi/theme.toml" "$HOME/.config/yazi/theme.toml"
}

install_yazi
install_yazi_flavors
configure_yazi

