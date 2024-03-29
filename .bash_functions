# vim: ft=sh
# vim: fdm=indent

cswp () {
	[[ $(ls ~/.local/share/nvim/swap/ | wc -l) -gt 0 ]] && rm -r ~/.local/share/nvim/swap/*
}

nack () {
	$EDITOR +Nack\ "$*"
}

# Ottobib not operational anymore as of 2022 :(
# isbn2bib () {
# 	echo
# 	BLOB="$(wget -qO- http://www.ottobib.com/isbn/$1/bibtex)"
# 	echo $BLOB | grep -o "@.*{.*}</textarea" | sed "s/<\/textarea//"| sed "s/}, /},\n\t/g" | sed "s/} }/}\n}/" | sed "s/, author/,\n\tauthor/"
# }

ding () {
	echo -e "\a"
	[[ ! -z $XDG_CURRENT_DESKTOP ]] && notify-send --urgency=critical "🔔  " "Ding!"
}

share-home-network () {
	echo "Home Network"
	qrencode --type=UTF8 -o - "WIFI:S:Network Casa Vicinelli;T:WPA;P:$(pass Casa/wifi | head -n 1);;"
	echo -e "\n\n Rete ospiti"
	echo "WIFI:S:Network Casa Vicinelli;T:WPA;P:$(pass Casa/wifi-ospiti | head -n 1);;" | qrencode --type=UTF8 -o -

}

tny () {
	[[ $# -gt 0 ]] && curl -F "shorten=$*" 0x0.st
}

wifi () {
	#nmcli -a device wifi connect 
	echo "$(nmcli --terse device wifi | cut -d: -f1,8- | sed "s/:/	/g" | fzf --query="$*" -1 --ansi --header-lines=1 | cut -f2)"
}

wttr () {
	CITY=$(echo '$*' | sed "s/ /+/g")
	#wget -qO - "https://wttr.in/~$CITY"
	curl "https://wttr.in/$*"
}

daysuntil () {
	echo "Giorni _interi_ rimanenti al $1: $(( ($(date "+%s" -d "$*") - $(date "+%s" -d "today")) / (60*60*24) ))"
}

# https://www.reddit.com/r/commandline/comments/hgayn8/stumbled_across_a_recipe_scraping_website_and/
plainoldrecipe () {
	curl -sG "https://plainoldrecipe.com/recipe" -d "url=${1}" | quarto pandoc -f html -t markdown
}

randint () {
	python -c "import random; print(random.randint(0, $1));"
}

calc () {
	if [[ $1 = "-a" ]] || [[ $1 = "--advanced" ]]; then
		python -ic 'import math'
	else
		awk "BEGIN{ print $*};"
	fi
}

dimbright () {
	sudo su -c "echo ${1:-50} > /sys/class/backlight/intel_backlight/brightness"
}

vimrc () {
	[[ $# -eq 0 ]] && $EDITOR ~/.config/vim/vimrc || $EDITOR ~/.config/vim/init/$1.vim
}
complete -W "$(ls ~/.config/vim/init/ | sed 's/\.vim//')" vimrc

fix-audio(){
	# sudo pkill pulseaudio && echo "PulseAudio killed" && pulseaudio --start && echo "PulseAudio restarted"
	pkill -9 pipewire && (pipewire; pipewire-alsa)
}

rtext(){
	t=$(mktemp); $EDITOR $t; pandoc $t -f markdown -t html | wl-copy
}
