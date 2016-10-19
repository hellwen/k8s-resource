#!/bin/bash

echo "########### delete something"
esql="delete from user where user = '';"
echo $esql && mysql -u root mysql -e "${esql}"
esql="delete from user where user = 'root' and host not in ('localhost', '127.0.0.1', '::1');"
echo $esql && mysql -u root mysql -e "${esql}"
esql="drop database if exists test"
echo $esql && mysql -u root mysql -e "${esql}"

echo "########### dba role"
esql="create role dba;"
echo $esql && mysql -u root mysql -e "${esql}"
esql="grant all on *.* to dba with grant option;"
echo $esql && mysql -u root mysql -e "${esql}"

echo "########### app role"
esql="create role app with admin dba;"
echo $esql && mysql -u root mysql -e "${esql}"

echo "########### dev role"
esql="create role dev with admin dba;"
echo $esql && mysql -u root mysql -e "${esql}"
esql="grant show databases on *.* to dev;"
echo $esql && mysql -u root mysql -e "${esql}"
esql="grant select on mysql.proc to dev;"
echo $esql && mysql -u root mysql -e "${esql}"
esql="grant select on mysql.func to dev;"
echo $esql && mysql -u root mysql -e "${esql}"

echo "########### dba user"
esql="create user dba_dean@localhost identified by 'dba_dean';"
echo $esql && mysql -u root mysql -e "${esql}"
esql="grant dba to dba_dean@localhost;"
echo $esql && mysql -u root mysql -e "${esql}"
esql="set default role dba for dba_dean@localhost;"
echo $esql && mysql -u root mysql -e "${esql}"

esql="create user dba_dean@'10.0.%' identified by 'dba_dean';"
echo $esql && mysql -u root mysql -e "${esql}"
esql="grant dba to dba_dean@'10.0.%';"
echo $esql && mysql -u root mysql -e "${esql}"
esql="set default role dba for dba_dean@'10.0.%';"
echo $esql && mysql -u root mysql -e "${esql}"

echo "########### app db"
if [ -n $APP_DB ]; then
    esql="create database ${APP_DB};"
    echo $esql && mysql -u root mysql -e "${esql}"
    esql="grant select, insert, update, delete, execute on ${APP_DB}.* to app;"
    echo $esql && mysql -u root mysql -e "${esql}"
fi

echo "########### app user"
if [ -n $APP_USER ] && [ -n $APP_PASSWD ]; then
    esql="create user ${APP_USER}@'172.%' identified by '${APP_PASSWD}';"
    echo $esql && mysql -u root mysql -e "${esql}"
    esql="grant app to ${APP_USER}@'172.%';"
    echo $esql && mysql -u root mysql -e "${esql}"
    esql="set default role app for ${APP_USER}@'172.%';"
    echo $esql && mysql -u root mysql -e "${esql}"
fi

echo "########### alter root password"
esql="set password = '*EDB7BBEC07CC2B54E35525EED940661891800F36';flush privileges;"
echo $esql && mysql -u root mysql -e "${esql}"
