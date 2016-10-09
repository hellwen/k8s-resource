FROM 10.0.12.203:32000/golang:1.7-alpine

RUN apk --no-cache add git

ENV PUSH_SUBSYSTEM comet
ENV PUSH_MODULE push-comet

RUN mkdir -p /go/src/message-system
COPY message-system /go/src/message-system
RUN ln -s /go/src/message-system/$PUSH_MODULE /go/src/app

WORKDIR /go/src/app

RUN go-wrapper download && \
    go-wrapper install

ADD comet-example.conf /go/src/message-system/$PUSH_MODULE/comet-example.conf

RUN cp /go/src/message-system/$PUSH_MODULE/$PUSH_SUBSYSTEM-example.conf /go/bin && \
    cp /go/src/message-system/$PUSH_MODULE/$PUSH_SUBSYSTEM-log.xml /go/bin

#WORKDIR /go/bin

# this will ideally be built by the ONBUILD below ;)
CMD ["go-wrapper", "run", "-c", "comet-example.conf"]
