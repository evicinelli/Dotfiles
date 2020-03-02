#! /bin/bash

DELIM="|"
function get_todo_from_file() {
    color="colour10"
    symbol="   "
    todos=$(todo ls | wc -l)
    urgent=$(todo ls| grep -v "^x" | grep "^(" | wc -l)

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
    if [[ $(ps aux | grep "spotify" | wc -l) -gt 2 && $(playerctl status) == "Playing" ]]; then
        color=colour10
        printf "%s %.25s %s"  "#[bg=$color fg=colour0]" "$(playerctl metadata -f "{{title}} - {{artist}}")" "#[default]"
    else
        print "$DELIM"
    fi
}

battery() {
    # acpi -V | head -n1 | cut -d"," -f2,3
    [[ $(cat /sys/class/power_supply/BAT0/status) == "Charging " ]] && bat_status="▲" || bat_status="▼"
    echo "$(cat /sys/class/power_supply/BAT0/capacity)% $bat_status"
}

echo "$(muuuuusic) $(battery) $DELIM $(date +%H:%M\ %a\ %d) $(get_todo_from_file)"
