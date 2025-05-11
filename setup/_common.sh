#!/bin/bash

source "$BASEDIR/config/shell/shell-functions.sh"

install_package() {
  install_on_macos "$@"
  install_on_linux "$@"
}

install_on_macos() {
  if (is_macos)
  then
    install_with_brew "$@"
  fi
}

install_with_brew() {
  if (is_not_executable brew)
  then
    install_on_linux build-essential procps curl file git

    run_from_url "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

    # make sure brew is on the PATH
    if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]
    then
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    else
      export PATH="$PATH:/opt/homebrew/bin"
    fi

    brew analytics off
  fi

  brew install "$@"
}

install_on_linux() {
  if (is_linux)
  then
    install_on_ubuntu "$@"
    install_on_arch "$@"
  fi
}

install_on_arch() {
  if (is_executable pacman)
  then
    sudo pacman --noconfirm -Sy "$@"
  fi
}

install_on_ubuntu() {
  if (is_executable apt-get)
  then
    sudo apt-get install -y "$@"
  fi
}

run_from_url() {
  local url="$1"
  shift
  if (is_executable curl)
  then
    bash -c "$(curl -fsSL "$url")" -- "$@"
  elif (is_executable wget)
  then
    bash -c "$(wget "$url" -O -)" -- "$@"
  fi
}

