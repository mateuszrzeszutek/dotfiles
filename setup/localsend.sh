#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_localsend() {
  echo_yellow ">>> Installing Localsend ..."
  install_on_macos localsend
  install_with_flatpak org.localsend.localsend_app
}

install_localsend

