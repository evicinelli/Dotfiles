#! /bin/bash

SERVER_IP=192.168.1.197
MOUNT_DIR="/media/$(whoami)/Upnp Salotto"

# Assicurarsi che cartella /media/vic/Upnp Salotto sia presente
([[ -d "$MOUNT_DIR" ]] && echo "ok" || sudo mkdir "$MOUNT_DIR")

# Caricare i moduli del kernel per creare device con fs
sudo modprobe fuse

# Montare server Upnp in modo che sia visibile
sudo djmount -o allow_other "$MOUNT_DIR"

# Riavvio il server upnp, altrimenti nella cartella non si vedono i media (mah)
sleep 1
ssh root@"$SERVER_IP" 'service minidlna restart'

nautilus "$MOUNT_DIR" &
exit 0

# vim: ft=sh
