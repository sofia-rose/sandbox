.DEFAULT_GOAL := build

.PHONY: fmt vet build clean
fmt:
	go fmt ./...

vet: fmt
	go vet ./...

build: vet
	go build

run: build
	./hello_world

clean:
	go clean -x
