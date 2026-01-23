#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_mise() {
  echo_yellow ">>> Installing mise ..."
  brew_install mise
  dnf_enable jdxcode/mise && dnf_install mise
}

configure_mise() {
  echo_yellow ">>> Configuring mise ..."
  link_config "$BASEDIR/config/mise/config.toml" "$HOME/.config/mise/config.toml"
  mise trust "$BASEDIR/config/mise/config.toml"
}

install_tools() {
  echo_yellow ">>> Installing mise tools ..."
  mise install
}

install_mise
configure_mise
install_tools

