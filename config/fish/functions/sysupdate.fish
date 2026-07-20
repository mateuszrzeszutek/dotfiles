function __update_ollama
  curl -fsSL https://ollama.com/install.sh | sh
end

function __has -a executable
  return (command -v "$executable" >/dev/null)
end

function sysupdate --description "Update all system packages"
  __has brew    && brew update && brew outdated && brew upgrade
  __has dnf     && sudo dnf upgrade -y
  __has flatpak && flatpak update -y
  __has mise    && mise upgrade
  __has ollama  && __update_ollama
  __has pacman  && sudo pacman --noconfirm -Syu
  __has pi      && pi update --all
end
