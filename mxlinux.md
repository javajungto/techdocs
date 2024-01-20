
# MX Linux fcitx 한글 입력기 설치 및 설정

```
- 참조 : https://m.blog.naver.com/callofgis/221993585745
- command + R 복구모드
- 메뉴 > terminal
- csrutil disable; reboot
- Virtualbox 재설치 
```

- 관련 패키지 설치
``` 
sudo apt install fcitx fcitx-hangul fcitx-frontend-* fcitx-config-gtk fcitx-ui-classic fcitx-tools
```

- fcitx 등록
```
Settings > Session & Startup > Application Autostart에서 +Add를 클릭하고 Name: fcitx, Command: fcitx를 입력하고 OK를 클릭하여 등록
```
  
