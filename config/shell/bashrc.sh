# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# In memory and file size
HISTSIZE=10000
HISTFILESIZE=2000000
# Append to the history file, don't overwrite it
shopt -s histappend
# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# Set time format
HISTTIMEFORMAT='%F %T '
# Multiple commands on one line show up as a single line
shopt -s cmdhist

# check the window size after each command and update if necessary
shopt -s checkwinsize

# Vi key bindings
set -o vi

# Editor shortcuts
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

# Mise
if (command -v mise >/dev/null)
then
  eval "$(mise activate bash)"
fi

# Nice prompt
if (command -v starship >/dev/null)
then
  eval "$(starship init bash)"
fi
