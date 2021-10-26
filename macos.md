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
