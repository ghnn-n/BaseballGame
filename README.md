

# BaseballGame

BaseballGame은 어릴 때 공책으로 자주 하던 야구게임을 Xcode로 구현한 프로젝트입니다.

---

## 📋 프로젝트 개요

BaseballGame은 세 자리의 숫자가 정답으로 지정되고 유저가 정답을 맞추는 게임입니다.

유저가 세 자리 숫자를 제안하면 해당 숫자에서 정답과 유사한지 확인한 이후 힌트를 제출합니다. 

---

## ⏰ 프로젝트 일정

- **시작일**: 25/03/17  
- **종료일**: 25/03/21

---

## 📱 주요 기능

1. **로비**  
   코드를 실행하면 사용방법이나 게임 기록을 확인할 수 있고 게임을 실행하거나 종료할 수 있습니다.

2. **게임 시작**  
   게임을 시작하고 사용자가 숫자를 입력하면 해당숫자를 정답과 비교해 힌트를 출력합니다.

3. **정답**
   사용자가 정답을 맞추면 로비로 돌아오며 해당 게임의 기록이 저장됩니다.

   실행을 종료하기 전에는 언제든지 로비에서 게임의 기록들을 확인할 수 있습니다. 

---

## ℹ️ 기능 구현 방식

while문을 통해 게임에 지속적인 참여가 가능하도록 구현

고차함수 map을 이용해 입력받은 문자열을 숫자의 배열로 변환해 정답과 대조하는 기능을 사용

루프문 내에서 예외처리 발생 시 continue를 통해 이후 코드를 패스하고 다음 루프로 진입하는 기능 사용 등등

---

## 🔫 Trouble Shooting

**정답을 생성하는 과정에서 random함수를 이용해 사용하고 싶은데 중복되는 값이 발생**
> - 0~9까지 담긴 배열을 생성해두고 6번 랜덤하게 remove하는 방법
>   - 첫 번째 자리에 0이 들어갈 수 있음
>   - 조건문을 걸고 계속 shuffle하면 되긴 하지만 코드가 길어짐
>   - 별로 맘에 들지 않음
>   - **-> while문을 이용해 정답 변수의 count가 3이 될 때까지 정답 변수와 random함수로 생성된 숫자를 비교해 append**

**play() 함수 내에 거의 모든 코드를 작성했기에 로비를 구현하는 과정에서 여러 문제 발생(조건문, 루프문 탈출이 안되는 현상 등등)**
> **-> 로비와 게임 함수를 나눠서 작성해 오류 해결**

**기록을 출력할 변수를 생성하는 방법에 대한 고민**
> - Dictionary를 사용
>   - 순서가 랜덤으로 출력됨
> - String 변수를 만들어 게임이 끝날 때 [변수 += "~~~~~ \n"] 되도록 사용
>   - 마지막에 줄바꿈이 돼서 출력됨
> - [String] 배열을 만들어 게임이 끝날 때 "~~~~~~~"를 append
>   - **-> 가장 깔끔하게 출력됨**

---

## 🎄파일 구조

```bash
├── BaseballGame
│   ├── BaseballGame.swift
│   └── main.swift
├── BaseballGame.xcodeproj
│   ├── project.pbxproj
│   ├── project.xcworkspace
│   │   ├── contents.xcworkspacedata
│   │   ├── xcshareddata
│   │   │   └── swiftpm
│   │   │       └── configuration
│   │   └── xcuserdata
│   │       └── choegyuhyeon.xcuserdatad
│   │           └── UserInterfaceState.xcuserstate
│   └── xcuserdata
│       └── choegyuhyeon.xcuserdatad
│           └── xcschemes
│               └── xcschememanagement.plist
└── README.md
```
