#!/bin/bash

pushd ../
VERSION=$(./mvnw help:evaluate -Dexpression=project.version -q -DforceStdout)
popd

# Build dataflow-server
docker buildx build --platform linux/amd64,linux/arm64 -t ghcr.io/unchartedsoftware/spring-cloud-dataflow-server:"$VERSION" -f Dockerfile-dataflow . --push

# Build skipper-server
docker buildx build --platform linux/amd64,linux/arm64 -t ghcr.io/unchartedsoftware/spring-cloud-skipper-server:"$VERSION" -f Dockerfile-skipper . --push