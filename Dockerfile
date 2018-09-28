FROM golang:1.9-alpine3.7 as go-builder

WORKDIR /tmp

ADD https://raw.githubusercontent.com/flaccid/golang-examples/master/httpstatic.go main.go

RUN apk add --update --no-cache gcc musl-dev && \
    CGO_ENABLED=0 go build -a -ldflags '-extldflags "-static"' -o httpstatic .

FROM flaccid/s3fs

COPY --from=go-builder /tmp/httpstatic /usr/bin/httpstatic

COPY docker-entrypoint.sh /opt/bin/docker-entrypoint.sh

ENTRYPOINT ["/opt/bin/docker-entrypoint.sh"]

WORKDIR /srv

CMD ["httpstatic", "-d", "/srv"]
