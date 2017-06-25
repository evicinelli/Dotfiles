function transfer
	curl --progress-bar --upload-file $argv https://transfer.sh/$argv
end