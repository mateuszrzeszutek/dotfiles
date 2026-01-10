#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_sdkman() {
  if [[ ! -d "$HOME/.sdkman" ]]
  then
    echo_yellow ">>> Installing sdkman ..."
    install__from_url "https://get.sdkman.io"
  fi
}

install_java() {
  echo_yellow ">>> Installing Java and Gradle ..."
  source "${HOME}/.sdkman/bin/sdkman-init.sh"
  sdk install java
  sdk install gradle
}

install_intellij() {
  echo_yellow ">>> Installing IntelliJ IDEA ..."
  is_linux && install__flatpak "com.jetbrains.IntelliJ-IDEA-Community"
  is_macos && install__brew intellij-idea-ce
}

install_sdkman
install_java
install_intellij

