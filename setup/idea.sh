#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_idea() {
  echo_yellow ">>> Installing IntelliJ IDEA ..."
  brew_install intellij-idea
  flatpak_install "com.jetbrains.IntelliJ-IDEA-Ultimate"
}

configure_ideavim() {
  echo_yellow ">>> Configuring IdeaVim plugin ..."
  link_config "$BASEDIR/config/idea/ideavimrc" "$HOME/.ideavimrc"
}

install_idea
configure_ideavim

