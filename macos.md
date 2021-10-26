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

% IntelliJ IDEA validation.properties 한글 깨짐 
```
MacOS
상단 메뉴 > preferences > Editor > File Encodings  
    Global Encoding : UTF-8
    Project Encoding : UTF-8
    Properties Files > Default encoding for properties files : UTF-8, [checked] Tranparent native-to-ascii conversion
```

% 창 조절
```
https://rectangleapp.com/
```
