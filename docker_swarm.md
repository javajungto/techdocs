### virtualbox에 vm 3개 구동 

Vagrantfile

```console

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

  	# default router
#  	c1.vm.provision "shell",
#    		run: "always",
#    		inline: "route add default gw x.x.x.254"

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

  	# default router
#  	c2.vm.provision "shell",
#    		run: "always",
#    		inline: "route add default gw x.x.x.254"

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

  	# default router
 # 	c3.vm.provision "shell",
 #   		run: "always",
 #   		inline: "route add default gw x.x.x.254"

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

각 vm에 docker 설치

#vagrant ssh c1 (c2,c3도 동일하게)

#view install_docker_centos7.sh
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

#sudo ./install_docker_centos7.sh ( c1,c2,c3 모두 )


docker swarm cluster 생성

#vagrant ssh c1 (c1를 manager 노드로 설정) 
```
sudo docker swarm init --advertise-addr x.x.x.74
```

#결과
```
Swarm initialized: current node (lk4w2l0r....wc6g4s) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-525uw127lu............iolrhd5fxhhl9i1uzf x.x.x.74:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```
