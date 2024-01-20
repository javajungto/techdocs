
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
  
- logout, login => 상태바에 키보드 표시 확인

- 키보드 아이콘 > 오른쪽 마우스 버튼 > Configure
```
- Input Method 탭에서 '+'를 클릭
- "Only show current language"의 체크박스 클릭을 해제하고 'Search'에서 "Hangul"을 입력하고 선택하여 OK
- 기본 입력기('Keyboard - English (US)') 아래에 Hangul이 추가 됩니다. 주의: 입력기 리스트의 첫번째 입력기가 기본 입력기임을 나타낸다.
```

- Global Config 탭을 클릭하고 한영 전환 입력방법 선택
  ```
바꾸려면 클릭하고 입력 전환에 사용할 키 조합을 누릅니다
  ```
