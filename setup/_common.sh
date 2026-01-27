#!/bin/bash

brew_install() {
  if (is_macos)
  then
    if (is_not_executable brew)
    then
      echo_yellow ">>> Installing homebrew ..."
      url_script_install "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

      # make sure brew is on the PATH
      if [[ -f "/opt/homebrew/bin/brew" ]]
      then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi

      brew analytics off
    fi

    brew install "$@"
  fi
}

flatpak_install() {
  if (is_linux)
  then
    if (is_not_executable flatpak)
    then
      echo_yellow ">>> Installing flatpak ..."
      apt_install flatpak
      dnf_install flatpak
    fi
    if (! flatpak remotes | grep flathub >/dev/null)
    then
      echo_yellow ">>> Adding flathub repo ..."
      sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    fi

    flatpak install "$@"
  fi
}

apt_install() {
  if (is_executable apt-get)
  then
    sudo apt-get install -y "$@"
  fi
}

dnf_install() {
  if (is_executable dnf)
  then
    sudo dnf install -y "$@"
  fi
}

dnf_enable() {
  if (is_executable dnf)
  then
    sudo dnf install -y dnf-plugins-core
    sudo dnf copr enable -y "$@"
  fi
}

url_script_install() {
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

link_config() {
  local src=$1
  local dst=$2
  mkdir -p "$(dirname $dst)"
  unlink "$dst"
  ln -fs "$src" "$dst"
}

is_executable () {
  [[ ! -z `command -v $1` ]] && return 0 || return 1
}
is_not_executable () {
  [[ -z `command -v $1` ]] && return 0 || return 1
}

is_macos () {
  [[ "$(uname)" == "Darwin" ]] && return 0 || return 1
}
is_linux () {
  [[ "$(uname)" == "Linux" ]] && return 0 || return 1
}

echo_red () {
  _font_red; echo $@; _font_normal
}
echo_green () {
  _font_green; echo $@; _font_normal
}
echo_blue () {
  _font_blue; echo $@; _font_normal
}
echo_yellow () {
  _font_yellow; echo $@; _font_normal
}

_font_normal () {
  echo -n -e "\033[0m"
}
_font_red () {
  echo -n -e "\033[1;31m"
}
_font_green () {
  echo -n -e "\033[1;32m"
}
_font_blue () {
  echo -n -e "\033[1;34m"
}
_font_yellow () {
  echo -n -e "\033[1;33m"
}

