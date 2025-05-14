export EDITOR='nvim'
export GUI_EDITOR='nvim-qt'

if [[ -f "$HOME/.cargo/env" ]]
then
  . "$HOME/.cargo/env"
fi

export PATH="$PATH:$HOME/.local/bin"
