.PHONY: build test

build: test
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags "-X main.revision=$(shell git describe --tags --always)"

test:
	go test $(go list ./... | grep -v /vendor/)
