#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_sdkman() {
  if [[ ! -d "$HOME/.sdkman" ]]
  then
    echo_yellow ">>> Installing sdkman ..."
    install__from_url "https://get.sdkman.io"
  fi
}

install_sdkman

