#!/bin/bash

source /etc/profile

echo "########### os init"
/init.sh

echo "########### pg init"
chown -R postgres:postgres $PG_HOME

chmod 755 /data
mkdir -p $PGDATA
chown -R postgres:postgres $PGDATA

if [ "${PG_INITDB}" == "true" ]; then
    echo "## pg initdb"
    gosu postgres pg_ctl initdb -D $PGDATA
fi

mv ${PG_HOME}/pg_hba.conf $PGDATA
mv ${PG_HOME}/postgresql.conf $PGDATA

chown postgres:postgres $PGDATA/*.conf

echo "########### pg config database & user"
echo "## start pg"
gosu postgres pg_ctl start -w -D $PGDATA -o "-c listen_addresses='localhost'"

echo "## create db"
gosu postgres psql postgres -p 5440 --username postgres <<-EOSQL
    CREATE DATABASE "$POSTGRES_DB";
EOSQL

echo "## create user"
gosu postgres psql postgres -p 5440 --username postgres <<-EOSQL
    CREATE USER "${POSTGRES_USER}" WITH PASSWORD '${POSTGRES_PASSWORD}';
    GRANT ALL PRIVILEGES ON DATABASE "${POSTGRES_DB}" to "${POSTGRES_USER}";
EOSQL

echo "## stop pg"
gosu postgres pg_ctl stop -w -D $PGDATA -m fast

echo "########### pg start"
gosu postgres pg_ctl start -w -D $PGDATA 

echo "########### going..."
while true; do sleep 1000; done;
