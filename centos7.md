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
# yum -y update
# yum -y install epel-release
# yum -y install xrdp tigervnc-server
# systemctl start tigervnc-server
# systemctl start xrdp.service
# systemctl enable xrdp.service
# firewall-cmd --permanent --zone=public --add-port=3389/tcp
# /sbin/shutdown -r now
```

# firewalld 설치, 구동

```
# yum install firewalld
# systemctl start firewalld
# systemctl enable firewalld

# firewall-cmd --state
# firewall-cmd --reload

```

# firewalld 설치, 구동

```
# yum install firewalld
# systemctl start firewalld
# systemctl enable firewalld

# firewall-cmd --state
# firewall-cmd --reload

```

# vscode 설치 

```
https://code.visualstudio.com/Download 다운로드 (code-1.62.1-1636111127.el7.x86_64.rpm)
yum install -y libXScrnSaver
rpm -Uvh code-1.62.1-1636111127.el7.x86_64.rpm
```

# Intellij IDEA 설치 

```
https://www.jetbrains.com/ko-kr/idea/download/download-thanks.html?platform=linux&code=IIC
$ cd idea-IC-212.5457.46/bin/
$ ./idea.sh
```

# cat ~/.bash_profile
```
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi


# User specific environment and startup programs

export JAVA_HOME=/usr/local/jdk8u312-b07
export PATH=$PATH:$JAVA_HOME/bin

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH
```

# git upgrade 
```
yum install \
https://repo.ius.io/ius-release-el7.rpm \
https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
```

```
yum -y remove git
yum -y install git224
```

# hostname
```
hostnamectl set-hostname devsrv
```
