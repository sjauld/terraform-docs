NAME        := terraform-docs
VENDOR      := segmentio
DESCRIPTION := Generate docs from Terraform modules
MAINTAINER  := Martin Etmajer <metmajer@getcloudnative.io>
URL         := https://github.com/$(VENDOR)/$(NAME)
LICENSE     := MIT

VERSION     := $(shell cat ./VERSION)

GOBUILD     := go build -ldflags "-X main.version=$(VERSION)"


.PHONY: all
all: clean deps build

.PHONY: authors
authors:
	git log --all --format='%aN <%cE>' | sort -u | egrep -v noreply > AUTHORS

.PHONY: build
build: authors deps build-darwin-amd64 build-freebsd-amd64 build-linux-amd64 build-windows-amd64

build-darwin-amd64:
	GOOS=darwin GOARCH=amd64 $(GOBUILD) -o bin/$(NAME)-v$(VERSION)-darwin-amd64

build-freebsd-amd64:
	GOOS=freebsd GOARCH=amd64 $(GOBUILD) -o bin/$(NAME)-v$(VERSION)-freebsd-amd64

build-linux-amd64:
	GOOS=linux GOARCH=amd64 $(GOBUILD) -o bin/$(NAME)-v$(VERSION)-linux-amd64

build-windows-amd64:
	GOOS=windows GOARCH=amd64 $(GOBUILD) -o bin/$(NAME)-v$(VERSION)-windows-amd64

.PHONY: clean
clean:
	rm -rf ./bin ./vendor

.PHONY: deps
deps:
	dep ensure
