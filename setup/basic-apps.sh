#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_bitwarden() {
  echo_yellow ">>> Installing Bitwarden ..."
  brew_install bitwarden
  flatpak_install "com.bitwarden.desktop"
}

install_brave() {
  echo_yellow ">>> Installing Brave Browser ..."
  brew_install brave-browser
  is_not_executable brave && url_script_install "https://dl.brave.com/install.sh"
}

install_localsend() {
  echo_yellow ">>> Installing Localsend ..."
  brew_install localsend
  flatpak_install "org.localsend.localsend_app"
}

install_obsidian() {
  echo_yellow ">>> Installing Obsidian ..."
  brew_install obsidian
  flatpak_install "md.obsidian.Obsidian"
}

install_syncthing() {
  echo_yellow ">>> Installing Syncthing ..."
  brew_install syncthing
  dnf_install syncthing
  apt_install syncthing

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

