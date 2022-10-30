#!/usr/bin/env bash

IMAGE=devenv-$1

docker run --rm -it -h dev -v $(pwd):/home/u/workspace $IMAGE
