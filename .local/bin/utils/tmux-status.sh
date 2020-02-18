#! /bin/bash

function get_todo_from_file() {
    color="colour2"
    symbol="   "
    todos=$(todo ls | wc -l)
    urgent=$(todo ls| grep -v "^x" | grep "^(" | wc -l)

    if [[ urgent -gt 0 ]]; then
        color="colour1"
        symbol=" $urgent "
    elif [[ todos -gt 0 ]]; then
        color="colour3"
        symbol=" $todos "
    fi

    echo -ne "#[default]#[bg=$color, fg=colour0]$symbol#[default]"
}

function muuuuusic() {
    if [[ $(ps aux | grep "spotify" | wc -l) -gt 2 && $(playerctl status) == "Playing" ]]; then
        printf "%s %.25s %s"  "#[bg=colour10 fg=colour0]" "$(playerctl metadata -f "{{title}} - {{artist}}")" "#[default]"
    else
        printf "|"
    fi
    return 0
}

battery() {
    acpi -V | head -n1 | cut -d"," -f2,3
}

DELIM="|"
echo "$(muuuuusic) $(battery) $DELIM $(date +%H:%M\ %a\ %d) $(get_todo_from_file)"
