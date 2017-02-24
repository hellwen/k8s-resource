FROM k8s-registry.zeusis.com:32000/golang:1.7-alpine

# Set the timezone
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && apk --no-cache add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk add --no-cache git && \
    cd $GOPATH/src/ && \
    git clone https://github.com/hellwen/kapacitor-alert-api.git app && \
    cd app && \
    go get -v -d && \
    go install -v

ENV MSG_TOS 0
ENV MSG_URL http://xx/alarm/send

EXPOSE 3000

CMD ["app"]
