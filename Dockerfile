FROM golang:1.9-alpine3.7 as go-builder
# this is the older, much more simpler web server
# ADD https://raw.githubusercontent.com/flaccid/golang-examples/master/httpstatic.go main.go
# RUN apk add --update --no-cache gcc musl-dev && \
#     CGO_ENABLED=0 go build -a -ldflags '-extldflags "-static"' -o httpstatic .
RUN apk add --update --no-cache git && \
    go get github.com/flaccid/httpstaticd/cmd/httpstaticd

FROM flaccid/s3fs
COPY --from=go-builder /go/bin/httpstaticd /usr/bin/httpstaticd
COPY docker-entrypoint.sh /opt/bin/docker-entrypoint.sh
ENTRYPOINT ["/opt/bin/docker-entrypoint.sh"]
WORKDIR /srv
CMD ["httpstaticd", "-d", "/srv"]
