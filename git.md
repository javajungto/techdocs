```
on server
cd /home/
git clone --bare docker docker.git

```

<Reference>
svn능력자를 위한 git개념가이드 
=> http://www.slideshare.net/einsub/svn-git-17386752

git - 간편안내서
=> http://rogerdudler.github.io/git-guide/index.ko.html

=> http://bunhere.tistory.com/37

=> http://git-scm.com/book/ko/Git-%EC%84%9C%EB%B2%84

유용한 최신글
=> http://bcho.tistory.com/773

touch README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/javajungto/techdocs.git
git push -u origin master


git init
git clone https://github.com/j.../techdocs.git

git add file
git add folder/file /  * 빈폴더는 추가 되지 않는다. 
git rm file
git rm folder/file
git status
git commit -m "message"

git checkout -b feature_x / create branch
git checkout master       / master branch로 변환 
git checkout feature_x    / feature_x branch로 변환 
git checkout -d feature_x / delelete feature_x branch
git push origin feature_x

git push  / ==> remote repository
git pull  / <== remote repository

git reset --hard master / git repo를 master branch의 최종으로 원복함. 

git remote add origin https://github.com/j.../techdocs.git

gitk / ui

-----------------------
git server
-----------------------
cd /home
git clone --bare dfms dfms.git

cd /tmp
mkdir test
cd test
git init
touch README.md
git add .
git commit -m "init"
git remote add origin root@IP:/home/gitrepo.git
git push origin master

-----------------------
git clients
-----------------------
cd /home
git clone root@IP:/home/dfms.git ==> /home/dfms 생성
cd /home/dfms
git pull

-----------------------
eclipse git : egit
----------------------

help > install New software 

Work with : [add] click

Name     : egit
Location : http://www.jgit.org/updates 

----------------------
맥에서 한글 깨질때
----------------------

http://elfinlas.tistory.com/298

-----------------------
Git에서 non-fast-forward 메시지가 나올때 대처법
-----------------------

git rebase등으로 앞서 commit된 것들을 하나로 합친다음 (이때 이 commit들이 push되어 있다면) 다시 commit하려고 하면 non-fast-forward update라고 하면서 push가 되지 않는다. 이때 +를 사용하면 된다.

git push origin +master  

