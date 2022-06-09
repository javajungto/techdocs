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

# first shell prompt
```
cd /root/firecracker/build/cargo_target/x86_64-unknown-linux-musl/debug
rm -f /tmp/firecracker.socket && ./firecracker --api-sock /tmp/firecracker.socket
```

# view get_kernel_rootfs.sh
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


