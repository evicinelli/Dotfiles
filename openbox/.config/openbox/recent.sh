#! /usr/bin/env bash
# Script that generates a openbox pipe menu to display recent files

IFS=$'\n'
FILES=$(find ~/ownCloud -type f -atime -2 -printf "%A+ %p\n" | sort | tac | cut -f 2- -d ' ' | grep -v "/home/vic/\..*" | grep -v ".git" | grep -v "Med.*/img/.*" | grep -v ".dropbox.*" | head -n 50)

# echo $FILES

echo "<openbox_pipe_menu>"
for f in $FILES; do
echo "<item label=\"_$(basename $f)\">
	<action name=\"Execute\">
		<command><![CDATA[xdg-open \"$f\"]]></command>
	</action>
</item>"
done
echo "</openbox_pipe_menu>"
