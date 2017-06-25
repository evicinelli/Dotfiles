function transfer
	curl -H "Max-Downloads: 3" -H "Max-Days: 1" --progress-bar --upload-file $argv https://transfer.sh/$argv
end