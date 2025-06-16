#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_kitty() {
  echo_yellow ">>> Installing kitty ..."
  if (is_macos)
  then
    install_on_macos kitty
  elif (is_not_executable kitty)
  then
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
      launch=n
  fi
}

configure_kitty() {
  echo_yellow ">>> Configuring kitty ..."
  mkdir -p "$HOME/.config/kitty"
  ln -fs "$BASEDIR/config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"

  if (is_linux)
  then
    mkdir -p "$HOME/.local/bin"
    ln -fs "$HOME/.local/kitty.app/bin/kitty" "$HOME/.local/bin/kitty"
    ln -fs "$HOME/.local/kitty.app/bin/kitten" "$HOME/.local/bin/kitten"
  fi
}

add_linux_desktop_icon() {
  if (is_linux)
  then
    echo_yellow ">>> Adding kitty desktop icons ..."

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

