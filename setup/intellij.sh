#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_intellij() {
  echo_yellow ">>> Installing IntelliJ IDEA ..."
  install_with_flatpak com.jetbrains.IntelliJ-IDEA-Community
}

install_intellij

