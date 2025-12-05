#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_yazi() {
  echo_yellow ">>> Installing yazi ..."
  if (is_executable dnf)
  then
    # TODO enable dnf plugin or something?
    install__dnf dnf-plugins-core
    sudo dnf copr enable -y lihaohong/yazi
    install__dnf yazi
  else
    install__brew yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick
  fi
  mkdir -p "$HOME/.config/yazi"
}

install_yazi_plugins() {
  echo_yellow '>>> Installing yazi addons ...'
  ya pkg add BennyOe/tokyo-night
  ya pkg add yazi-rs/plugins:full-border
  ya pkg add yazi-rs/plugins:git
  ya pkg add yazi-rs/plugins:smart-enter
}

configure_yazi() {
  echo_yellow '>>> Configuring yazi ...'
  mkdir -p "$HOME/.config/yazi"
  ln -fs "$BASEDIR/config/yazi/init.lua" "$HOME/.config/yazi/init.lua"
  ln -fs "$BASEDIR/config/yazi/keymap.toml" "$HOME/.config/yazi/keymap.toml"
  ln -fs "$BASEDIR/config/yazi/theme.toml" "$HOME/.config/yazi/theme.toml"
  ln -fs "$BASEDIR/config/yazi/yazi.toml" "$HOME/.config/yazi/yazi.toml"
}

install_yazi
install_yazi_plugins
configure_yazi

