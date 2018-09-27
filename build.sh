#!/bin/bash
# Build & Tag Jenkins Image
docker build -t jenkins.docker.cto:latest .
docker tag jenkins.docker.cto:latest fabianschyrer/jenkins.docker.cto:latest