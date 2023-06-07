#!/bin/bash

# Copy jars to local directory
pushd ../
VERSION=$(./mvnw help:evaluate -Dexpression=project.version -q -DforceStdout)
cp spring-cloud-dataflow-server/target/spring-cloud-dataflow-server-"$VERSION".jar ./docker/spring-cloud-dataflow-server.jar
cp spring-cloud-skipper/spring-cloud-skipper-server/target/spring-cloud-skipper-server-"$VERSION".jar ./docker/spring-cloud-skipper-server.jar
popd

# Build dataflow-server
docker buildx build --platform linux/amd64,linux/arm64 -t ghcr.io/unchartedsoftware/pantera-dataflow-server:"$VERSION" -f Dockerfile-dataflow .

# Build skipper-server
docker buildx build --platform linux/amd64,linux/arm64 -t ghcr.io/unchartedsoftware/pantera-skipper-server:"$VERSION" -f Dockerfile-skipper .