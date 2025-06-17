#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_localsend() {
  echo_yellow ">>> Installing Localsend ..."
  is_macos && install__brew localsend
  is_linux && install__flatpak "org.localsend.localsend_app"
}

install_localsend

