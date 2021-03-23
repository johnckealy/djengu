# Create the Caddyfile
export HOST=`hostname -I | grep -oP "192+[.]\d+[.]\d+[.]\d+"`
export API_DOMAIN=`grep -P "API_URL" env/.env.prod | sed -e "s/^API_URL=https:\/\///"`
export ORIGIN_DOMAIN=`grep -P "ORIGIN_URL" env/.env.prod | sed -e "s/^ORIGIN_URL=https:\/\///"`
envsubst < "./.djengu/.production_toolbox/caddy/Caddyfile.template" > "./.djengu/.production_toolbox/caddy/Caddyfile"
vagrant ssh -c "cd /caddy/
                cp /djengu/.djengu/.production_toolbox/caddy/Caddyfile /caddy/Caddyfile
                docker-compose -f docker-compose.caddy.yml down -v && \
                docker-compose -f docker-compose.caddy.yml up --build -d"