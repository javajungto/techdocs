vagrant up 
```
virtualbox vm 5개 실행
c1 x.x.x.74
c2 x.x.x.75
c3 x.x.x.76
c4 x.x.x.77
c5 x.x.x.78
```

vagrant ssh c1
```
[vagrant@c1 ~]$ ssh-keygen -t rsa
enter
enter

[vagrant@c1 ~]$ ls -la .ssh/
total 12
drwx------. 2 vagrant vagrant   61 Aug 12 10:18 .
drwx------. 3 vagrant vagrant  121 Aug  4 08:01 ..
-rw-------. 1 vagrant vagrant  389 Aug  4 03:47 authorized_keys
-rw-------. 1 vagrant vagrant 1675 Aug 12 10:18 id_rsa
-rw-r--r--. 1 vagrant vagrant  392 Aug 12 10:18 id_rsa.pub

[vagrant@c1 ~]$ ls -la .ssh/id_rsa.pub

=> copy
```

vagrant ssh c2(~c5)
```
[vagrant@c2 ~]$ view .ssh/authorized_keys
<== paste
```

vagrant ssh c1
```
[vagrant@c1 ~]$ ssh x.x.x.75 hostname
c2
```

install kubesray on c1
```
$ sudo yum -y install epel-release
$ sudo yum -y install python-pip
$ pip --version
$ git clone https://github.com/kubernetes-sigs/kubespray
$ git checkout -b v2.11.0
$ cat requirements.txt 
$ sudo pip install --upgrade pip
$ sudo pip install -r requirements.txt 
$ sudo yum -y install tree

```
