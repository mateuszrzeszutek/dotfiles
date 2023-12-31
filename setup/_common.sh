#!/bin/bash

source "$BASEDIR/config/shell/shell-functions.sh"

install_package() {
  install_on_macos "$@"
  install_on_linux "$@"
}

install_on_macos() {
  if (is_macos)
  then
    if (is_not_executable brew)
    then
      bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      brew analytics off
    fi

    brew install "$@"
  fi
}

install_on_linux() {
  if (is_linux)
  then
    sudo apt-get install -y "$@"
  fi
}

