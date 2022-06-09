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
