### Stage 1
FROM golang AS builder

WORKDIR /go/src/app
COPY ./go/src /go/src

RUN apt-get update && \
    apt-get install upx -y

RUN go mod init douglasavilak/desafioGo
RUN go install
RUN upx --brute ../../bin/desafioGo

### Stage 2
FROM scratch
WORKDIR /go/bin
COPY --from=builder /go/bin .
CMD ["./desafioGo"]