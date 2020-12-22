#! /bin/bash

function todos() {
	color="colour10"
	symbol='  '
	todos=$(todo ls | wc -l)
	urgent=$(todo urgent | wc -l)

	if [[ urgent -gt 0 ]]; then
		color="colour9"
		symbol=" $urgent "
	elif [[ todos -gt 0 ]]; then
		color="colour11"
		symbol=" $todos "
	fi

	echo -ne "#[default]#[bg=$color, fg=colour0]$symbol#[default]"
}

function muuuuusic() {
	if [[ $(ps aux | grep "spotify" | wc -l) -gt 2 ]]; then
		color=colour10
		printf '%s %.25s %s' "#[bg=$color fg=colour0]" "▶  $(playerctl -p spotify metadata -f '{{title}} - {{artist}}')" "#[default]"
	else
		echo "$DELIM"
	fi
}

function battery() {
	batteryTreshold=30
	if [[ -d /sys/class/power_supply/BAT0 ]]; then
		[[ $(cat /sys/class/power_supply/BAT0/status) == "Charging" ]] && bat_status="↑" && colorBg="colour6" colorFg="colour0" || bat_status="↓"
		[[ $(cat /sys/class/power_supply/BAT0/capacity) -le $batteryTreshold ]] && colorBg="colour9" && colorFg="colour0"
		echo "#[bg=$colorBg, fg=$colorFg] $(cat /sys/class/power_supply/BAT0/capacity)% $bat_status #[default]"
	else
		echo "#[fg=colour1]BAT offline#[default]"
	fi
}

function online() {
	nm-online -q -x
	status=$?
	[[ $status == 0 ]]  && echo "ONLINE" || echo "OFFLINE"
}

DELIM="|"

tmux set -g window-status-format "#[fg=$fg] #I #W "
tmux set -g status-bg "colour0"
tmux set -g status-fg "colour7"

status="${status}$(muuuuusic)"
status="${status} $(battery) $DELIM"
status="${status} $(online) $DELIM"
status="${status} $(date +%H:%M\ %a\ %d) "
status="${status}$(todos)"

echo "$status"
