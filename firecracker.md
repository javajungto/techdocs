# test 환경
```
Rocky linux 8.6
```

# 가상화 지원 여부 확인
```
cat /proc/cpuinfo | egrep "vmx|svm" 
lsmod | grep kvm
```

# install kvm on rocky linux
```
dnf update -y
dnf install qemu-kvm qemu-img libvirt virt-manager virt-install virt-viewer libvirt-client -y
systemctl start libvirtd
systemctl enable libvirtd
systemctl status libvirtd
```

# install docker on rocky linux
```
dnf install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf -y install docker-ce docker-ce-cli containerd.io
systemctl enable --now docker
```

# install firecracker
```
dnf install git -y
git clone https://github.com/firecracker-microvm/firecracker
cd firecracker
tools/devtool build
toolchain="$(uname -m)-unknown-linux-musl" 
```

# firecracker 설치된 디렉토리로 이동
```
cd /root/firecracker/build/cargo_target/x86_64-unknown-linux-musl/debug
```

# view get_kernel_rootfs.sh <== ubuntu 이미지 apt update시 오류 발생
```
arch=`uname -m`
dest_kernel="hello-vmlinux.bin" 
dest_rootfs="hello-rootfs.ext4" 
image_bucket_url="https://s3.amazonaws.com/spec.ccfc.min/img/quickstart_guide/$arch" 

if [ ${arch} = "x86_64" ]; then
    kernel="${image_bucket_url}/kernels/vmlinux.bin" 
    rootfs="${image_bucket_url}/rootfs/bionic.rootfs.ext4" 
elif [ ${arch} = "aarch64" ]; then
    kernel="${image_bucket_url}/kernels/vmlinux.bin" 
    rootfs="${image_bucket_url}/rootfs/bionic.rootfs.ext4" 
else
    echo "Cannot run firecracker on $arch architecture!" 
    exit 1
fi

echo "Downloading $kernel..." 
curl -fsSL -o $dest_kernel $kernel

echo "Downloading $rootfs..." 
curl -fsSL -o $dest_rootfs $rootfs

echo "Saved kernel file to $dest_kernel and root block device to $dest_rootfs." 
```
chmod 700 get_kernel_rootfs.sh

# 공식 문서의 이미지는 ubuntu 인데, apt update 시 오류가 발생함 
오류 발생
```
https://s3.amazonaws.com/spec.ccfc.min/img/quickstart_guide/kernels/vmlinux.bin
https://s3.amazonaws.com/spec.ccfc.min/img/quickstart_guide/rootfs/bionic.rootfs.ext4
```
정상 작동(Alpine linux)
```
curl -fsSL -o hello-vmlinux.bin https://s3.amazonaws.com/spec.ccfc.min/img/hello/kernel/hello-vmlinux.bin
curl -fsSL -o hello-rootfs.ext4 https://s3.amazonaws.com/spec.ccfc.min/img/hello/fsfiles/hello-rootfs.ext4
```

# view get_kernel_rootfs_ok.sh
```
curl -fsSL -o hello-vmlinux.bin https://s3.amazonaws.com/spec.ccfc.min/img/hello/kernel/hello-vmlinux.bin
curl -fsSL -o hello-rootfs.ext4 https://s3.amazonaws.com/spec.ccfc.min/img/hello/fsfiles/hello-rootfs.ext4
```
chmod 700 get_kernel_rootfs_ok.sh

# view set_guest_kernel.sh
```
arch=`uname -m`
kernel_path=$(pwd)"/hello-vmlinux.bin" 

if [ ${arch} = "x86_64" ]; then
    curl --unix-socket /tmp/firecracker.socket -i \
      -X PUT 'http://localhost/boot-source'   \
      -H 'Accept: application/json'           \
      -H 'Content-Type: application/json'     \
      -d "{
            \"kernel_image_path\": \"${kernel_path}\",
            \"boot_args\": \"console=ttyS0 reboot=k panic=1 pci=off\" 
       }" 
elif [ ${arch} = "aarch64" ]; then
    curl --unix-socket /tmp/firecracker.socket -i \
      -X PUT 'http://localhost/boot-source'   \
      -H 'Accept: application/json'           \
      -H 'Content-Type: application/json'     \
      -d "{
            \"kernel_image_path\": \"${kernel_path}\",
            \"boot_args\": \"keep_bootcon console=ttyS0 reboot=k panic=1 pci=off\" 
       }" 
else
    echo "Cannot run firecracker on $arch architecture!" 
    exit 1
fi
```
chmod 700 set_guest_kernel.sh

# view set_guest_rootfs.sh
```
rootfs_path=$(pwd)"/hello-rootfs.ext4" 
curl --unix-socket /tmp/firecracker.socket -i \
  -X PUT 'http://localhost/drives/rootfs' \
  -H 'Accept: application/json'           \
  -H 'Content-Type: application/json'     \
  -d "{
        \"drive_id\": \"rootfs\",
        \"path_on_host\": \"${rootfs_path}\",
        \"is_root_device\": true,
        \"is_read_only\": false
   }" 
```
chmod 700 set_guest_rootfs.sh

