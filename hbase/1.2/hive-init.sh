#!/bin/bash

MASTER=hbase-0.${SERVICE}.${NAMESPACE}.svc.zeusis.com

echo "########### hive config"
cat << EOF > $HIVE_HOME/conf/hive-site.xml
<configuration>
    <property>
        <name>javax.jdo.option.ConnectionURL</name>
        <value>jdbc:mysql://mariadb.development.svc.zeusis.com:3310/hive</value> 
        <description>JDBC connect string for a JDBC metastore</description>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionDriverName</name>
        <value>com.mysql.jdbc.Driver</value>
        <description>Driver class name for a JDBC metastore</description>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionUserName</name>
        <value>hive</value>
        <description>Username to use against metastore database</description>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionPassword</name>
        <value>hive</value>
        <description>password to use against metastore database</description>
    </property>

    <property>
        <name>hive.metastore.warehouse.dir</name>
        <value>/hive/warehouse</value>
    </property>
    <property> 
        <name>hive.metastore.port</name>
        <value>9083</value>
    </property>
    <property> 
        <name>hive.metastore.uris</name>
        <value>thrift://${MASTER}:9083</value>
    </property>

    <property> 
        <name>hive.server2.thrift.port</name>
        <value>10000</value>
    </property>
</configuration>
EOF

echo "########### mysql init"
cd $HIVE_HOME
./bin/schematool -initSchema -dbType mysql

cat << EOF > $HIVE_HOME/conf/hive-env.sh
HADOOP_HOME=${HADOOP_HOME}
HIVE_CONF_DIR=${HIVE_HOME}/conf
EOF

#$HADOOP_HOME/bin/hdfs dfs -mkdir -p /hive/warehouse
#$HADOOP_HOME/bin/hdfs dfs -chown  -p /hive/warehouse
