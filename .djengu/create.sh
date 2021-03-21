#!/bin/bash
set -e

NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
RED='\033[0;31m'
BLUE='\033[0;94m'

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

if ! which make &> /dev/null
then
    echo -e "${RED}----- Make was not found! ------"
    echo -e "${NC}Djengu relies on the make command."
    echo -e "Please install it before continuing."
    exit
fi

flavours=("Basic Django/Quasar" "Django/Quasar with JWT Authentication" "Static Quasar (with SSR)")
select fav in "${flavours[@]}"; do
    case $fav in
        "Basic Django/Quasar")
            FLAVOUR=basic
	    break;;
    "Django/Quasar with JWT Authentication")
            FLAVOUR=jwt
	    break;;
    "Static Quasar (with SSR)")
            FLAVOUR=static
	    break;;
	"Quit")
	    echo "User requested exit"
	    exit;;
        *) echo "invalid option $REPLY";;
    esac
done

echo

read -p "Pick a username: " SQL_USER
read -sp "Set an administrator password: " DJANGO_ADMIN_PASSWORD
echo
read -p "Set a database name: " SQL_DATABASE
read -sp "Set a database password: " SQL_PASSWORD
echo
read -p "Choose a frontend URL (e.g. example.com): " FRONTEND_URL
read -p "Choose a backend URL (e.g. api.example.com): " BACKEND_URL
echo
echo -e "${GREEN}Great! If you need to change these options"
echo "later, you'll find them in the env/ directory."
echo
echo -e "${ORANGE}We're now ready to set up Djengu. This"
echo "may take a few minutes."
echo -e "${BLUE}"

export SQL_USER
export SQL_DATABASE
export SQL_PASSWORD
export DJANGO_ADMIN_PASSWORD
export FRONTEND_URL
export BACKEND_URL
export SECRET_KEY=`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c45`

while true; do
    read -p "Ready? (Y/n) " yn
    case $yn in [Yy]* )
        if [[ "${FLAVOUR}" = "jwt" ]]; then
            git checkout authentication
        elif [[ "${FLAVOUR}" = "static" ]]; then
            git checkout static-site
        fi
        envsubst < ".djengu/env_templates/.env.template.db" > "./env/.env.db";
        envsubst < ".djengu/env_templates/.env.template.dev" > "./env/.env.dev";
        envsubst < ".djengu/env_templates/.env.template.prod" > "./env/.env.prod";
        make build-dev
        break;;


        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo
echo "--------------------------------------------------------"
echo
echo -e "${GREEN}\n🚀 All done!"
echo
echo "Djengu has installed successfully. To understand the project"
echo "layout, please check out the documentation:"
echo
echo "https://github.com/johnckealy/djengu/blob/main/README.md"
echo
echo -e "${NC}NOTE: You'll notice that the ${ORANGE}env/${NC} folder is not under version"
echo -e "control, as adding it would expose passwords and other secrets."
echo -e "Use ${ORANGE}make encrypt-dotenv${NC} instead."
echo
echo "--------------------------------------------------------"
echo


while true; do
    read -p "The Djengo files are now redundant. Remove them? (Y/n) " yn
    case $yn in [Yy]* )
        echo "Files removed."
        break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
