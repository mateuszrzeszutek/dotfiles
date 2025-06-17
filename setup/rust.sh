#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_rustup() {
  if (is_not_executable rustup)
  then
    echo_yellow ">>> Installing rustup ..."
    install__from_url "https://sh.rustup.rs" --no-modify-path
  fi
}

install_rustup

