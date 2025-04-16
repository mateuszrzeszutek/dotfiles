#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_kitty() {
  echo_yellow ">>> Installing kitty ..."
  if (is_not_executable kitty)
  then
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
      launch=n
  fi
}

configure_kitty() {
  echo_yellow ">>> Configuring kitty ..."
  mkdir -p "$HOME/.config/kitty"
  ln -fs "$BASEDIR/config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
}

install_kitty
configure_kitty

