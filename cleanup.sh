#!/bin/bash

ERROR_MSG="Please choose the mode you ran the suite in: \\n a) Unsecure: sh cleanup.sh unsecure \\n b) Secure: sh cleanup.sh secure"

source `dirname $0`/.env
FLAVOR=${FLAVOR:-$1}

if [ -z "$FLAVOR" ]; then
  echo $ERROR_MSG
  exit 1
fi

cleanup_common() {
  echo "------------------------------------------------------------"
  echo "############################### Removing network..."
  echo "------------------------------------------------------------"
  docker network rm monitoring_logging

  echo "------------------------------------------------------------"
  echo "############################### Output from \'docker ps -a\'..."
  echo "------------------------------------------------------------"
  docker ps -a

  echo "------------------------------------------------------------"
  echo "############################### Output from \'docker volume ls\'..."
  echo "------------------------------------------------------------"
  docker volume ls

  echo "------------------------------------------------------------"
  echo "############################### Output from \'docker network ls\'..."
  echo "------------------------------------------------------------"
  docker network ls

  echo "------------------------------------------------------------"
  echo "############################### Finished. Everything's cleaned up."
  echo "------------------------------------------------------------"
}

case "$FLAVOR" in
  unsecure)
    echo "------------------------------------------------------------"
    echo "############################### Cleaning up suite that was run in UNSECURE mode..."
    echo "------------------------------------------------------------"

    echo "......"

    echo "------------------------------------------------------------"
    echo "############################### Stopping and removing containers..."
    echo "------------------------------------------------------------"
    docker-compose -f monitoring/docker-compose.unsecure.yml down -v
    docker-compose -f logging/docker-compose.unsecure.yml down -v

    cleanup_common
    ;;

  secure)
    echo "------------------------------------------------------------"
    echo "############################### Cleaning up suite that was run in SECURE mode..."
    echo "------------------------------------------------------------"

    echo "......"

    echo "------------------------------------------------------------"
    echo "############################### Stopping and removing containers..."
    echo "------------------------------------------------------------"
    docker-compose -f monitoring/docker-compose.secure.yml down -v
    docker-compose -f logging/docker-compose.secure.yml down -v
    docker-compose -f proxy.traefik/docker-compose.yml down -v

    cleanup_common
    ;;

  *)
    echo $ERROR_MSG
    exit 1
    ;;
esac
