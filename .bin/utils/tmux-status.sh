#! /bin/bash

DELIM="|"
function todos() {
    [[ BG == "dark" ]] && color_fg=colour0 || color_fg=colour15
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

    echo -ne "#[default]#[bg=$color, fg=$color_fg]$symbol#[default]"
}

function muuuuusic() {
    if [[ $(ps aux | grep "spotify" | wc -l) -gt 2 && $(playerctl status) == "Playing" ]]; then
        color=colour10
        printf "%s %.25s %s"  "#[bg=$color fg=colour0]" "$(playerctl -p spotify metadata -f "{{title}} - {{artist}}")" "#[default]"
    else
        print "$DELIM"
    fi
}

battery() {
    # acpi -V | head -n1 | cut -d"," -f2,3
    [[ $(cat /sys/class/power_supply/BAT0/status) == "Charging " ]] && bat_status="↑" || bat_status="↓"
    echo "$(cat /sys/class/power_supply/BAT0/capacity)% $bat_status"
}

echo "$(muuuuusic) $(battery) $DELIM $(date +%H:%M\ %a\ %d) $(todos)"
