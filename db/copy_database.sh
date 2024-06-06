#!/bin/bash

# Variables
CONTAINER_NAME="postgres"
DB_USER="licentauser"
DB_NAME="licentadb"
BACKUP_PATH="/backup.sql"
HOST_BACKUP_PATH="/home/david/david/LICENTA/BE/db/backup_host.sql"

# Dump the database inside the container
if docker exec $CONTAINER_NAME pg_dump -U $DB_USER -d $DB_NAME --clean -f $BACKUP_PATH; then
   echo "Dump successful, copying to host..."

  # Copy the dump file to the host machine
  docker cp $CONTAINER_NAME:$BACKUP_PATH $HOST_BACKUP_PATH
  echo "Database dump completed and copied to $HOST_BACKUP_PATH"
else
  echo "failed to dump database"
fi
