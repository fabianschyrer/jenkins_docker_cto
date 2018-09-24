#!/bin/bash
# Build & Tag Jenkins Image
docker build -t jenkins.docker.cto:latest .
#docker tag jenkins.docker.cto:latest <DOCKER_REGISTRY>/jenkins.docker.cto:latest
