# install_docker.sh

```
#!/bin/bash
#https://docs.docker.com/engine/install/centos/
yum clean all &&
yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine &&
yum install -y yum-utils &&
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo &&
yum install docker-ce docker-ce-cli containerd.io -y &&
systemctl start docker &&
docker run hello-world
```

# example
```
docker images
docker search centos
docker search --filter "is-official=true" centos
docker pull centos
docker pull centos:7
docker run --name centos7_nginx_cdn -it centos:7
[root@3d2e1dcdc667 ~]#  
yum groupinstall "Development tools" -y &&
yum install pcre pcre-devel openssl openssl-devel gd gd-devel perl perl-devel perl-ExtUtils-Embed GeoIP-devel git wget net-tools -y &&
yum -y update &&

cd /usr/local/src/
wget http://nginx.org/download/nginx-1.18.0.tar.gz
tar xvfz nginx-1.18.0.tar.gz
git clone https://github.com/vozlt/nginx-module-vts.git
git clone https://github.com/FRiCKLE/ngx_cache_purge.git

cd /usr/local/src/nginx-1.18.0
./configure --prefix=/usr/local/nginx-1.18.0 --user=nginx --group=nginx \
--with-http_addition_module \
--with-http_auth_request_module \
--with-http_perl_module \
--with-http_geoip_module \
--with-http_gzip_static_module \
--with-http_gunzip_module \
--with-http_image_filter_module \
--with-http_realip_module \
--with-http_ssl_module \
--with-http_stub_status_module \
--with-http_sub_module \
--add-module=/usr/local/src/nginx-module-vts \
--add-module=/usr/local/src/ngx_cache_purge

make && make install
```

# view /etc/systemd/system/nginx.service
```
[Unit]
Description=The NGINX HTTP and reverse proxy server
After=syslog.target network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
PIDFile=/run/nginx.pid
ExecStartPre=/usr/local/nginx-1.18.0/sbin/nginx -t
ExecStart=/usr/local/nginx-1.18.0/sbin/nginx
ExecReload=/usr/local/nginx-1.18.0/sbin/nginx -s reload
ExecStop=/usr/local/nginx-1.18.0/sbin/nginx -s stop
#ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```

```
useradd nginx
cp /usr/local/src/nginx.conf.ex /usr/local/nginx-1.18.0/conf/nginx.conf
#view /usr/local/nginx-1.18.0/conf/nginx.conf
mkdir -p /data/nginx/cache && chown -R nginx:nginx /data

/usr/local/nginx-1.18.0/sbin/nginx -t
systemctl enable nginx.service
systemctl start nginx.service
```


# docker ps -a
> output
```
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                     PORTS               NAMES
3d2e1dcdc667        centos:7            "/bin/bash"              13 minutes ago      Exited (1) 3 seconds ago                       centos7_nginx_cdn
73faad47c40a        49e61650d7ce        "/bin/bash"              2 hours ago         Exited (0) 2 hours ago                         centos02
3362f4642489        centos:7            "/bin/bash"              2 hours ago         Exited (0) 2 hours ago                         centos01
799d7de70014        centos:7            "/bin/bash"              2 hours ago         Exited (0) 2 hours ago                         centos7
619705ab2386        e316a2e4139d        "/bin/bash -C /usr/l…"   2 hours ago         Exited (1) 2 hours ago                         c7
94185165939d        hello-world         "/hello"                 2 hours ago         Exited (0) 2 hours ago                         elastic_mendel
d414f7662c02        hello-world         "/hello"                 2 hours ago         Exited (0) 2 hours ago                         eloquent_payne
```

# docker
```
docker        docker-init   docker-proxy  dockerd   
```

# docker commit -a "by jwp" 1050c1559104 centos7_nginx_cdn:v0.2
```
sha256:86aff080e5fee24efebff748ffcb2c66a024ac5d277a085cb0cc9fc062c60a18
```

# docker save -o centos7_nginx_cdn.tar centos7_nginx_cdn:v0.2

