#!/bin/bash

##Get the version of discord and with if it's alright installed
my_version=$(dpkg-query -f '${Version}' -W 'discord' 2> /dev/null || echo "1")

download(){
	#validar porque script nao consegue ir para o /var
	##scritp precisa ser rodado como root por conta do dpkg
	cd /var/
	wget 'https://discord.com/api/download/stable?platform=linux&format=deb' -O discord &> /dev/null 
	dpkg -i discord &> /dev/null
	rm discord
	cd -
}

# log(){
# 	logger -t Discord -p local7.info "$1" 
# }

create_systemd_time(){
	
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

	[Install]
	WantedBy=multi-user.target
	EOT
	systemctl daemon-reload && echo "Reload daemon systemd" || echo "Error on: systemctl daemon-reload"
	systemctl enable discord.timer && echo "Enable discord.timer" || echo "Error on: systemctl enable discord.timer"
	systemctl enable discord.service && echo "Enable discord.service" || echo "Error on: systemctl enable discord.service"
}

if [[ $my_version == "1" ]]; then
	echo "You do not have Discord Installed"
	echo "Starting download and installation..."
	create_systemd_time
	echo "this get some time...."
	download
	#copy scritp to discord directory
	cp $PWD/discord.sh /usr/share/discord
	echo "Discord installed"
	#log "Discord installed"
else
	valido=$(curl -s https://discord.com/api/download/stable?platform=linux | grep "$my_version")
	if [ -z "$valido" ]; then
		echo 'updating discord.....'
		download
		echo "update finilly"
		#log "update finilly"
	else
		echo "no update available"
		#log "no update available"
	fi
fi

