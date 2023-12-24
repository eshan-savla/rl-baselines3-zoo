#!/bin/bash

PARENT=stablebaselines/stable-baselines3

TAG=essav/rl-baselines3-zoo-rle
VERSION=2.2.0a1

if [[ ${USE_GPU} == "True" ]]; then
  PARENT="${PARENT}:${VERSION}"
else
  PARENT="${PARENT}-cpu:${VERSION}"
  TAG="${TAG}-cpu"
fi

docker build --build-arg PARENT_IMAGE=${PARENT} --build-arg USE_GPU=${USE_GPU} -t ${TAG}:${VERSION} . -f docker/Dockerfile
docker tag ${TAG}:${VERSION} ${TAG}:latest

if [[ ${RELEASE} == "True" ]]; then
  echo "Pushing to Docker Hub"
  docker push ${TAG}:${VERSION}
  docker push ${TAG}:latest
fi
