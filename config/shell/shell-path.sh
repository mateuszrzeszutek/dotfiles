# user scripts and application directory
PATH=$PATH:$HOME/.local/bin
PATH=$PATH:$HOME/bin/scripts

# IDEs
if [[ -d $HOME/bin/idea ]]; then
  PATH=$PATH:$HOME/bin/idea/bin
fi

# Eclipse memory analyzer tool
if [[ -d $HOME/bin/mat ]]; then
  PATH=$PATH:$HOME/bin/mat
fi

# android sdk
if [[ -d $HOME/bin/android-sdk-linux ]]; then
  PATH=$PATH:$HOME/bin/android-sdk-linux/tools
fi

export PATH

