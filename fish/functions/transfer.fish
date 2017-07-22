function transfer
	touch tmpCurlStatus; curl -H "Max-Downloads: 3" -H "Max-Days: 1" --progress-bar --upload-file $argv https://transfer.sh/$argv >> tmpCurlStatus; cat tmpCurlStatus | qrencode -o qr.png; feh -xZ qr.png; cat tmpCurlStatus; rm -f tmpCurlStatus; rm -f qr.png
end
