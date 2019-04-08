#! /bin/bash

echo $(redshift -p | grep -o ".[0-9]\+K")

echo "---"

if [[ $ARGOS_MENU_OPEN ]]; then
    redshift -p

    echo "---"

    echo "7000K | bash='redshift-gtk -O 7000' terminal='false'"
    echo "6000K | bash='redshift-gtk -O 6000' terminal='false'"
    echo "5000K | bash='redshift-gtk -O 5000' terminal='false'"
    echo "4000K | bash='redshift-gtk -O 4000' terminal='false'"
    echo "3000K | bash='redshift-gtk -O 3000' terminal='false'"
    echo "2000K | bash='redshift-gtk -O 2000' terminal='false'"
    echo "1000K | bash='redshift-gtk -O 1000' terminal='false'"

    echo "---"
    echo "Stop | bash='redshift-gtk -x' terminal='false'"
fi
