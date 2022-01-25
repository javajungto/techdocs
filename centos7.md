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

# centos 7 Galera cluster 
```
환경
	node1 x.x.x.x.14
	node2 x.x.x.x.15

on node1, node2
	curl -LsS https://r.mariadb.com/downloads/mariadb_repo_setup | sudo bash
	yum install -y mariadb-server galera
	view /etc/my.cnf.d/server.cnf
	...
	[galera]
	# Mandatory settings
	wsrep_on=ON
	wsrep_provider=/usr/lib64/galera-4/libgalera_smm.so
	wsrep_cluster_address=gcomm://x.x.x.x.14,x.x.x.x.15
	binlog_format=row
	default_storage_engine=InnoDB
	innodb_autoinc_lock_mode=2
	...

node1
	구동 galera_new_cluster
node2
	구동 systemctl start mariadb.service
중지
	on node1, node2
		systemctl stop mariadb

연동 확인
	MariaDB [mysql]> show global status like 'wsrep_cluster_size';
	+--------------------+-------+
	| Variable_name      | Value |
	+--------------------+-------+
	| wsrep_cluster_size | 2     |
	+--------------------+-------+
	1 row in set (0.001 sec)
	
node1, node2 db 데몬이 모두 다운됐을때
	아래 값을 보고 값이 1인 서버에서 galera_new_cluster 실행, node에서는 systemctl start mariadb
	cat /var/lib/mysql/grastate.dat
	...
	safe_to_bootstrap: 1
	...
	
참조 : https://bamdule.tistory.com/66
```
