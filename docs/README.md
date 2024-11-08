![GitHub last commit](https://img.shields.io/github/last-commit/JoaoVictorLong/Discord-Linux)
![GitHub forks](https://img.shields.io/github/forks/JoaoVictorLong/Discord-Linux)
![GitHub Repo stars](https://img.shields.io/github/stars/JoaoVictorLong/Discord-Linux)
![Static Badge](https://img.shields.io/badge/linux-black?logo=linux)
![Static Badge](https://img.shields.io/badge/Discord-black?logo=discord)
[![Static Badge](https://img.shields.io/badge/linkedin-blue?logo=linkedin)](https://www.linkedin.com/in/joaovictorlong/)

## About
I created this script because Discord doesn't offer a repository to easily upgrade or download the application. To make this process simpler, I created this script.

## How used
1) Clone this repository.
`git clone https://github.com/JoaoVictorLong/Discord-Linux`


2) Grant execute permissions to the script.
`chmod 740 discord.sh`

3) Run the script with:
`sudo ./discord.sh` 

The script will create a scheduled task in systemd, download Discord if it’s not installed, or update it if it’s already installed.

The script copies itself to the /usr/share/discord directory so that systemd knows where to locate it.

## Upgrade

The script sets up a systemd service and timer to automatically run one minute after each system boot, checking for updates.

## How this work

This is a simple Bash script that I initially developed in about 10 minutes. I may add new functionality in the future.
Currently, the program outputs messages in Portuguese, but I plan to translate it to English soon.