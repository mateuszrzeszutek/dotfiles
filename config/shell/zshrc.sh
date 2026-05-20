# History settings
HISTSIZE=1000
SAVEHIST=2000
setopt appendhistory

# don't beep
unsetopt beep

# Tools
export EDITOR='nvim'
alias e=nvim

# Fix GPG on MacOS
if [[ -z "$GPG_TTY" ]]
then
  export GPG_TTY="$(tty)"
fi

# Path
if [[ -f "$HOME/.local/bin" ]]
then
  export PATH="$PATH:$HOME/.local/bin"
fi
if [[ -f "/opt/homebrew/bin/brew" ]]
then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if (command -v mise >/dev/null)
then
  eval "$(mise activate zsh)"
fi

# Nice prompt
if (command -v starship >/dev/null)
then
  eval "$(starship init bash)"
fi
