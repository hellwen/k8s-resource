FROM 10.0.12.203:32000/golang:1.7-alpine

RUN mkdir -p /go/bin
COPY . /go/bin
WORKDIR /go/bin

ADD bootstrap.sh /bootstrap.sh
RUN chmod +x /bootstrap.sh

CMD ["/bootstrap.sh"]
