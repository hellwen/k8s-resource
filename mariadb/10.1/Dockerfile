FROM 10.0.12.203:32000/centos:7-onbuild.001
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# install package
ADD tarballs/mariadb-10.1.17-linux-glibc_214-x86_64.tar.gz /usr/local
ADD tarballs/percona-xtrabackup-2.3.2-1.el7.x86_64.rpm /usr/local

# install xtrabackup
RUN cd /usr/local && \
    yum localinstall -y percona-xtrabackup-2.3.2-1.el7.x86_64.rpm

# mysql
ENV MYSQL_HOME /usr/local/mysql

RUN cd /usr/local && \
    ln -s mariadb-10.1.17-linux-glibc_214-x86_64 mysql && \
    echo "export MYSQL_HOME=$MYSQL_HOME" >> /etc/profile && \
    echo "export PATH=$PATH:$MYSQL_HOME/bin" >> /etc/profile

ADD my.cnf /etc/my.cnf

ADD mysql-prepare.sh /usr/local/mysql-prepare.sh
ADD on-change.sh     /usr/local/on-change.sh
RUN chmod +x /usr/local/*.sh

# script
ADD bootstrap.sh /bootstrap.sh
RUN chmod +x /bootstrap.sh

ENTRYPOINT ["/bootstrap.sh"]

# Hdfs ports
EXPOSE 3310
