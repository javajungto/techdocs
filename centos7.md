# centos 7 런레벨 확인

```
# systemctl get-default
```

# centos 7 GUI 부팅 런레벨 변경 

```
# systemctl set-default graphical.target
```


# 원격 접속 설정 

```
yum -y update
yum -y install epel-release
yum -y install xrdp tigervnc-server
systemctl start tigervnc-server
systemctl start xrdp.service
systemctl enable xrdp.service
firewall-cmd --permanent --zone=public --add-port=3389/tcp
/sbin/shutdown -r now
```
