#!/bin/bash

my_version=$(dpkg-query -f '${Version}' -W 'discord' || echo "1")
download(){
	cd /etc/systemd/system/discord/
	wget 'https://discord.com/api/download/stable?platform=linux&format=deb' -O discord
	dpkg -i discord
	rm discord
	cd -
}

log(){
	logger -t Discord -p local7.info "$1" 
}

create_systemd_time(){
	mkdir /etc/systemd/system/discord
	cat <<-EOT > /etc/systemd/system/discord/discord@.timer
	[Unit]
	Description=Discord upgrades

	[Timer]
	OnBootSec=1min
	AccurancySec=1s
	Unit=discord.target
	EOT

	cat <<-EOT > /etc/systemd/system//discord/discord.service
	[Unit]
	Description=Discord upgrades

	[Service]
	Type=oneshot
	DefaultDependencies=no
	ExecStart=/etc/systemd/system/discord/discord.sh
	EOT
	cp $PWD/discord.sh /etc/systemd/system/discord/
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

