#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_librewolf() {
  if (is_not_executable librewolf)
  then
    echo_yellow ">>> Installing librewolf ..."
    install_package librewolf
  fi
}

macos_clear_quarantine() {
  if (is_macos)
  then
    echo_yellow ">>> Removing quarantine attribute on librewolf ..."
    xattr -d com.apple.quarantine /Applications/LibreWolf.app
  fi
}

macos_enable_native_messaging() {
  if (is_macos)
  then
    if [[ -d "~/Library/Application Support/Mozilla/NativeMessagingHosts" ]]
    then
      echo_yellow ">>> Linking librewolf native messaging directory ..."
      ln -s "~/Library/Application Support/Mozilla/NativeMessagingHosts" "~/Library/Application Support/LibreWolf/NativeMessagingHosts"
    fi
  fi
}

configure_librewolf() {
  echo_yellow ">>> Configuring LibreWolf ..."
  mkdir -p "$HOME/.librewolf/"
  ln -fs "$BASEDIR/config/librewolf/librewolf.overrides.cfg" "$HOME/.librewolf/librewolf.overrides.cfg"
}

install_librewolf
macos_clear_quarantine
macos_enable_native_messaging
configure_librewolf

