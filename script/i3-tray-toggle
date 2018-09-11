#! /bin/bash

I3CFG="$HOME/Dotfiles/i3/config"

[[ $(grep "tray_output" $I3CFG | grep -v "#") = "" ]] && sed -i "s/# tray_output none/tray_output none/" $I3CFG || sed -i "s/tray_output none/# tray_output none/" $I3CFG
i3 restart;
