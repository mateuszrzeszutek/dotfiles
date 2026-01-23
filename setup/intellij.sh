#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_intellij() {
  echo_yellow ">>> Installing IntelliJ IDEA ..."
  brew_install intellij-idea
  flatpak_install "com.jetbrains.IntelliJ-IDEA-Community"
}

install_intellij

