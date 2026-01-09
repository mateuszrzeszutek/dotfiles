#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_helix() {
  echo_yellow ">>> Installing helix..."
  is_executable brew && install__brew helix
  is_executable dnf && install__dnf helix
}

configure_helix() {
  echo_yellow ">>> Configuring helix ..."
  mkdir -p "$HOME/.config/helix"
  ln -fs "$BASEDIR/config/helix/config.toml" "$HOME/.config/helix/config.toml"
}

install_helix
configure_helix
