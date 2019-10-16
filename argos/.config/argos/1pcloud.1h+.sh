#! /usr/bin/env bash
treshold=2 # grep + actual process

# At startup wait for pcloud to start
sleep 3

if [[ $(ps aux | grep -i "tmp.*pcloud" | wc -l) -gt $treshold ]]; then
    color=cyan
else
    color=red
fi

echo ":cloud: | color=$color size=15"
echo "---"

echo "pCloudDrive | iconName=folder-symbolic href='file:///home/vic/pCloudDrive'"
echo "pCloud Web | iconName=browser href='https://www.pcloud.com'"
echo "Shares | iconName=share-symbolic href='https://my.pcloud.com/#page=shares&tab=myshares-tab'"
echo "Rewind | iconName=reload-symbolic href='https://my.pcloud.com/#page=time' color=white"
echo "Trash | iconName=trash href='https://my.pcloud.com/#page=trash'"
#echo "pCloud | exec=/home/vic/Scaricati/Apps/pcloud"

