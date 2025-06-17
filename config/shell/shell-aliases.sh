alias df='df -h'
alias du='du -h'
alias dua='du -s *'

# BSD, which MacOS is based upon handles output coloring using a different flag
if (is_macos)
then
  alias ls='ls -hG'
else
  alias ls='ls -h --color=auto --group-directories-first'
fi
alias l='ls'
alias lsd='ls -d */'
alias ll='ls -lhF'
alias la='ls -lahF'

alias e=nvim
alias ew=nvim-qt
