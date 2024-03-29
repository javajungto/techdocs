#!/bin/bash
#https://docs.docker.com/engine/install/centos/
yum clean all &&
yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine &&
yum install -y yum-utils rdate &&
rdate -s time.bora.net &&
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo &&
yum install docker-ce docker-ce-cli containerd.io -y &&
systemctl enable docker && systemctl restart docker &&
docker run hello-world
