#! /bin/bash

function get_todo_from_file() {
    color="colour2"
    symbol="●"
    todos=$(cat ~/.todo/todo.txt | grep "due:$(date +%F)" | grep -v "^x" | wc -l)
    urgent=$(cat ~/.todo/todo.txt | grep "due:$(date +%F)" | grep -v "^x" | grep "^(" | wc -l)

    if [[ urgent -gt 0 ]]; then
        color="colour1"
    elif [[ todos -gt 0 ]]; then
        color="colour3"
    fi

    echo "#[fg=$color bg=colour0] $symbol#[default]"
}

echo "BAT:$(cat /sys/class/power_supply/BAT0/capacity)% ∙ $(nm-online -t 0 && echo 'ONLINE' || echo 'OFFLINE') ∙ VOL:$(amixer | grep Front | grep Playback | cut -d'%' -f1 | cut -d '[' -f2 | head -n2 | tail -n1)% #[bg=colour8 fg=colour0] $(date +%H:%M\ %a\ %d ) $(get_todo_from_file)"

# ∙ $([[ `playerctl status` -ne 'No players found' ]] && echo `playerctl artist` - `playerctl title` || echo "NP")"
