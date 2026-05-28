export DOCKER_BUILDKIT := 1

IMAGE_REPO := feliperaposo
NAME := $(IMAGE_REPO)/protheus-dbaccess
VERSION := 24
MINOR_VERSION := 24.1.1.1

.PHONY: build release release_latest

build:
	docker image build --platform=linux/amd64 -t $(NAME):$(VERSION) -t $(NAME):$(MINOR_VERSION) -t $(NAME):latest .

release: build
	docker image push $(NAME):$(VERSION)
	docker image push $(NAME):$(MINOR_VERSION)

release_latest: release
	docker image push $(NAME):latest
