#!/usr/bin/env bash

$file="/home/vic/pCloudDrive/Documenti/Todo/todo.txt"

echo i
echo "---"
grep -i "$(date -I)" $file
