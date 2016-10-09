FROM 10.0.12.203:32000/golang:1.7-alpine

RUN mkdir -p /go/bin
COPY . /go/bin
WORKDIR /go/bin

# this will ideally be built by the ONBUILD below ;)
CMD ["push-router", "-c", "router-example.conf"]
