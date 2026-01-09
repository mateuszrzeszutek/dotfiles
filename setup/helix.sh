#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_helix() {
  echo_yellow ">>> Installing helix..."
  is_executable brew &&\
   install__brew helix bash-language-server shellcheck
  is_executable dnf &&\
   install__dnf helix nodejs-bash-language-server shellcheck
}

configure_helix() {
  echo_yellow ">>> Configuring helix ..."
  mkdir -p "$HOME/.config/helix"
  ln -fs "$BASEDIR/config/helix/config.toml" "$HOME/.config/helix/config.toml"
  ln -fs "$BASEDIR/config/helix/languages.toml" "$HOME/.config/helix/languages.toml"
}

install_helix
configure_helix
