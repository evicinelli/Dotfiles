#! /bin/bash

DELIM="|"

if [[ $BG == "dark" ]]; then
	bg=colour15
	fg=colour8
else
	bg=colour0
	fg=colour15
fi

tmux set -g status-fg $fg
tmux set -g status-bg $bg
tmux set -g window-status-format "#[fg=$fg] #I #W "

function todos() {
	color="colour10"
	symbol="   "
	todos=$(todo ls | wc -l)
	urgent=$(todo urgent | wc -l)

	if [[ urgent -gt 0 ]]; then
		color="colour9"
		symbol=" $urgent "
	elif [[ todos -gt 0 ]]; then
		color="colour11"
		symbol=" $todos "
	fi

	echo -ne "#[default]#[bg=$color, fg=$bg]$symbol#[default]"
}

function muuuuusic() {
	if [[ $(ps aux | grep "spotify" | wc -l) -gt 2 && $(playerctl status) == "Playing" ]]; then
		color=colour10
		printf "%s %s %.25s %s %s" "#[fg=$color]" $DELIM "$(playerctl -p spotify metadata -f "{{title}} - {{artist}}")" $DELIM "#[default]"
	else
		print "$DELIM"
	fi
}

battery() {
	# acpi -V | head -n1 | cut -d"," -f2,3
	[[ $(cat /sys/class/power_supply/BAT0/status) == "Charging " ]] && bat_status="↑" || bat_status="↓"
	echo "$(cat /sys/class/power_supply/BAT0/capacity)% $bat_status"
}

update_colors
echo "$(muuuuusic) $(battery) $DELIM $(date +%H:%M\ %a\ %d) $(todos)"
