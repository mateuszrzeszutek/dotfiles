export EDITOR='nvim'
export GUI_EDITOR='nvim-qt'

# Fix GPG on MacOS
if [[ -z "$GPG_TTY" ]]
then
  export GPG_TTY="$(tty)"
fi

export PATH="$PATH:$HOME/.local/bin"

# Homebrew
if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]
then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
if [[ -f "/opt/homebrew/bin/brew" ]]
then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Void editor on MacOS
if [[ -d "/Applications/Void.app/Contents/Resources/app/bin" ]]
then
  export PATH="$PATH:/Applications/Void.app/Contents/Resources/app/bin"
fi

if [[ -f "$HOME/.cargo/env" ]]
then
  . "$HOME/.cargo/env"
fi

if [[ -d "$HOME/.lmstudio/bin" ]]
then
  export PATH="$PATH:$HOME/.lmstudio/bin"
fi
