#!/bin/bash

source "$BASEDIR/setup/_common.sh"

# Deps
source "$BASEDIR/setup/mise.sh"

install_ollama() {
  echo_yellow ">>> Installing ollama ..."
  if (is_not_executable ollama)
  then
    url_script_install "https://ollama.com/install.sh"
  fi
}

build_ollama_models() {
  echo_yellow ">>> Building ollama models ..."

  pushd "$(mktemp -d)"
  # TODO: template and system message
  cat > modelfile <<EOF
FROM qwen3.5:9b

PARAMETER num_ctx    32768
PARAMETER num_thread 8
PARAMETER num_batch  128
EOF
  ollama create qwen-custom -f modelfile
  popd
}

install_pi() {
  echo_yellow ">>> Installing pi ..."
  npm install -g --ignore-scripts @earendil-works/pi-coding-agent
}

install_pi_extensions() {
  echo_yellow ">>> Installing pi extensions ..."
  rtk init --agent pi --global
}

install_bubblewrap() {
  echo_yellow ">>> Installing bubblewrap (sandbox layer) ..."
  dnf_install bubblewrap
}

install_ollama
build_ollama_models
install_pi
install_pi_extensions
install_bubblewrap