# view set_network.sh
```
curl --unix-socket /tmp/firecracker.socket -i \
  -X PUT 'http://localhost/network-interfaces/eth0' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
      "iface_id": "eth0",
      "guest_mac": "AA:FC:00:00:00:01",
      "host_dev_name": "tap0"
    }'
```

# view start_guest.sh
```
curl --unix-socket /tmp/firecracker.socket -i \
  -X PUT 'http://localhost/actions'       \
  -H  'Accept: application/json'          \
  -H  'Content-Type: application/json'    \
  -d '{
      "action_type": "InstanceStart" 
   }'
```
chmod 700 start_guest.sh

# view vm_config_network.json
```
{
  "boot-source": {
    "kernel_image_path": "hello-vmlinux.bin",
    "boot_args": "console=ttyS0 reboot=k panic=1 pci=off",
    "initrd_path": null
  },
  "drives": [
    {
      "drive_id": "rootfs",
      "path_on_host": "hello-rootfs.ext4",
      "is_root_device": true,
      "partuuid": null,
      "is_read_only": false,
      "cache_type": "Unsafe",
      "io_engine": "Sync",
      "rate_limiter": null
    }
  ],
  "machine-config": {
    "vcpu_count": 1,
    "mem_size_mib": 512,
    "smt": false,
    "track_dirty_pages": false
  },
  "network-interfaces": [
    {
      "iface_id": "eth0",
      "guest_mac": "AA:FC:00:00:00:01",
      "host_dev_name": "tap0" 
    }
  ],
  "balloon": null,
  "vsock": null,
  "logger": null,
  "metrics": null,
  "mmds-config": null
}
```

# host에서 network 설정
host에서 인터넷 네트워크가 eth0일 경우
```
ip tuntap add tap0 mode tap
sudo ip addr add 172.16.0.1/24 dev tap0
sudo ip link set tap0 up
sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i tap0 -o eth0 -j ACCEPT
```

# guest 구동 (API 호출)
first shell prompt
```
cd /root/firecracker/build/cargo_target/x86_64-unknown-linux-musl/debug
rm -f /tmp/firecracker.socket && ./firecracker --api-sock /tmp/firecracker.socket
```

second shell prompt
```
./get_kernel_rootfs_ok.sh && ./set_guest_kernel.sh && ./set_guest_rootfs.sh ./set_network.sh && ./start_guest.sh
```

# guest 구동 (json config file)
```
rm -f /tmp/firecracker.socket && ./firecracker --api-sock /tmp/firecracker.socket --config-file vm_config_network.json
```

# guest (Alpine linux)
```
id/pwd : root / root
```
guest network 설정
```
ip addr add 172.16.0.2/24 dev eth0
ip link set eth0 up
ip route add default via 172.16.0.1 dev eth0
echo 'nameserver 8.8.8.8' > /etc/resolv.conf
apk update
apk add nginx
```

# shutdown guest
on guest
```
reboot
```

# nofirewall.sh
```
#!/bin/bash

# http://killyridols.net/firewall.rules.html
# the initial setup for this firewall was setup by levy.pl
# check it out to create a skeleton for your firewall

# route packets between interfaces
# echo "1" > /proc/sys/net/ipv4/ip_forward

# chain policies
# set default policies
/sbin/iptables -P INPUT ACCEPT
/sbin/iptables -P OUTPUT ACCEPT
/sbin/iptables -P FORWARD ACCEPT  # Set to DROP if you're NOT doing NAT'ing!

# flush tables
/sbin/iptables -F
/sbin/iptables -F INPUT
/sbin/iptables -F OUTPUT
/sbin/iptables -F FORWARD
/sbin/iptables -F -t mangle
/sbin/iptables -X
/sbin/iptables -F -t nat
```

# cleaning up
```
ip link ls
ip link del tap0
iptables -F
./nofirewall.sh
sh -c "echo 0 > /proc/sys/net/ipv4/ip_forward"

rm hello*
cp bak/hello* .
ip link del br0
```

# neofetch
```
        #####           root@fc
       #######          -------
       ##O#O##          OS: Rocky Linux 8.6 (Green Obsidian) x86_64
       #######          Host: PowerEdge R620
     ###########        Kernel: 4.18.0-372.9.1.el8.x86_64
    #############       Uptime: 21 hours, 25 mins
   ###############      Packages: 747 (rpm)
   ################     Shell: bash 4.4.20
  #################     Resolution: 1280x1024
#####################   Terminal: /dev/pts/1
#####################   CPU: Intel Xeon E5-2670 0 (32) @ 3.300GHz
  #################     GPU: 0b:00.0 Matrox Electronics Systems Ltd. G200eR2
                        Memory: 599MiB / 15964MiB
```

# 참조
```
https://github.com/firecracker-microvm/firecracker/blob/main/docs/network-setup.md
https://s8sg.medium.com/quick-start-with-firecracker-and-firectl-in-ubuntu-f58aeedae04b
```

