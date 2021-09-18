#!/bin/bash

yum install -y yum-utils && yum-config-manager  --add-repo https://download.docker.com/linux/centos/docker-ce.repo && yum -y install docker-ce docker-ce-cli containerd.io && systemctl start docker && systemctl enable docker
