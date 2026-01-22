#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_gpg() {
  echo_yellow ">>> Installing gpg ..."
  brew_install gnupg
}

configure_git() {
  echo_yellow ">>> Configuring git ..."
  link_config "$BASEDIR/config/git/gitconfig" "$HOME/.gitconfig"
}

install_gpg
configure_git

