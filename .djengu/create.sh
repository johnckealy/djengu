#!/bin/bash

NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
RED='\033[0;31m'

echo
echo " ____  _"
echo "|  _ \(_) ___ _ __   __ _ _   _ "
echo "| | | | |/ _ \ '_ \ / _  | | | | "
echo -e "${ORANGE}| |_| | |  __/ | | | (_| | |_| | "
echo "|____// |\___|_| |_|\__, |\__,_| "
echo "     |_/            |___/ "

echo
echo "Welcome to Djengu! To begin. we just need to "
echo "ask you to set a few basic configuration options."
echo -e "${NC}"


# vue=("Quasar" "Quit")
# select fav in "${vue[@]}"; do
#     case $fav in
#         "Quasar")
#             echo "You chose $fav!"
# 	    break;;
# 	"Quit")
# 	    echo "User requested exit"
# 	    exit;;
#         *) echo "invalid option $REPLY";;
#     esac
# done

read -p "Pick a username: " SQL_USER
read -p "Set an administrator password: " DJANGO_ADMIN_PASSWORD
read -p "Set a database name: " DJANGO_ADMIN_PASSWORD
read -p "Set a database password: " SQL_PASSWORD
read -p "Choose a frontend URL (e.g. example.com)" FRONTEND_URL
read -p "Choose a backend URL (e.g. api.example.com)" BACKEND_URL

echo -e "${NC}"
