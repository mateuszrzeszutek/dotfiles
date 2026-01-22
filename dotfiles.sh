#!/bin/bash

export BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${BASEDIR}"/setup/_common.sh

available_tasks=()
for task in "$BASEDIR"/setup/*
do
  task=$(basename "$task")
  if [[ "$task" != "_common.sh" ]]
  then
    available_tasks+=("${task%.sh}")
  fi
done

if [[ $# -lt 1 ]]
then
  echo "Usage $(basename "$0") [task] ..."
  echo
  echo "List of tasks:"
  for task in "${available_tasks[@]}"
  do
    echo -n "- "
    echo_blue "$task"
  done
  echo
  echo -n "Alternatively, use special task '"
  echo_blue -n "all"
  echo "' to run all of them."
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

