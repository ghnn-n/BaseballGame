//
//  Baseball.swift
//  BaseballGame
//
//  Created by 최규현 on 3/17/25.
//
import Foundation

struct BaseballGame {
    var isSolved = true         // 유저가 정답을 맞췄는지 여부
    var numberOfGames = 0       // 몇 번째 게임인지 기록할 변수
    var numberOfTries = 0       // 몇 번째 시도 중인지 기록할 변수
    
    var score: [String] = []    // 게임 기록이 정리되서 할당될 변수
    
    // 발생할 수 있는 오류 정의
    enum GameError: Error {
        case invalidinput
        case invalidLength
        case invalidNumber
        case duplicatedNumber
        case callExit
    }
    
    // 정답을 생성하는 메서드
    mutating func setCorrect() -> [Int] {
        var correct: [Int] = []
        
        correct.append(Int.random(in: 1...9))   // 첫 번째 숫자는 0이 될 수 없으므로 1~9
        
        while correct.count < 3 {               // correct에 숫자가 3개 담길 때까지
            let num = Int.random(in: 0...9)     // 0~9까지 중 랜덤한 숫자를 생성
            if !correct.contains(num) {         // correct에 해당 숫자가 없으면
                correct.append(num)             // append
            }
        }
        return correct
    }
    
    // 게임 시작 전(로비?)
    mutating func start() {
        
        enum GetNumber: String {
            case start = "1"
            case history = "2"
            case info = "3"
            case quit = "4"
        }
        
        while isSolved {
            print("""
                  원하는 번호를 입력해주세요.
                  1. 게임 시작  2. 게임 기록  3. 게임 설명  4. 종료
                  """)
            
            let getNumber = readLine() ?? ""
            
            switch GetNumber(rawValue: getNumber) {
            case .start:
                isSolved = false        // 게임이 시작될 수 있도록 정답 처리를 false로 변경
                numberOfGames += 1      // 시작을 누르면 게임 횟수 증가
                
                do {
                    try gamePlay()
                } catch GameError.invalidinput {
                    print("숫자만 입력해주세요. ")
                } catch GameError.invalidLength {
                    print("세 자리의 숫자를 입력해주세요. ")
                } catch GameError.invalidNumber {
                    print("맨 앞 자리의 숫자는 0이 될 수 없습니다. ")
                } catch GameError.duplicatedNumber {
                    print("중복되는 숫자는 입력할 수 없습니다. ")
                } catch GameError.callExit {
                    print("게임을 종료합니다. ")
                } catch {
                    print("알 수 없는 오류. ")
                }
                
            case .history:                   // 스코어 출력
                guard !score.isEmpty else { print("기록이 없습니다. "); continue } // 기록이 없을 경우
                for i in score {
                    print(i)
                }
            case .info:                   // 게임 설명
                print("""
                    정답은 0~9까지의 수 중 겹치지 않는 세 자리의 숫자입니다.
                    정답은 0으로 시작할 수 없습니다.
                    입력하신 숫자 중 맞는 숫자는 strike,
                    정답에 포함되긴 하지만 위치가 안 맞는 경우는 ball로 표시합니다. 
                    """)
            case .quit:
                isSolved = false        // 해당 루프문을 탈출
            default:    // 잘못된 값을 입력 시
                print("다시 입력하세요. ")
                continue
            }
        }
    }
    
    // 게임 시작
    mutating func gamePlay() throws {
        let correct = setCorrect()  // 정답 생성
        
        print("""
              게임을 시작합니다. 세 자리 숫자를 입력하세요.
              게임을 끝내고 싶으시면 [exit]을 입력하세요
              """)
        
        while !isSolved {           // 유저가 답을 맞추지 못하면(false이면) 반복
            var strike = 0
            var ball = 0
            
            print(correct)              // 테스트를 위해 정답을 알고 시작함(실제 게임에선 주석처리)
            
            let input = readLine() ?? ""    // 유저의 입력값
            
            // 유저가 게임 도중 게임을 종료할 수 있게 함
            guard input != "exit" else { throw GameError.callExit }
            
            // 유저의 입력값을 Int 배열로 반환
            let inputArray: [Int] = try input.map {
                guard let input = Int(String($0)) else { throw GameError.invalidinput }
                return input
            }
            
            // 예외처리: 입력 값 첫 번째가 0인지 체크
            guard inputArray[0] != 0 else { throw GameError.invalidNumber }
            
            // 예외처리: 중복 값이 있는지 체크
            guard Set(inputArray).count == 3 else { throw GameError.duplicatedNumber }
            
            for i in 0...2 {
                if correct[i] == inputArray[i] {            // 같은 위치에 같은 값이 있을 경우
                    strike += 1
                } else if correct.contains(inputArray[i]) { // 같은 값이 다른 위치에 있을 경우
                    ball += 1
                }
            }
            
            if strike == 3 {                        // 총 strike가 3개면 정답
                print("정답입니다!")
                isSolved = true
            } else if strike == 0 && ball == 0 {    // strike, ball 하나도 없으면
                print("Nothing")
            } else {                                // 맞춘 게 있으면 힌트 출력
                print("\(strike) strike, \(ball) ball")
            }
            
            numberOfTries += 1      // 시도 횟수 1 증가
        }
        
        // 정답을 맞춰서 루프문을 빠져나옴
        score.append("\(numberOfGames)번째 게임: \(numberOfTries)번 시도") // 스코어를 기록
        numberOfTries = 0   // 시도 횟수를 초기화
        start()              // 로비 재입장
    }
}
