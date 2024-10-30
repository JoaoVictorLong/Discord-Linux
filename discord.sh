#!/bin/bash

my_version=$(dpkg-query -f '${Version}' -W 'discord' || echo "1")
download(){
	wget 'https://discord.com/api/download/stable?platform=linux&format=deb' -O discord
	dpkg -i discord
	rm discord
}

if [[ $my_version == "1" ]]; then
	echo "Voce não tem o discord instalado"
	echo "Iniciando instalação..."
	download
else
	valido=$(curl -s https://discord.com/api/download/stable?platform=linux | grep "$my_version")
	if [ -z "$valido" ]; then
		echo 'Atualizando discord.....'
		download
		echo "atualização finalizada"
	else
		echo "sem atualizacao no momento"
	fi
fi

