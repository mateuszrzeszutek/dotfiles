#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_sdkman() {
  if [[ ! -d "$HOME/.sdkman" ]]
  then
    echo_yellow ">>> Installing sdkman ..."
    url_script_install "https://get.sdkman.io"
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
  brew_install intellij-idea
  flatpak_install "com.jetbrains.IntelliJ-IDEA-Community"
}

install_sdkman
install_java
install_intellij

