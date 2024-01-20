
# MX Linux fcitx 한글 입력기 설치 및 설정

- 참조
```
https://m.blog.naver.com/callofgis/221993585745
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

# bluetooth 수동으로 추가
```
$ bluetoothctl
[  ] agent on
[ ] scan on 
...
34:88:5D:4A:33:05
...
[ ] scan off
[ ] trust 34:88:5D:4A:33:05
[ ] pair 34:88:5D:4A:33:05
[ ] connect 34:88:5D:4A:33:05

typing the words with enter key 

[ ] exit
```

- 참조
```
https://unix.stackexchange.com/questions/590221/pairing-logitech-k380-in-ubuntu-20-04#

https://unix.stackexchange.com/questions/96693/connect-to-a-bluetooth-device-via-terminal
```

# realtek wifi
```
sudo apt list "*rtl88*"
sudo apt install "rtl88*"
```

# font
```
$ fc-list
$ sudo fc-cache -f -v

$ sudo unzip -d /usr/share/fonts/nanum nanum-all.zip
$ sudo fc-cache -f -v
```
