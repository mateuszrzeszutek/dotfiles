#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_bitwarden() {
  echo_yellow ">>> Installing Bitwarden ..."
  is_macos && install__brew bitwarden
  is_linux && install__flatpak "com.bitwarden.desktop"
}

install_brave() {
  echo_yellow ">>> Installing Brave Browser ..."
  is_macos && install__brew brave-browser
  is_linux &&\
    is_not_executable brave &&\
    install__from_url "https://dl.brave.com/install.sh"
}

install_localsend() {
  echo_yellow ">>> Installing Localsend ..."
  is_macos && install__brew localsend
  is_linux && install__flatpak "org.localsend.localsend_app"
}

install_obsidian() {
  echo_yellow ">>> Installing Obsidian ..."
  is_macos && install__brew obsidian
  is_linux && install__flatpak "md.obsidian.Obsidian"
}

install_syncthing() {
  echo_yellow ">>> Installing Syncthing ..."
  is_macos && install__brew syncthing
  install__dnf syncthing
  install__apt syncthing

  echo_yellow ">>> Starting Syncthing service ..."
  if is_macos
  then
    brew services restart syncthing
  elif is_linux
  then
    systemctl --user enable --now syncthing.service
  fi
}

install_bitwarden
install_brave
install_localsend
install_obsidian
install_syncthing

