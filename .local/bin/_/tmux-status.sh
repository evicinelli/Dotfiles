#! /bin/bash

function todos() {
	color="colour10"
	symbol="  "
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
		printf "%s %.25s %s" "#[bg=$color fg="colour7" ]" "▶  $(playerctl -p spotify metadata -f \"{{title}} - {{artist}}\")" "#[default]"
	else
		echo "$DELIM"
	fi
}

function battery() {
	colorFg=$fg
	batteryTreshold=30
	[[ $(cat /sys/class/power_supply/BAT0/status) == "Charging" ]] && bat_status="↑" && colorBg="colour6" colorFg="colour7" || bat_status="↓"
	[[ $(cat /sys/class/power_supply/BAT0/capacity) -le $batteryTreshold ]] && colorBg="colour9" && colorFg="colour7"
	echo "#[bg=$colorBg, fg=$colorFg] $(cat /sys/class/power_supply/BAT0/capacity)% $bat_status #[default]"
}

tmux set -g window-status-format "#[fg=$fg] #I #W "
tmux set -g status-bg "colour0"
tmux set -g status-fg "colour7"
echo "$(muuuuusic) $(battery) $DELIM $(date +%H:%M\ %a\ %d) $(todos)"
