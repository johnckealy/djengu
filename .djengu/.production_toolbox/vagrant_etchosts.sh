#!/bin/bash

# Remove any previously added Djengo entries
sed -i '/^# --- The following was added by Djengu ----$/,/^# --- ---- ---- ---- ---- ---- ---- ---- ---$/d' /etc/hosts

# Add the domains to the hosts file
export API_DOMAIN=`grep -P "API_URL" env/.env.prod | sed -e "s/^API_URL=https:\/\///"`
export ORIGIN_DOMAIN=`grep -P "ORIGIN_URL" env/.env.prod | sed -e "s/^ORIGIN_URL=https:\/\///"`
echo  >> /etc/hosts
echo "# --- The following was added by Djengu ----" >> /etc/hosts
echo "172.30.1.55   ${API_DOMAIN}" >> /etc/hosts
echo "172.30.1.55   ${ORIGIN_DOMAIN}" >> /etc/hosts
echo "# --- ---- ---- ---- ---- ---- ---- ---- ---" >> /etc/hosts

