#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_gpg() {
  echo_yellow ">>> Installing gpg ..."
  is_macos && install__brew gnupg
}

configure_git() {
  echo_yellow ">>> Configuring git ..."
  ln -fs "$BASEDIR/config/git/gitconfig" "$HOME/.gitconfig"
}

install_gpg
configure_git