# on) the other machine
```
#docker load -i centos7_nginx_cdn.tar

#docker images
REPOSITORY                           TAG                                              IMAGE ID            CREATED             SIZE
centos7_nginx_cdn                    v0.2                                             7064745702cb        3 hours ago         763MB
<none>                               <none>                                           c74f828cd7a4        6 hours ago         808MB
...

#docker run --name centos7_nginx_cdn -it centos7_nginx_cdn:v0.2

#docker run --name centos7_nginx_cdn -it centos7_nginx_cdn:v0.2
docker: Error response from daemon: Conflict. The container name "/centos7_nginx_cdn" is already in use by container "3609d329c0c06ee4e73cc59a7bfc5cd5e1ffbe3a100d105d466783a5cbf884b8". You have to remove (or rename) that container to be able to reuse that name.
See 'docker run --help'.

#docker rm centos7_nginx_cdn
centos7_nginx_cdn

#docker run --privileged -d --name centos7_nginx_cdn  centos7_nginx_cdn:v0.2 init
#docker exec -it centos7_nginx_cdn bash

#docker run --privileged -d -p 80:80 --name centos7_nginx_cdn centos7_nginx_cdn:v0.2 init
#docker exec centos7_nginx_cdn bash

웹브라우저 http://localhost 방문 

#docker run --privileged -d -p 80:80 -v /root/bin/nginx.conf:/usr/local/nginx-1.18.0/conf/nginx.conf --name centos7_nginx_cdn centos7_nginx_cdn:v0.5 init
#docker start centos7_nginx_cdn
```

#---------------------------------------------------------------------------
# 생성
#---------------------------------------------------------------------------
view Dockerfile
FROM centos:7
RUN yum groupinstall "Development tools" -y 
RUN yum install pcre pcre-devel openssl openssl-devel gd gd-devel perl perl-devel perl-ExtUtils-Embed GeoIP-devel git wget net-tools -y 
RUN yum -y update 

#docker build -t centos7_nginx_cdn:v0.1 .
#docker ps -a
#docker images
#docker run --privileged --name centos7_nginx_cdn centos:7 init
#docker exec -it centos7_nginx_cdn bash
nginx 컴파일 설치 
#docker commit -a "by jwp" 540ff1176c6f centos7_nginx_cdn:v0.1
#docker stop centos7_nginx_cdn && docker rm centos7_nginx_cdn
#docker run --privileged -d -p 80:80 --name centos7_nginx_cdn centos7_nginx_cdn:v0.1 init
#docker stop centos7_nginx_cdn && docker rm centos7_nginx_cdn
view nginx.conf <== on host, for real service
#docker run --privileged -d -p 80:80 -v /root/bin/nginx.conf:/usr/local/nginx-1.18.0/conf/nginx.conf --name centos7_nginx_cdn centos7_nginx_cdn:v0.1 init
#docker exec -it centos7_nginx_cdn bash <=== confirm

#docker login
#docker run --privileged -d -p 80:80 --name centos7_nginx_cdn centos7_nginx_cdn:v0.1
#docker ps -a
#docker commit -a "by jwp" 1529484617fd javajungto/centos7_nginx_cdn:v0.1
#docker push javajungto/centos7_nginx_cdn:v0.1 
#docker search javajungto

on the other machine
#docker pull javajungto/centos7_nginx_cdn:v0.1
#default nginx.conf
#docker run --privileged -d -p 80:80 --name centos7_nginx_cdn javajungto/centos7_nginx_cdn:v0.1 init
#docker stop centos7_nginx_cdn && docker rm centos7_nginx_cdn

#real nginx.conf
#docker run --privileged -d -p 80:80 -v /Users/jwpark/docker/nginx.conf:/usr/local/nginx-1.18.0/conf/nginx.conf --name centos7_nginx_cdn javajungto/centos7_nginx_cdn:v0.1 init

삭제
#docker rmi -f grafana/grafana

#---------------------------------------------------------------------------
# ref
#---------------------------------------------------------------------------

https://youngmind.tistory.com/entry/Docker-%EA%B0%95%EC%A2%8C-4-%EB%8F%84%EC%BB%A4-%EC%9D%B4%EB%AF%B8%EC%A7%801
https://www.snoopybox.co.kr/1756

```
docker service create --name registry --publish published=5000,target=5000 registry:2
```

docker images
docker rmi hello-world:latest
docker ps -a

$ docker run -i -t ubuntu:20.04 /bin/bash
# apt-get update
# apt-get install -y git
# exit
