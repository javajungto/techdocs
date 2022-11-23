#!/bin/bash

useradd -m jenkins
docker run -d -p 8080:8080 -v /home/jenkins:/var/jenkins --name jenkins jenkins/jenkins
docker logs jenkins

