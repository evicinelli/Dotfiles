To make dark and light theme completely interchangeable, without any issue and with any TUI:

- Dark themes
	- Color  0: dark black
	- Color  7: dark white
	- Color  8: bright black
	- Color 15: bright white
	- Color 1..6 and 9..14: standard ANSI
- Light themes
	- Color  0: bright white
	- Color  7: bright black
	- Color  8: dark white
	- Color 15: dark black
	- Color 1..6 and 9..14: standard ANSI

So, for light themes:

| Old color | New color |
|---|---|
|Color 0 | Color 15 |
|Color 7 | Color 8 |
|Color 8 | Color 7 |
|Color 15 | Color 0 |
