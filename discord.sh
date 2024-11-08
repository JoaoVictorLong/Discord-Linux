#!/bin/bash

my_version=$(dpkg-query -f '${Version}' -W 'discord' || echo "1")
download(){
	cd /var/
	wget 'https://discord.com/api/download/stable?platform=linux&format=deb' -O discord
	dpkg -i discord
	rm discord
	cd -
}

log(){
	logger -t Discord -p local7.info "$1" 
}

create_systemd_time(){
	#create directorys to systemd and copy the file script to one place

	mkdir /usr/share/discord/
	cp $PWD/discord.sh /usr/share/discord
	# Create files to systemd timer and service
	cat <<-EOT > /etc/systemd/system/discord.timer
	[Unit]
	Description=Discord upgrades

	[Timer]
	OnBootSec=1min
	AccuracySec=1
	Unit=discord.service

	[Install]
	WantedBy=timers.target
	EOT

	cat <<-EOT > /etc/systemd/system/discord.service
	[Unit]
	Description=Discord upgrades

	[Service]
	Type=oneshot
	ExecStart=/usr/share/discord/discord.sh
	EOT
	systemctl enable discord.timer
	systemctl enable discord.service
}

if [[ $my_version == "1" ]]; then
	echo "You do not have Discord Installed"
	echo "Starting installation..."
	create_systemd_time
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

