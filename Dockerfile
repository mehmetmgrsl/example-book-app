FROM golang:1.18-alpine

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

ENV HTTP_PORT=8080
ENV HTTP_SERVER=0.0.0.0

RUN GOOS=linux GOARCH=amd64 go build -o example-book-app

ENTRYPOINT ["./example-book-app"]
