function __update_kitty
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
    launch=n
end

function __has -a executable
  return (command -v "$executable" >/dev/null)
end

function sysupdate --description "Update all system packages"
  __has brew    && brew update && brew outdated && brew upgrade
  __has dnf     && sudo dnf upgrade -y
  __has flatpak && flatpak update -y
  __has kitty   && test "$(uname)" = "Linux" && __update_kitty
  __has mise    && mise upgrade
  __has pacman  && sudo pacman --noconfirm -Syu
  __has ya      && ya pkg upgrade
end
