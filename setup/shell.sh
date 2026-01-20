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
    install__from_url "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
    popd
  fi

  echo_yellow ">>> Configuring zsh ..."
  ln -fs "$BASEDIR/config/shell/zshrc" "$HOME/.zshrc"
}

install_fish() {
  echo_yellow ">>> Installing fish ..."
  is_executable brew && install__brew fish
  is_executable dnf  && install__dnf  fish
}

install_starship() {
  echo_yellow ">>> Installing starship ..."
  is_executable brew && install__brew starship
  is_executable dnf  && dnf_enable atim/starship && install__dnf starship
}

configure_fish() {
  echo_yellow ">>> Configuring fish ..."
  link_config "$BASEDIR/config/fish/config.fish" "$HOME/.config/fish/config.fish"
  link_config "$BASEDIR/config/fish/conf.d" "$HOME/.config/fish/conf.d"
  link_config "$BASEDIR/config/fish/functions" "$HOME/.config/fish/functions"
}

configure_starship() {
  echo_yellow ">>> Configuring starship ..."
  link_config "$BASEDIR/config/starship/starship.toml" "$HOME/.config/starship.toml"
}

install_zsh
configure_common_shell
configure_bash
configure_zsh

install_fish
configure_fish
install_starship
configure_starship

