#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_zsh() {
  if (is_linux)
  then
    echo_yellow ">>> Installing zsh ..."
    install__apt zsh
    install__dnf zsh
    echo_yellow ">>> Setting zsh as default shell ..."
    chsh -s "$(which zsh)"
  fi
}

configure_common_shell() {
  echo_yellow ">>> Configuring common shell settings ..."
  ln -fs "$BASEDIR/config/shell/shell-aliases.sh" "$HOME/.shell-aliases"
  ln -fs "$BASEDIR/config/shell/shell-env.sh" "$HOME/.shell-env"
  ln -fs "$BASEDIR/config/shell/shell-functions.sh" "$HOME/.shell-functions"
}

configure_bash() {
  echo_yellow ">>> Configuring bash ..."
  ln -fs "$BASEDIR/config/shell/bashrc" "$HOME/.bashrc"
}

configure_zsh() {
  if [[ ! -e "$HOME/.oh-my-zsh" ]]; then
    echo_yellow '>>> Removing zsh config (if present) ...'
    unlink "$HOME/.zshrc"

    echo_yellow '>>> Downloading Oh-My-Zsh ...'
    pushd "$HOME"
    run_from_url "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
    popd
  fi

  echo_yellow ">>> Configuring zsh ..."
  ln -fs "$BASEDIR/config/shell/zshrc" "$HOME/.zshrc"
}

install_zsh
configure_common_shell
configure_bash
configure_zsh

