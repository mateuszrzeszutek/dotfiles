set -gx EDITOR "nvim"
set -gx GUI_EDITOR "nvim-qt"

# Fix GPG on MacOS
if test -z "$GPG_TTY"
  set -gx GPG_TTY "$(tty)"
end

fish_add_path -g --path "$HOME/.local/bin"

if test -f "/opt/homebrew/bin/brew"
  /opt/homebrew/bin/brew shellenv fish | source
end

if command -v mise >/dev/null
  mise activate fish | source
end

