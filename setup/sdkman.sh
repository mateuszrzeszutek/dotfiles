#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_sdkman() {
  if (is_not_executable sdk)
  then
    echo_yellow ">>> Installing sdkman ..."
    run_from_url "https://get.sdkman.io"
  fi
}

install_sdkman

