#!/bin/bash
# Build targets
pushd ../
./mvnw install -DskipTests
popd