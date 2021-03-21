#!/bin/bash

# Remove any previously added Djengo entries
sed -i '/^# --- The following was added by Djengu ----$/,/^# --- ---- ---- ---- ---- ---- ---- ---- ---$/d' /etc/hosts

# Add the domains to the hosts file
# export HOST=`vagrant ssh -c "hostname -I | grep -oP '192+[.]\d+[.]\d+[.]\d+'"`
export API_DOMAIN=`grep -P "API_URL" env/.env.prod | sed -e "s/^API_URL=https:\/\///"`
export ORIGIN_DOMAIN=`grep -P "ORIGIN_URL" env/.env.prod | sed -e "s/^ORIGIN_URL=https:\/\///"`
echo  >> /etc/hosts
echo "# --- The following was added by Djengu ----" >> /etc/hosts
echo "${HOST}   ${API_DOMAIN}" >> /etc/hosts
echo "${HOST}   ${ORIGIN_DOMAIN}" >> /etc/hosts
echo "# --- ---- ---- ---- ---- ---- ---- ---- ---" >> /etc/hosts

