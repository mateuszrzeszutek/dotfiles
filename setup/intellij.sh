#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_intellij() {
  echo_yellow ">>> Installing IntelliJ IDEA ..."
  is_linux && install__flatpak "com.jetbrains.IntelliJ-IDEA-Community"
  is_macos && install__brew intellij-idea-ce
}

install_intellij