# 오류
```
{"fault_message":"Internal error while starting microVM: Failed to validate KVM support: Missing KVM capabilities:Xcrs"}
```
```
root@ubuntu:~# neofetch
            .-/+oossssoo+/-.               root@ubuntu
        `:+ssssssssssssssssss+:`           -----------
      -+ssssssssssssssssssyyssss+-         OS: Ubuntu 18.04.4 LTS x86_64
    .ossssssssssssssssssdMMMNysssso.       Host: PowerEdge R410
   /ssssssssssshdmmNNmmyNMMMMhssssss/      Kernel: 4.15.0-76-generic
  +ssssssssshmydMMMMMMMNddddyssssssss+     Uptime: 3 hours, 11 mins
 /sssssssshNMMMyhhyyyyhmNMMMNhssssssss/    Packages: 745
.ssssssssdMMMNhsssssssssshNMMMdssssssss.   Shell: bash 4.4.20
+sssshhhyNMMNyssssssssssssyNMMMysssssss+   Terminal: /dev/pts/0
ossyNMMMNyMMhsssssssssssssshmmmhssssssso   CPU: Intel Xeon E5606 (4) @ 1.196GHz
ossyNMMMNyMMhsssssssssssssshmmmhssssssso   GPU: Matrox Electronics Systems Ltd. MGA G200eW WPCM450
+sssshhhyNMMNyssssssssssssyNMMMysssssss+   Memory: 215MiB / 16028MiB
.ssssssssdMMMNhsssssssssshNMMMdssssssss.
 /sssssssshNMMMyhhyyyyhdNMMMNhssssssss/
  +sssssssssdmydMMMMMMMMddddyssssssss+
   /ssssssssssshdmNNNNmyNMMMMhssssss/
    .ossssssssssssssssssdMMMNysssso.
      -+sssssssssssssssssyyyssss+-
        `:+ssssssssssssssssss+:`
            .-/+oossssoo+/-.
```
```
[root@localhost ~]# neofetch
        #####           root@localhost.localdomain
       #######          --------------------------
       ##O#O##          OS: Rocky Linux 8.6 (Green Obsidian) x86_64
       #######          Host: 3249R99 ThinkPad X201
     ###########        Kernel: 4.18.0-372.9.1.el8.x86_64
    #############       Uptime: 5 mins
   ###############      Packages: 809 (rpm)
   ################     Shell: bash 4.4.20
  #################     Resolution: 1280x800
#####################   Terminal: /dev/pts/0
#####################   CPU: Intel i5 M 540 (4) @ 1.199GHz
  #################     GPU: Intel Core Processor
                        Memory: 303MiB / 3561MiB
```

# 다중 guest 구동
# view start_1.sh
```
#!/bin/bash

rm -f /tmp/firecracker.socket && ./firecracker --api-sock /tmp/firecracker.socket --config-file vm_config_network.json
```
# view start_2.sh
```
#!/bin/bash

rm -f /tmp/firecracker2.socket && ./firecracker --api-sock /tmp/firecracker2.socket --config-file vm_config_network_2.json
```

# kernel, rootfs
```
rm -rf hello*
cp bak.h/hello* .
cp hello-vmlinux.bin hello-vmlinux-2.bin
cp hello-rootfs.ext4 hello-rootfs-2.ext4
```
# view vm_config_network_2.json
```
{
  "boot-source": {
    "kernel_image_path": "hello-vmlinux-2.bin",
    "boot_args": "console=ttyS0 reboot=k panic=1 pci=off",
    "initrd_path": null
  },
  "drives": [
    {
      "drive_id": "rootfs",
      "path_on_host": "hello-rootfs-2.ext4",
      "is_root_device": true,
      "partuuid": null,
      "is_read_only": false,
      "cache_type": "Unsafe",
      "io_engine": "Sync",
      "rate_limiter": null
    }
  ],
  "machine-config": {
    "vcpu_count": 1,
    "mem_size_mib": 512,
    "smt": false,
    "track_dirty_pages": false
  },
  "network-interfaces": [
    {
      "iface_id": "eth0",
      "guest_mac": "AA:FC:00:00:00:02",
      "host_dev_name": "tap2" 
    }
  ],
  "balloon": null,
  "vsock": null,
  "logger": null,
  "metrics": null,
  "mmds-config": null
}
```

# guest1
# host
```
ip tuntap add tap0 mode tap
sudo ip addr add 172.16.0.1/24 dev tap0
sudo ip link set tap0 up
sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward" 
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i tap0 -o eth0 -j ACCEPT
```

# ./start_1.sh
# guest1
```
ip addr add 172.16.0.2/24 dev eth0
ip link set eth0 up
ip route add default via 172.16.0.1 dev eth0
echo 'nameserver 8.8.8.8' > /etc/resolv.conf
apk update
apk add nginx
```

# guest2
# host
```
ip tuntap add tap2 mode tap
sudo ip addr add 172.16.2.1/24 dev tap2
sudo ip link set tap2 up
sudo iptables -A FORWARD -i tap2 -o eth0 -j ACCEPT
```

# ./start_2.sh
# guest2
```
ip addr add 172.16.2.2/24 dev eth0
ip link set eth0 up
ip route add default via 172.16.2.1 dev eth0
echo 'nameserver 8.8.8.8' > /etc/resolv.conf
apk update
apk add nginx
```





