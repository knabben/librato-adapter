FROM golang:1.11 as builder

WORKDIR /go/src/istio.io

RUN git clone https://github.com/istio/istio.git istio
COPY . istio/mixer/adapter/librato/.

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -a -installsuffix cgo -v -o /go/bin/librato /go/src/istio.io/istio/mixer/adapter/librato/cmd/main.go

FROM alpine:3.8

WORKDIR /bin/
RUN apk --no-cache add ca-certificates

EXPOSE 50000
COPY --from=builder /go/bin/librato .

ENTRYPOINT [ "/bin/librato" ]
CMD [ "50000" ]

