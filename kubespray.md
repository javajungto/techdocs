vagrant up 
```
virtualbox vm 5개 실행
c1 x.x.74
c2 x.x.75
c3 x.x.76
c4 x.x.77
c5 x.x.78
```

vagrant ssh c1
```
[vagrant@c1 ~]$ ssh-keygen -t rsa


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
