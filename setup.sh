echo --------------------------- Creating separate docker network...
docker network create --subnet=192.16.0.0/24 monitoring_logging
echo --------------------------- Starting \(incl. pulling/building images\) ACTUAL containers...
docker-compose pull
docker-compose up -d --force-recreate --build
echo --------------------------- Output from 'docker ps'...
docker ps
echo ---------------------------
