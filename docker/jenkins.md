# jenkins

install_jenkins.sh

```
#!/bin/bash
useradd -m jenkins
docker run -d -p 8080:8080 -v /home/jenkins:/var/jenkins_home --name jenkins jenkins/jenkins
docker logs jenkins
```

cat /home/jenkins/secrets/initialAdminPassword

Install suggested plugins

tcp://192.168.0.22:2375

firewall-cmd --zone=public --add-port=2375/tcp

https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-using-firewalld-on-rocky-linux-9

blueocean ui plugin 설치
Jenkins 관리 > Plugin Manager >

docker exec -it jenkins /bin/bash

---
pipeline
```
품질 점검이나 소프트웨어 인도와 같은 부분을 자동으로 수행하도록 하는 일련의 과정
스크립트을 연결해서 작성.
```

stage

step

```
pipeline {
    agent any
    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
    }
}
```

```
pipeline {
    agent any
    stages {
        stage('First Stage') {
            steps {
                echo 'Step 1. Hello World'
            }
        }
        stage('Second Stage') {
            steps {
                echo 'Step 2. Second time Hello'
                echo 'Step 3, Third time Hello'
            }
        }
    }
}
```

커밋 파이프라인
```
리포지터리로 커밋(또는 git으로 push)한 후 빌드 결과를 보고하는 파이프라인
코드가 변경될 때마다 파이프라인이 실행되기 때문에 빌드 시간은 5분을 넘지 않아야 하고,
리소스 사용도 합리적인 수준이어야 한다.
```

gitlab_tk

update-crypto-policies --set LEGACY

ssh-keygen -t rsa -b 2048 -C "jwpark@......co.kr"

ssh-keygen -C jenkins@jwpark

# install_docker.sh

```
#!/bin/bash
#https://docs.docker.com/engine/install/centos/
yum clean all &&
yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine &&
yum install -y yum-utils rdate &&
rdate -s time.bora.net &&
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo &&
yum install docker-ce docker-ce-cli containerd.io -y &&
systemctl start docker &&
docker run hello-world
```


# jenkins 서버에서 ssh key 생성(private,public)

```
on jenkins
docker start jenkins
docker exec -it jenkins /bin/bash
jenkins@f17361f771b3:/$ ssh-keygen -t rsa -C jenkins
jenkins@f17361f771b3:/$ chmod 600 ~/.ssh/id_rsa*
```
# jenkins 서버의 ssh public key를 gitlab에 등록
```
on gitlab
jenkins의 pub key를 gitlab > User Settins > SSH Keys에 등록
```

# private key를 jenkins에 등록
```
on jenkins
Dashboard > Jenkins관리 > Manage Credentials > (global) 클릭 Add Credentials
Kind : SSH Username with private key
Scope : Global (Jenkins, nodes, items, all child items. etc)
ID : jenkins_ssh_private_key
Username : git
Private Key : Enter directly 선택, Add 클릭
docker exec -it jenkins /bin/bash
jenkins@f17361f771b3:/$ cat ~/.ssh/id_rsa  <== 결과값 복사해서 붙여넣기

Passphrase : 없으면 빈 값
create
```

# git plugin 설치
```
on jenkins
Jenkins 관리 > 플러그인 관리 > Available plugins : Git plugin
여기에 없으면 Installed plugins에 이미 설치 되저 있을수 있음.

<new items>
on jenkins
Dashboard > 새로운 item
Enter an item name : checkout
Freestyle project 선택 > ok
소스 코드 관리 : git 선택
Git
    > Repositories
        > Repository URL : ssh://git@x.x.x.x:2225/root/test.git
        > Credentials : git 선택
    > Branches to build
        > Branch Specifier(blank for 'any') : */main <== repository에 맞게


Build Steps

저장
```

# etc

```
ssh-keygen -t rsa -b 2048 -C "j....." 빈암호
ssh-copy-id root@x.x.x.x 
접속 확인 : ssh root@x.x.x.x <==== 암호 없이 ssh 접속 
```

```
pipeline {
    agent any
    stages {
        stage('checkout') {
            steps {
                git url: 'ssh://git@x.x.x.x:2225/root/test_front.git', branch: 'main'
            }
        }
    }
}
```
