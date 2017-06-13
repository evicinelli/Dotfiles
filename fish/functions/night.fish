function night
	/usr/bin/gsettings set org.gnome.desktop.interface gtk-theme 'United-Ubuntu-Dark' $argv;
	redshift-gtk -O 3000;
end
