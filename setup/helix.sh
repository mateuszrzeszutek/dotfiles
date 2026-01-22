#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_helix() {
  echo_yellow ">>> Installing helix..."
  brew_install helix
  dnf_install helix
}

configure_helix() {
  echo_yellow ">>> Configuring helix ..."
  link_config "$BASEDIR/config/helix/config.toml" "$HOME/.config/helix/config.toml"
  link_config "$BASEDIR/config/helix/languages.toml" "$HOME/.config/helix/languages.toml"
}

install_helix
configure_helix
