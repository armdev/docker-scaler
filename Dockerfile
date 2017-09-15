FROM golang:1.9.0-alpine3.6 as build
WORKDIR /go/src/github.com/thomasjpfan/docker-scaler
COPY . .
RUN go build -o docker-scaler .

FROM alpine:3.6
RUN apk add --no-cache tini

COPY --from=build /go/src/github.com/thomasjpfan/docker-scaler/docker-scaler /usr/local/bin/docker-scaler
RUN chmod +x /usr/local/bin/docker-scaler

EXPOSE 8080

ENTRYPOINT  ["/sbin/tini", "--"]
CMD ["docker-scaler"]