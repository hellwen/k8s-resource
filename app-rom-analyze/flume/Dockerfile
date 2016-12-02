FROM python:2.7.12-alpine

# Set the timezone
RUN apk --no-cache add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata

RUN mkdir -p /data

# Install git
RUN apk --no-cache add git gcc musl-dev

ENV APPVERSION 1.03

WORKDIR /data
RUN git clone http://10.0.12.104/dean/rom-flume.git -b $APPVERSION app && \
    cd app && \
    pip install --no-cache-dir -r requirements.txt

WORKDIR /data/app
CMD [ "python", "./rom_flume.py" ]
