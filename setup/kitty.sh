#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_kitty() {
  echo_yellow ">>> Installing kitty ..."
  brew_install kitty
  is_not_executable kitty &&\
    url_script_install "https://sw.kovidgoyal.net/kitty/installer.sh" launch=n
}

configure_kitty() {
  echo_yellow ">>> Configuring kitty ..."
  link_config "$BASEDIR/config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"

  if (is_linux)
  then
    link_config "$HOME/.local/kitty.app/bin/kitty" "$HOME/.local/bin/kitty"
    link_config "$HOME/.local/kitty.app/bin/kitten" "$HOME/.local/bin/kitten"
    export PATH="$PATH:$HOME/.local/bin"
  fi

  kitten themes 'Tokyo Night'
}

add_linux_desktop_icon() {
  if (is_linux)
  then
    echo_yellow ">>> Adding kitty desktop icons ..."

    mkdir -p "$HOME/.local/share/applications/"
    cp "$HOME/.local/kitty.app/share/applications/kitty.desktop" "$HOME/.local/share/applications/"
    cp "$HOME/.local/kitty.app/share/applications/kitty-open.desktop" "$HOME/.local/share/applications/"
    sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g"\
      "$HOME"/.local/share/applications/kitty*.desktop
    sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g"\
      "$HOME"/.local/share/applications/kitty*.desktop
    echo "kitty.desktop" > "$HOME/.config/xdg-terminals.list"
  fi
}

install_kitty
configure_kitty
add_linux_desktop_icon

