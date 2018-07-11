#! /bin/bash

if [[ $# -gt 0 ]]; then
    time=$1
    shift
    mess="$*"
	echo -e "Ok, alle $time ti ricorderò di $mess"
	at "$time" <<< "notify-send DUNST_COMMAND_RESUME && notify-send --urgency=critical \"REMINDME:\" \"$mess\""
else
    echo "Nulla di fatto"
fi
