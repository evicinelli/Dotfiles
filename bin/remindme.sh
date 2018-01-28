#! /bin/bash

if [[ $# -gt 0 ]]; then
#    if [[ $1 -ne "^[0-9][0-9]:[0-9][0-9]" ]]; then
#	echo "Ancora non ci siamo"
#    else
	echo -e "Ok, alle $1 ti ricorderò di $2"
	at "$1" <<< "notify-send --urgency=critical \"REMINDME:\" \"$2\""
#    fi
else
    echo "Nulla di fatto"
fi
