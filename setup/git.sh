#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_gpg() {
  echo_yellow ">>> Installing gpg ..."
  install_on_macos gpg
}

configure_git() {
  echo_yellow ">>> Configuring git ..."
  ln -fs "$BASEDIR/config/git/gitconfig" "$HOME/.gitconfig"
}

configure_git

