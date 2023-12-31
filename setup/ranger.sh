#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_ranger() {
  echo_yellow ">>> Installing ranger ..."
  install_on_linux ranger atool w3m highlight mediainfo caca-utils
  install_on_macos ranger
}

configure_ranger() {
  echo_yellow '>>> Configuring ranger ...'
  mkdir -p "$HOME/.config/ranger"
  ln -fs "$BASEDIR/config/ranger/rc.conf" "$HOME/.config/ranger/rc.conf"
  ln -fs "$BASEDIR/config/ranger/rifle.conf" "$HOME/.config/ranger/rifle.conf"
}

install_ranger
configure_ranger

