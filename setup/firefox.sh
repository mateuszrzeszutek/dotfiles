#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_firefox() {
  if (is_not_executable firefox)
  then
    echo_yellow ">>> Installing firefox ..."
    install_package firefox
  fi
}

if (is_linux)
then
  FIREFOX_DIR="~/.mozilla/firefox"
elif (is_macos)
then
  FIREFOX_DIR="~/Library/Application Support/Firefox/Profiles/"
fi


# TODO: create a fresh profile


install_firefox()

