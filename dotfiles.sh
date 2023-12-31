#!/bin/bash

export BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source ${BASEDIR}/config/shell/shell-functions.sh

available_tasks=()
for task in $(ls "$BASEDIR/setup")
do
  if [[ "$task" != "_common.sh" ]]
  then
    available_tasks+=("${task%.sh}")
  fi
done

if [[ $# -lt 1 ]]
then
  echo "List of tasks:"
  echo
  for task in "${available_tasks[@]}"
  do
    echo -n "- "
    font_yellow
    echo "${task%.sh}"
    font_normal
  done
  exit 0
fi

tasks_to_do=($@)

if [[ $# == 1 ]] && [[ "$1" == "all" ]]
then
  tasks_to_do=(${available_tasks[@]})
fi

for task in "${tasks_to_do[@]}"
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

