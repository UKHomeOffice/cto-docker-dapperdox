#!/usr/bin/env bash

docker run --rm \
    --name cto-dapperdox \
    -p3123:3123 \
    -e SPEC_FILENAME=uber/swagger.json \
    -e WAIT=1 \
    -v $PWD/example_specs:/go/bin/specs \
    -d cto-dapperdox:latest
