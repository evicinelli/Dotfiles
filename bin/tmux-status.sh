#! /bin/bash
echo "BAT:$(cat /sys/class/power_supply/BAT0/capacity)% ∙ $(nm-online -t 0 && echo 'ONLINE' || echo 'OFFLINE') ∙ VOL:$(amixer | grep Front | grep Playback | cut -d'%' -f1 | cut -d '[' -f2 | head -n2 | tail -n1)% #[bg=colour8 fg=colour0] $(date +%H:%M\ %a\ %d )"

# ∙ $([[ `playerctl status` -ne 'No players found' ]] && echo `playerctl artist` - `playerctl title` || echo "NP")"
