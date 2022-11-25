https://cli.vuejs.org/guide/installation.html
# node 버전 확인
```
node -v
v16.13.1
```
# npm 버전 확인
```
npm -v
8.1.2
```
# vue 설치
``` 
npm install -g vue
```
# vue cli 설치
```
npm install -g @vue/cli
```
# vue --version
```
@vue/cli 5.0.8
```
# vue ui
```
* vscode > 확장 : Vetur 설치
* cd test7
* vue create project01
  ** vue3 선택
* cd project01
* npm run serve
```

https://github.com/javajungto/techdocs/blob/master/dev/vuejs.md

# vue-cli 사용 project 생성

```
npm i -g @vue/cli-init
vue init webpack s....._front

? Project name s....._front
? Project description test
? Author j....@k.......
? Vue build standalone
? Install vue-router? Yes
? Use ESLint to lint your code? Yes
? Pick an ESLint preset Standard
? Set up unit tests Yes
? Pick a test runner jest
? Setup e2e tests with Nightwatch? Yes
? Should we run `npm install` for you after the project has been created? (recommended) npm

....

added 1861 packages, and audited 1862 packages in 2m

78 packages are looking for funding
  run `npm fund` for details

127 vulnerabilities (11 low, 68 moderate, 36 high, 12 critical)

To address issues that do not require attention, run:
  npm audit fix

To address all issues (including breaking changes), run:
  npm audit fix --force

Run `npm audit` for details.


Running eslint --fix to comply with chosen preset rules...
# ========================


> s......._front@1.0.0 lint
> eslint --ext .js,.vue src test/unit test/e2e/specs "--fix"


# Project initialization finished!
# ========================

To get started:

  cd s......._front
  npm run dev
  
Documentation can be found at https://vuejs-templates.github.io/webpack

```
