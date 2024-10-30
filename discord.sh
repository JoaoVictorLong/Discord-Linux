#!/bin/bash

my_version=$(dpkg-query -f '${Version}' -W 'discord' || echo "1")
download(){
	wget 'https://discord.com/api/download/stable?platform=linux&format=deb' -O discord
	dpkg -i discord
	rm discord
}

log(){
	logger -t Discord -p local7.info "$1" 
}

if [[ $my_version == "1" ]]; then
	echo "You do not have Discord Installed"
	echo "Starting installation..."
	download
	echo "Discord installed"
	log "Discord installed"
else
	valido=$(curl -s https://discord.com/api/download/stable?platform=linux | grep "$my_version")
	if [ -z "$valido" ]; then
		echo 'updating discord.....'
		download
		echo "update finilly"
		log "update finilly"
	else
		echo "no update available"
		log "no update available"
	fi
fi

