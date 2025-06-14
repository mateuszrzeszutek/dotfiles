export EDITOR='nvim'
export GUI_EDITOR='nvim-qt'

if [[ -f "$HOME/.cargo/env" ]]
then
  . "$HOME/.cargo/env"
fi

# Fix GPG on MacOS
if [[ -z "$GPG_TTY" ]]
then
  export GPG_TTY="$(tty)"
fi

## PATH

export PATH="$PATH:$HOME/.local/bin"

# Void editor on MacOS
if [[ -d "/Applications/Void.app/Contents/Resources/app/bin" ]]
then
  export PATH="$PATH:/Applications/Void.app/Contents/Resources/app/bin"
fi

if [[ -d "$HOME/.lmstudio/bin" ]]
then
  export PATH="$PATH:$HOME/.lmstudio/bin"
fi
