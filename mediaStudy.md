# What is Video Encoding ?
```
The process

- of converting
    - Raw video → a digital format ⇒ compatible with many devices
- GB → MB
- Essential to live streaming + quick delivery, playback
- Can occur
    
    Within 
    
    - browser
    - Mobile app
    - IP Camera
    - Software : Vmix, Wirecast, OBS Studio
    - Stand-alone appliance
- To compress ← use video and audio codec
    
    Raw video → MB
    
- encoding = the process of compressor
- Codec = the means for doing so
```

# What is Codec ?
```
Codec 

- a video compression technology
    
    Videos - - - - - -> a streamable size
    

                         Shrink 수축

- Tightly compress bulky streams for delivery storage
- H.264
- AVC
- AAC (audio)
```

# Streamin Protocols
![Alt text](streaming_protocols02.png)

# Ingest and Transcoding
```
- 스트림을 다양한 코덱, 비트 전송률, 해상도 및 파일 컨테이너로 트랜스 코딩 해야한다.
- 트랜스 코딩을 통해 방송사는 시청자의 연결이나 하드웨어에 관계없이 거의 모든 장치에 연결이 가능하다.
- 트랜스 코딩이 완료되면 원본 스트림의 여러 변환이 전달되기 위해 출발한다.
```

# Transmuxing, Transcoding, Transrating, Transizing
```
다양한 장치 및 연결 속도에 걸쳐 시청 경험을 최적화하기 위해 방송사는 종종 스트림이 미디어 서버를 통과할 때 스트림을 트랜스먹싱, 트랜스 코딩, 트랜사이지으 트랜스 레이팅 하도록 선택합니다.

Transmuxing
    - 압축된 오디오 및 비디오를 가져와 다른 컨테이너 형식으로 다시 패키징 합니다.
    - 이를 통해 실제 파일을 조작하지 않고도 다양한 프로토콜을 통해 전달 할 수 있습니다.
    - 워드 문서를 pdf로 또는 그 반대로 변환하는 것과 같은 트랜스 먹싱을 생각해 볼 수 있다.
Transcoding
    - 압축/인코딩된 파일을 가져와 압축을 풀고 디코딩하여 어떤 방식으로든 변경하는 것을 가리키는 포괄적인 용어이다.
    - 그런 다음 조작된 파일은 전달을 위해 다시 압축 된다. 트랜스 사이징, 트랜스 레이팅 모두 트랜스 코딩의 하위 범주이다.
Transrating
    - 다양한 연결 속도를 수용하기 위해 압축 해제된 파일의 비트 전송률을 변경한다.
    - 여기에는 프레임 속도, 해상도 변경이 포함 될 수 있다.
Transizing
    - 다양한 화면에 맞게 비디오 프레임 크기 또는 해상도를 조정한다.

→ 하나의 비트 전송률로 하나의 라이브 스트림을 생성하는 대신 트랜스코딩을 사용하면 서로 다른 비트 전송률과 해상도로 여러 스트림을 생성할 수 있다.

 = 이를 바로 든 시청자의 화면 크기와 인터넷 속도에 맞게 동적으로 조정될 수 있는 적응형 비트 전송률 (ABR) 이라 한다.
```

# Transcoding FAQ
```
What is Transcoding Software ? (트랜스코딩 소프트웨어란 무엇인가요?)
    - 압축된 데이터를 가져와 크기, 비트레이트 등을 변경하기 위해 압축을 해제하고 네트워크를 통해 전송하기 위해 다시 압축하는 소프트웨어이다.

Where is Transcoding Used ? (트랜스코딩은 어디에 사용되나요?)
    - 네트워크를 통해 데이터를 전송하는 최선의 방법으로 대규모의 관객이나 다양한 재생 장치를 사용하는 관객을 대상으로 할 때 자주 사용된다.

Does Transcoding Video Reduce Quality ? (트랜스코딩 비디오는 품질을 저하시키나요?)
    - 트랜스코딩에 손실 압축을 사용하는지 여부에 전적으로 달려 있다.
    - 손실 압축은 파일 크기를 줄이는 효과적인 방법이지만 비디오 품질이 떨어질 수 있다. 그러나 데이터를 손실 없이 트랜스코딩하는 것도 가능하다

How Long Does It Take To Transcode Video ? (비디오를 트랜스코딩하는 데 얼마나 걸립니까?)
    - 사용하는 소프트웨어, 손실 압축 또는 무손실 압축으로 트랜스코딩하는지, 그리고 입력되는 비디오 파일의 크기에 따라 다르다.
    - 어쨌든, 트랜스코딩은 시간이 걸리며, 이것이 실시간 트랜스코딩을 어렵게 만드는 부분이다.

미디어 파일을 트랜스코딩하는 것은 다양한 최종 사용자 장치로 스트리밍할 때 필수적인 단계이다.
Wowza Streaming Engine과 Wowza Video는 수많은 트랜스코딩 워크플로우를 모두 지원한다.
```

# Adaptive bitrate (ABR) streaming 적응형 비트 전송률 스트리밍
```
- 다양한 장치 및 연결 속도에서 재생할 수 있도록 원본 비디오 스트림의 여러 변환을 출력하는 작업
- 이점: 뛰어난 대역폭과 처리 능력을 갖춘 사용자에게 고품질 스트림을 제공하는 동시 속도와 전력 부서가 부족한 사용자도 수용이 가능
- 버퍼링이나 스트림 중단이 없으며, 시청자의 신호가 막대 2개에서 3개로 증가하면 스트림이 자동으로 조정되어 탁월한 표현을 제공
```
