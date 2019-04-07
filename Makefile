REGISTRY_HOST=docker.io

# Release context
VERSION=0.0.1
IMAGE=aeliant/gunicorn
DOCKER_BUILD_CONTEXT=.
DOCKER_FILE_PATH=Dockerfile

# Tests context
IMAGE_TEST=gunicorn-testing
CONTAINER_NAME=testing-gunicorn
DOCKER_TEST_BUILD_CONTEXT=./tests/docker
DOCKER_TEST_FILE_PATH=./tests/docker/Dockerfile

SHELL=/bin/bash

.PHONY: build build-latest build-test push push-latest run-test tests

build:
	docker build $(DOCKER_BUILD_ARGS) -t $(IMAGE):$(VERSION) $(DOCKER_BUILD_CONTEXT) -f $(DOCKER_FILE_PATH)

build-latest:
	docker build $(DOCKER_BUILD_ARGS) -t $(IMAGE) $(DOCKER_BUILD_CONTEXT) -f $(DOCKER_FILE_PATH)

build-test:
	docker build $(DOCKER_BUILD_ARGS) -t $(IMAGE_TEST) $(DOCKER_TEST_BUILD_CONTEXT) -f $(DOCKER_TEST_FILE_PATH)

push:
	docker push $(IMAGE):$(VERSION)

push-latest:
	docker push $(IMAGE)

run-test:
	docker run -d -p 54300:8080 $(IMAGE_TEST)

run-latest:
	docker run -it $(IMAGE)

tests:
	pytest tests
