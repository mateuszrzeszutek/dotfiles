#!/bin/bash

source "$BASEDIR/config/shell/shell-functions.sh"

install__brew() {
  if (is_not_executable brew)
  then
    echo_yellow ">>> Installing homebrew ..."
    if (is_linux)
    then
      install__apt build-essential procps curl file git
    fi

    install__url "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

    # make sure brew is on the PATH
    if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]
    then
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
    if [[ -f "/opt/homebrew/bin/brew" ]]
    then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    brew analytics off
  fi

  ulimit -Sn 65536 #need more file descriptors for brew
  brew install "$@"
}

install__flatpak() {
  if (is_linux)
  then
    echo_yellow ">>> Installing flatpak ..."
    if (is_not_executable flatpak)
    then
      install__apt flatpak
      install__dnf flatpak
      sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    fi
    flatpak install "$@"
  fi
}

install__apt() {
  if (is_executable apt-get)
  then
    sudo apt-get install -y "$@"
  fi
}

install__dnf() {
  if (is_executable dnf)
  then
    sudo dnf install -y "$@"
  fi
}

install__from_url() {
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

