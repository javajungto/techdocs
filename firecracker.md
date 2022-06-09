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

