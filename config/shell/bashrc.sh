# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# source global bash config (if exists)
if [ -e /etc/bash.bashrc ]; then
  source /etc/bash.bashrc
fi

PS1="\[\e[1;32m\]${debian_chroot:+($debian_chroot)}\u\[\e[0m\]@\[\e[1;32m\]\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\] \$ "

export PS1
export GDK_USE_XFT=1

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

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
