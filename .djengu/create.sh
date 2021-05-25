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
if ! which virtualenv &> /dev/null
then
    echo -e "${RED}----- virtualenv was not found! ------"
    echo -e "${NC}Djengu relies on python-virtualenv."
    echo -e "Please install it before continuing."
    exit
fi

flavours=("Basic Django/Quasar" "Django/Quasar with JWT Authentication") #"Static Quasar (with SSR)")
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

# Get the chosen flavour from version contol
if [[ ${FLAVOUR} = jwt ]]; then
    git fetch origin authentication
    git checkout authentication
elif [[ ${FLAVOUR} = basic ]]; then
    git checkout main
elif [[ ${FLAVOUR} = static ]]; then
    git checkout static-site
fi


# User inputs
echo
read -p "Pick a username: " SQL_USER
read -sp "Set an administrator password: " DJANGO_ADMIN_PASSWORD
echo
read -p "Set a database name: " SQL_DATABASE
read -sp "Set a database password: " SQL_PASSWORD
echo
echo -e  "Choose a frontend URL (e.g. ${BLUE}example.com${NC})\c:"
read -p ": " FRONTEND_URL
echo -e  "Choose a backend URL (${ORANGE}this must have the same apex"
echo -e  "domain as the frontend URL, e.g. ${BLUE}api.example.com${NC})\c:"
read -p ": " BACKEND_URL
echo
echo -e "${GREEN}Great! If you need to change these options"
echo "later, you'll find them in the env/ directory."
echo
echo -e "${ORANGE}We're now ready to set up Djengu. This"
echo "may a minute."
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
        envsubst < Vagrantfile_template > Vagrantfile;
        rm Vagrantfile_template
        envsubst < ".djengu/env_templates/.env.template.db" > "./env/.env.db";
        envsubst < ".djengu/env_templates/.env.template.dev" > "./env/.env.dev";
        envsubst < ".djengu/env_templates/.env.template.prod" > "./env/.env.prod";
        make build-dev
        break;;


        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

# Detach djengu's history from the new project
rm -rf .git/
git init

echo
echo -e "--------------------------------------------------------"
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

# Final set up steps
while true; do
    echo "The Djengo files can now safely be removed, but you"
    echo "should keep them if you wish to use the vagrant virtual"
    echo "machine for testing production."
    echo -e "${BLUE}"
    read -p "Remove them now? (Y/n) " yn
    case $yn in [Yy]* )
        rm -rf ./.djengu/
        echo "Files removed."
        break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
