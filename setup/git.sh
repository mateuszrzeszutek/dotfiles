#!/bin/bash

source "$BASEDIR/setup/_common.sh"

configure_git() {
  echo_yellow ">>> Configuring git ..."
  ln -fs "$BASEDIR/config/git/gitconfig" "$HOME/.gitconfig"
}

configure_git

