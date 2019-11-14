#! /bin/bash

function get_todo_from_file() {
    color="colour2"
    symbol="   "
    todos=$(cat ~/.todo/todo.txt | grep "due:$(date +%F)" | grep -v "^x" | wc -l)
    urgent=$(cat ~/.todo/todo.txt | grep "due:$(date +%F)" | grep -v "^x" | grep "^(" | wc -l)

    if [[ urgent -gt 0 ]]; then
        color="colour1"
    elif [[ todos -gt 0 ]]; then
        color="colour3"
    fi

    echo -ne "#[bg=$color]$symbol#[default]"
}

# Spotify
function muuuuusic() {
    if [[ $(ps aux | grep "spotify" | wc -l) -gt 2 ]]; then
        # Spotify is running
        bg="colour10"
        fg="colour0"
        #echo " #[bg=colour2 fg=colour0] $(playerctl status) $(playerctl metadata title) ($(playerctl metadata artist)) #[default]"
        [[ $(playerctl status) == "Playing" ]] && echo " #[bg=$bg fg=$fg] $(playerctl metadata title) #[default]"
    fi
    return 0
}

DELIM="/"

echo "$(muuuuusic) BAT:$(cat /sys/class/power_supply/BAT0/capacity)% $DELIM $(nm-online -t 0 && echo 'ONLINE' || echo 'OFFLINE') $DELIM VOL:$(amixer | grep Front | grep Playback | cut -d'%' -f1 | cut -d '[' -f2 | head -n2 | tail -n1)% #[bg=colour8 fg=colour15] $(date +%H:%M\ %a\ %d ) #[default]$(get_todo_from_file)"

# ∙ $([[ `playerctl status` -ne 'No players found' ]] && echo `playerctl artist` - `playerctl title` || echo "NP")"