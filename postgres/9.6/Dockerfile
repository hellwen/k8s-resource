FROM 10.0.12.207:32000/centos:7.002
MAINTAINER Hellwen <hellwen.wu@gmail.com>

# explicitly set user/group IDs
RUN groupadd -r postgres --gid=1999 && useradd -r -g postgres --uid=1999 postgres

ENV LANG en_US.utf8

ENV PG_HOME /usr/local/pgsql
ENV PGDATA /data/pgdata

ENV PG_INITDB true

ENV POSTGRES_DB postgres
ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD postgres

VOLUME /data

ADD tarballs/postgresql-9.6.1-1-linux-x64-binaries.tar.gz /usr/local/
ADD pg_hba.conf $PG_HOME
ADD postgresql.conf $PG_HOME

RUN cd $PG_HOME && \
    echo "export PG_HOME=$PG_HOME" >> /etc/profile && \
    echo "export PATH=\${PATH}:\${PG_HOME}/bin" >> /etc/profile

# pg ports
EXPOSE 5440
# ssh ports
EXPOSE 2122

ENTRYPOINT ["/bootstrap.sh"]

ADD bootstrap.sh /bootstrap.sh
RUN chmod +x /bootstrap.sh
