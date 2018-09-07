#! /bin/bash 

# Kill dunst
pkill dunst

# Do we have wal?
if [[ -e $HOME/.cache/wal/colors.sh ]]; then
    source "${HOME}/.cache/wal/colors.sh"

    # Start dunst with color sourced
    /usr/bin/dunst \
        -lb "${color0:=#444444}" \
        -nb "$color3" \
        -cb "$color2" \
        -lf "${color15:=#CCCCCC}" \
        -bf "$color15" \
        -cf "$color15" \
        -nf "$color15" \
        -fn "DejaVu Sans Mono 11" \
        -geometry "300x5-30+30" >/dev/null &
else
    /usr/bin/dunst >/dev/null &
fi

# vim: fdm=marker
