#!/bin/bash

SCRIPTPATH=$(which $0)
WMCTRLPATH=$(which wmctrl)
candidate=$1

set -x
set -e

function print_help {
  echo "$0 lets you run only one instance of the command provided"
  echo ""
  echo "Usage: $0 <command> [OPTIONS] [ARGS]"
  echo ""
  exit 1;
}

function failed {
  echo "$1"
  echo 
  print_help; 
}

function get_windows {
# make an array WINDIDS of <WIN>
  declare -a PIDS=$1
  declare -a WINIDS
  for pid in "${PIDS[@]}"
  do
	  WINDOWS+=$(wmctrl -ipl | awk -F'[ ]' -v pid="$PID" '$3==pid { print $1 }');
  done
}

function is_command {
	 [[ $(command -v $1) = $1 ]] && RES=0 || RES=1
	 return $RES
}

function tile_windows {
	declare -a WINDOWS=$1
	if [[ ! -v "${#WINDIS[@]}" ]]; then
		return 1
	fi
	declare -a WINIDS=$1
}

if [[ $# -lt 1 ]]; then
  echo "No <command> argument provided"
  print_help
fi

if ! is_command $WMCTRLPATH; then 
  failed "Required dependency missing. Install wmctrl and try again."
  exit 1
fi

is_command $canditate && PID=$(pgrep $candidate) || failed "$candidate is not a valid command."  

get_window_numbers $PID

if [[ "${#WINSIDS[@]}" > 0 ]]; then
  	exec wmctrl -R $WIN
else
	exec "$@"
fi
