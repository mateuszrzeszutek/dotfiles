#!/bin/bash

source "$BASEDIR/setup/_common.sh"

install_docker() {
  echo_yellow ">>> Installing docker ..."
  if (is_executable dnf)
  then
    sudo dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo
    dnf_install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    sudo systemctl enable --now docker
  fi
}

install_docker

