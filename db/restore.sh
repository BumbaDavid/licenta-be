#!/bin/bash
set -e

function wait_for_postgres() {
    while ! pg_isready -h localhost -U "licentauser"; do
        echo "Waiting for PostgreSQL to start..."
        sleep 1
    done
}

echo "Starting the database initialization script..."
wait_for_postgres

echo "PostgreSQL is ready."

# Restore the dump file
pg_restore -U "$POSTGRES_USER" -d "$POSTGRES_DB" -v /docker-entrypoint-db.d/backup.sql

# Execute the original entrypoint script
exec docker-entrypoint.sh postgres
