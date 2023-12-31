#!/bin/bash

export BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source ${BASEDIR}/config/shell/shell-functions.sh


if [[ $# -lt 1 ]]; then
    echo "List of tasks:"
    echo
    for task in $(ls "$BASEDIR/setup")
    do
      if [[ "$task" != "_common.sh" ]]
      then
        echo -n "- "
        font_yellow
        echo "${task%.sh}"
        font_normal
      fi
    done
    exit 0
fi

for task in "$@"
do
  script="$BASEDIR/setup/$task.sh"
  if [[ ! -f "$script" ]]
  then
    echo_red "File '$script' does not exist."
    exit 1
  fi
  bash "$script"
done
echo_green "Done."

