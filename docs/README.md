![GitHub last commit](https://img.shields.io/github/last-commit/JoaoVictorLong/Discord-Linux)
![GitHub forks](https://img.shields.io/github/forks/JoaoVictorLong/Discord-Linux)
![GitHub Repo stars](https://img.shields.io/github/stars/JoaoVictorLong/Discord-Linux)
![Static Badge](https://img.shields.io/badge/linux-black?logo=linux)
![Static Badge](https://img.shields.io/badge/Discord-black?logo=discord)
[![Static Badge](https://img.shields.io/badge/linkedin-blue?logo=linkedin)](https://www.linkedin.com/in/joaovictorlong/)

## About
I created this script because Discord doesn't have repository to upgrade or download the application, so to be better doing this, I create this simple script.

## How used
You need just clone this repo and get it a permission, this can be:
`chmod 740 discord.sh`

I created a task on crontab to exec this script for me and I boot my system, you can do the same on your
1) Execution this command:
`crontab -e`
2) Add this line:
`@reboot "PATH OF THE SCRIPT"` -- I created on /usr/bin/discord

## How this work

This is just a simple BASH script. I made this in 10 minutos and may I will upgranding with new functionality in the future.
The program was right in Portuguese, but I will change to ingle.

