virtualbox에 vm 3개 구동 

#Vagrantfile
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
