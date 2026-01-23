export EDITOR='nvim'

# Fix GPG on MacOS
if [[ -z "$GPG_TTY" ]]
then
  export GPG_TTY="$(tty)"
fi

if [[ -f "/opt/homebrew/bin/brew" ]]
then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# History settings
HISTSIZE=1000
SAVEHIST=2000
setopt appendhistory

# don't beep
unsetopt beep
