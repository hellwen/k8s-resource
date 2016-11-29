FROM 10.0.12.203:32000/alpine
# Pull base image
FROM alpine
MAINTAINER Andy Yuan <andy@ycn.cc>

# Set the timezone
RUN apk --no-cache add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata

# Install NodeJs
RUN apk --no-cache add nodejs && \
    npm install -g npm http-server

# Git
RUN apk --no-cache add git 

RUN mkdir -p /nodejs && \
    cd /nodejs && \
    git clone git@10.0.12.104:joey.zhou/Homer_Full_Version_AngularJS.git

WORKDIR /nodejs/aotuapp

EXPOSE 8080
CMD ["http-server"]
