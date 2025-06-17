# A set of functions for manipulating fonts
font_normal () {
  echo -n -e "\033[0m"
}
font_red () {
  echo -n -e "\033[1;31m"
}
font_green () {
  echo -n -e "\033[1;32m"
}
font_blue () {
  echo -n -e "\033[1;34m"
}
font_yellow () {
  echo -n -e "\033[1;33m"
}

echo_red () {
  font_red; echo $@; font_normal
}
echo_green () {
  font_green; echo $@; font_normal
}
echo_blue () {
  font_blue; echo $@; font_normal
}
echo_yellow () {
  font_yellow; echo $@; font_normal
}

# Check if command is executable
# 0 is True, 1 is False -- 0 is a normal return code
is_executable () {
  [[ ! -z `command -v $1` ]] && return 0 || return 1
}
is_not_executable () {
  [[ -z `command -v $1` ]] && return 0 || return 1
}

# Do not use proxy in this shell session
noproxy () {
  unset http_proxy
  unset https_proxy
  unset ftp_proxy
  unset socks_proxy
  unset no_proxy
  unset HTTP_PROXY
  unset HTTPS_PROXY
  unset FTP_PROXY
  unset SOCKS_PROXY
  unset NO_PROXY
}

# System detection
is_macos () {
  [[ "$(uname)" == "Darwin" ]] && return 0 || return 1
}
is_linux () {
  [[ "$(uname)" == "Linux" ]] && return 0 || return 1
}

# extra yazi helper
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]
  then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

function sysupdate() {
  if (is_executable brew)
  then
    ulimit -Sn 65536 #need more file descriptors for brew
    brew update && brew outdated && brew upgrade
  fi
  if (is_executable apt-get)
  then
    sudo apt-get -y update
    sudo apt-get -y upgrade
    sudo apt-get -y dist-upgrade
  fi
  if (is_executable flatpak)
  then
    flatpak update -y
  fi
  if (is_executable pacman)
  then
    sudo pacman --noconfirm -Syu
  fi
  if (is_executable ya)
  then
    ya pkg upgrade
  fi
}
