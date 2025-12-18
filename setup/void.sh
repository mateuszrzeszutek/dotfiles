#!/bin/bash

source "$BASEDIR/setup/_common.sh"

# TODO change to VSCodium
install_void() {
  echo_yellow ">>> Installing Void editor ..."
  is_macos && install__brew void
  # TODO: install on linux -- brew or something else?
}

install_void_extensions() {
  local extensions=(cedricverlinden.cursor-dark
    fwcd.kotlin
    redhat.java
    tamasfe.even-better-toml
    visualstudioexptteam.intellicode-api-usage-examples
    visualstudioexptteam.vscodeintellicode
    vscjava.vscode-gradle
    vscjava.vscode-java-debug
    vscjava.vscode-java-dependency
    vscjava.vscode-java-pack
    vscjava.vscode-java-test
    vscjava.vscode-maven
    vscodevim.vim)
  for ext in "${extensions[@]}"
  do
    if (is_macos)
    then
      /Applications/Void.app/Contents/Resources/app/bin/void --install-extension "$ext"
    fi
    # TODO: linux executable
  done
}

install_void
install_void_extensions

