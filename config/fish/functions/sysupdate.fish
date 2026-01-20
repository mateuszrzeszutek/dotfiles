function sysupdate
  if command -v brew >/dev/null
    ulimit -Sn 65536 #need more file descriptors for brew
    brew update && brew outdated && brew upgrade
  end
  if command -v apt-get >/dev/null
    sudo apt-get -y update
    sudo apt-get -y upgrade
    sudo apt-get -y dist-upgrade
  end
  if command -v dnf >/dev/null
    sudo dnf upgrade -y
  end
  if command -v flatpak >/dev/null
    flatpak update -y
  end
  if command -v pacman >/dev/null
    sudo pacman --noconfirm -Syu
  end
  if command -v ya >/dev/null
    ya pkg upgrade
  end
end
