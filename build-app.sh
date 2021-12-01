#!/usr/bin/env bash

DIR="$( cd "$(dirname "$0")" ; pwd -P )"
DOCKER_FILE=Dockerfile.app

sourceImage="hillliu/django-slim:app"

build() {
  sourceImage=$sourceImage DOCKER_FILE=${DOCKER_FILE} $DIR/compile.sh b
}

push() {
  sourceImage=$sourceImage DOCKER_FILE=${DOCKER_FILE} $DIR/compile.sh p app 
}

usage() {
echo -n "
  Usage: $0 [b|p]
  b    Build App
  p    Push App 

"
}


case "$1" in
  b)
    build
    ;;
  p)
    push
    ;;
  *)
    usage
    ;;
esac

exit $?
