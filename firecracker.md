# 가상화 지원 여부 확인
```
cat /proc/cpuinfo | egrep "vmx|svm" 
lsmod | grep kvm
```
