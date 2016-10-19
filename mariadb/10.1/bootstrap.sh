#!/bin/bash

source /etc/profile

echo "########### init os"
/init.sh

echo "########### init & start mysql"
mkdir -p /data/mysql/data
mkdir -p /data/mysql/backup

cd $MYSQL_HOME/

echo "########### mysql_install_db"
./scripts/mysql_install_db --user=root

echo "########### mysql start"
./bin/mysqld_safe --user=root &
cat /data/mysql/data/mysql.err

sleep 10
echo "########### mysql prepare"
/usr/local/mysql-prepare.sh

echo "########### running..."
if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
