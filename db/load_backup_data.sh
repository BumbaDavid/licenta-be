#!/bin/bash

# Variables
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CONTAINER_NAME="postgres"
DB_USER="licentauser"
DB_NAME="licentadb"
HOST_BACKUP_PATH="$SCRIPT_DIR/backup_host.sql"
CONTAINER_BACKUP_PATH="/backup.sql"

# Copy the backup file from the host to the container
if docker cp $HOST_BACKUP_PATH $CONTAINER_NAME:$CONTAINER_BACKUP_PATH; then
    echo "Backup file copied to container, starting restore..."
    # Restore the database inside the container
    if docker exec $CONTAINER_NAME psql -U $DB_USER -d $DB_NAME -f $CONTAINER_BACKUP_PATH; then
        echo "Database restored from $HOST_BACKUP_PATH"
    else
        echo "Failed to restore database"
    fi
else
    echo "Failed to copy backup file to container"
fi
