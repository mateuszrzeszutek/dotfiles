#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_fonts() {
  echo_yellow ">>> Installing modded DejaVu Sans Mono fonts ..."
  if (is_macos)
  then
    brew_install font-dejavu-sans-mono-nerd-font
  elif (is_executable fc-list)
  then
    if (! (fc-list | grep DejaVuSansMNerd >/dev/null))
    then
      local temp_dir="$(mktemp -d)"
      pushd "$temp_dir"
      git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
      pushd nerd-fonts
      ./install.sh DejaVuSansMono
      popd
      popd
      rm -rf "$temp_dir"
    fi
  fi
}

install_fonts

