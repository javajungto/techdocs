### virtualbox에 vagrant로 vm 3개 구동 

Vagrantfile

```

Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"

  config.vm.define "c1" do |c1|
	c1.vm.hostname = "c1"
	c1.vm.network "public_network", 
		bridge:"en3: AX88x72A", 
		ip:"x.x.x.74",
		netmask:"255.255.255.0",
		gateway:"x.x.x.254",
		dns_nameserver:"8.8.8.8"	

	c1.vm.provision "shell", inline: <<-SHELL
		sudo yum -y install net-tools git
		sudo mkdir /root/bin
	SHELL

	c1.vm.provider "virtualbox" do |v|
		v.name = "c1"
		v.memory = 512
		v.cpus = 1
		v.linked_clone = true
		v.gui = false
	end
	
   end

  config.vm.define "c2" do |c2|
	c2.vm.hostname = "c2"
	c2.vm.network "public_network", 
		bridge:"en3: AX88x72A", 
		ip:"x.x.x.75",
		netmask:"255.255.255.0",
		gateway:"x.x.x.254",
		dns_nameserver:"8.8.8.8"	

	c2.vm.provision "shell", inline: <<-SHELL
		sudo yum -y install net-tools git
		sudo mkdir /root/bin
	SHELL

	c2.vm.provider "virtualbox" do |v|
		v.name = "c2"
		v.memory = 512
		v.cpus = 1
		v.linked_clone = true
		v.gui = false
	end
	
   end

  config.vm.define "c3" do |c3|
	c3.vm.hostname = "c3"
	c3.vm.network "public_network", 
		bridge:"en3: AX88x72A", 
		ip:"x.x.x.76",
		netmask:"255.255.255.0",
		gateway:"x.x.x.254",
		dns_nameserver:"8.8.8.8"	

	c3.vm.provision "shell", inline: <<-SHELL
		sudo yum -y install net-tools git
		sudo mkdir /root/bin
	SHELL

	c3.vm.provider "virtualbox" do |v|
		v.name = "c3"
		v.memory = 512
		v.cpus = 1
		v.linked_clone = true
		v.gui = false
	end
	
   end

end

```

### 각 vm에 docker 설치

```console
$ vagrant ssh c1 (c2,c3도 동일하게)
```

install_docker_centos7.sh
```
#!/bin/bash
#https://docs.docker.com/engine/install/centos/
yum clean all &&
yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine &&
yum install -y yum-utils &&
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo &&
yum install docker-ce docker-ce-cli containerd.io -y &&
systemctl start docker 
```

```console
$ sudo ./install_docker_centos7.sh ( c1,c2,c3 모두 )
```

### docker swarm cluster 생성

```console
$ vagrant ssh c1 (c1를 manager 노드로 설정) 
```

```console
$ sudo docker swarm init --advertise-addr x.x.x.74
```

결과
```
Swarm initialized: current node (lk4w2l0r....wc6g4s) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-525uw127lu............iolrhd5fxhhl9i1uzf x.x.x.74:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```

c2, c3 노드를 worker로 join 
```
$ vagrant ssh c2
$ sudo docker swarm join --token SWMTKN-1-525uw127lu............iolrhd5fxhhl9i1uzf x.x.x.74:2377
$ vagrant ssh c3
$ sudo docker swarm join --token SWMTKN-1-525uw127lu............iolrhd5fxhhl9i1uzf x.x.x.74:2377

```

결과
```
This node joined a swarm as a worker.
```

manger 노트에서 노드 확인
```
[vagrant@c1 ~]$ sudo docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
lk4w2l0rns71u6j3yjgwc6g4s *   c1                  Ready               Active              Leader              19.03.12
ywlwbk2bav4yg7oe43jeapvej     c2                  Ready               Active                                  19.03.12
2filxu80bw94hfbb9xl2fchsk     c3                  Ready               Active                                  19.03.12
```

기본 웹 애플리케이션 작성
```
sudo docker service create --name nginx -p 80:80 nginx:latest
```

```
[vagrant@c1 ~]$ sudo docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
whge9jbjb9kl        nginx               replicated          1/1                 nginx:latest        *:80->80/tcp
```

```
[vagrant@c1 ~]$ sudo docker service ps nginx
ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE           ERROR               PORTS
mjlov67f93b1        nginx.1             nginx:latest        c1                  Running             Running 2 minutes ago                       
```

> c1 node에서 nginx가 실행중이나, http://c2, http://c3로 해도 정상적으로 80으로 접속됨. \
> docker swarm은 서비스를 외부에 쉽게 노출하기 위해 모든 노드가 `ingress`라는 가상 네트워크에 속해 있다. \
> 서비스가 포트를 오픈할 경우 모든 노드에 포트가 오픈되고, 어떤 노드에 요청을 보내도 실행중인 컨테이너에 자동으로 전달 . \
> [참조](https://subicura.com/2017/02/25/container-orchestration-with-docker-swarm.html)

서비스 개수 늘리기 
```
[vagrant@c1 ~]$ sudo docker service scale nginx=5
nginx scaled to 5
overall progress: 5 out of 5 tasks 
1/5: running   [==================================================>] 
2/5: running   [==================================================>] 
3/5: running   [==================================================>] 
4/5: running   [==================================================>] 
5/5: running   [==================================================>] 
verify: Service converged 
```
```
[vagrant@c1 ~]$ sudo docker service ps nginx
ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE            ERROR               PORTS
mjlov67f93b1        nginx.1             nginx:latest        c1                  Running             Running 13 minutes ago                       
txad7dxefix3        nginx.2             nginx:latest        c1                  Running             Running 35 seconds ago                       
tjfrcohd0t5s        nginx.3             nginx:latest        c2                  Running             Running 18 seconds ago                       
ub2plqe3p39u        nginx.4             nginx:latest        c3                  Running             Running 16 seconds ago                       
j81zv90kcpz1        nginx.5             nginx:latest        c3                  Running             Running 16 seconds ago                       
```

Set up a Docker registry
```
docker service create --name registry --publish published=5000,target=5000 registry:2
[root@localhost ~]# curl http://127.0.0.1:5000/v2/
{}
```

```
docker swarm join-token manger
docker swarm join-token worker
docker service scale registry=3
docker node ls
docker service ls
docker service ps registry
```

```
```
