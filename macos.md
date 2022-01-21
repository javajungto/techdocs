# virtualbox

```
- reboot 
- command + R 복구모드
- 메뉴 > terminal
- csrutil disable; reboot
- Virtualbox 재설치 
```

# port 확인

```
sudo lsof -i :3000 kill -9 <PID>
netstat -ano | findstr <Port Number>
sudo lsof -i :<port>
```

# iTerm2에서 한글 깨질때
```
iTerm2 > Preferences > Profile > Text > Unicode : Unicode normalization : none -> NFC로 변경
```

# macos java_home

% download openjdk
```
https://openjdk.java.net/
> Installing
> jdk.java.net
> Ready for use : JDK17
> Builds > macOS/x64 tar.gz
...
tar xvfz openjdk-17.0.1_macos-x64_bin.tar.gz
...
% cat ~/.zshrc
export JAVA_HOME=/Users/j.../Desktop/jdk-17.0.1.jdk/Contents/Home
export PATH=${PATH}:$JAVA_HOME/bin:

source ~/.zshrc
java -version
```

% /usr/libexec/java_home
```
/Library/Java/JavaVirtualMachines/jdk-14.0.1.jdk/Contents/Home
```

% /usr/libexec/java_home -V
```
Matching Java Virtual Machines (3):
    14.0.1 (x86_64) "Oracle Corporation" - "Java SE 14.0.1" /Library/Java/JavaVirtualMachines/jdk-14.0.1.jdk/Contents/Home
    1.8.202.08 (x86_64) "Oracle Corporation" - "Java" /Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home
    1.8.0_202 (x86_64) "Oracle Corporation" - "Java SE 8" /Library/Java/JavaVirtualMachines/jdk1.8.0_202.jdk/Contents/Home
/Library/Java/JavaVirtualMachines/jdk-14.0.1.jdk/Contents/Home
```

% view ~/.zshenv
```
export "JAVA_HOME=/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"
```

# view ~/.zshrc
```
cat ~/.zshrc
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export PATH=${PATH}:$JAVA_HOME/bin
```

# IntelliJ IDEA validation.properties 한글 깨짐 
```
MacOS
상단 메뉴 > preferences > Editor > File Encodings  
    Global Encoding : UTF-8
    Project Encoding : UTF-8
    Properties Files > Default encoding for properties files : UTF-8, [checked] Tranparent native-to-ascii conversion
```

# 창 조절
```
https://rectangleapp.com/
```

# oh my zsh 설정
```
https://github.com/ohmyzsh/ohmyzsh

설치 
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh --no-check-certificate)"

플러그인 설정
    view ~/.zshrc
    ...
    plugins=(
      git
      bundler
      dotenv
      osx
      rake
      rbenv
      ruby
    )
    ...

테마 변경 
    ...
    ZSH_THEME="robbyrussell" => ZSH_THEME="agnoster"로 변경 
    ...

폰트 설치(Powerline Fonts)
    git clone https://github.com/powerline/fonts.git
    cd fonts
    ./install.sh

iTerm2 폰트 변경
    iTerms2 > Preferences > Profiles > Text > Font : Inconsolata-dz for Powerline dz 선택 

```

# icloud 절대 경로

```
/Users/사용자/Library/Mobile Documents/com~apple~CloudDoc
```

# openjdk

```
https://adoptopenjdk.net
https://adoptopenjdk.net/releases.html?variant=openjdk16&jvmVariant=hotspot
```

# android-studio
```
실행 > More Actions 
> SDK Manager 
> Appearance & Behavior 
> System Settings 
> Android SDK | SDK Tools 
> Android SDK Command-line Tools(latest) 체크 
```
# xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun
```
xcode-select --install
```
