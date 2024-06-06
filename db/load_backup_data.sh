#!/bin/bash

# Variables
CONTAINER_NAME="postgres"  # Replace with your actual container name or ID
DB_USER="licentauser" # Replace with your actual database username
DB_NAME="licentadb" # Replace with your actual database name
HOST_BACKUP_PATH="/home/david/david/LICENTA/BE/db/backup_host.sql" # Path to the backup file on the host machine
CONTAINER_BACKUP_PATH="/backup.sql" # Path inside the container where the backup will be copied

# Copy the backup file from the host to the container
docker cp $HOST_BACKUP_PATH $CONTAINER_NAME:$CONTAINER_BACKUP_PATH

# Restore the database inside the container
docker exec $CONTAINER_NAME psql -U $DB_USER -d $DB_NAME -f $CONTAINER_BACKUP_PATH

# Print completion message
echo "Database restored from $HOST_BACKUP_PATH"
