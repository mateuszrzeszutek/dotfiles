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
      run_from_url "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
      # make sure brew is on the PATH
      export PATH="$PATH:/opt/homebrew/bin"
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

run_from_url() {
  local url="$1"
  if (is_executable curl)
  then
    bash -c "$(curl -fsSL "$url")"
  elif (is_executable wget)
  then
    bash -c "$(wget "$url" -O -)"
  fi
}

