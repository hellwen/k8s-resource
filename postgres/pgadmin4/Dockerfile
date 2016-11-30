FROM python:3.5.2-alpine

# Set the timezone
RUN apk --no-cache add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata

RUN mkdir -p /data

# Install NodeJs
RUN apk --no-cache add git

WORKDIR /data
RUN git clone git://git.postgresql.org/git/pgadmin4.git && \
    cd pgadmin4 && \
    pip install --no-cache-dir -r requirements.txt && \
    cat >> web/config_local.py << EOF
# -*- coding: utf-8 -*-
from config import *
#设置你希望的IP，0.0.0.0表示不受限制，如果你只希望局域网内访问，请使用适当的局域网ip
DEFAULT_SERVER = '0.0.0.0'
#设置你希望的端口
DEFAULT_SERVER_PORT = 5050
EOF

RUN cd /data/pgadmin4 && \
    python web/pgAdmin4.py

EXPOSE 5050

WORKDIR /data/pgadmin4
CMD "python web/pgAdmin4.py"
