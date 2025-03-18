//
//  Baseball.swift
//  BaseballGame
//
//  Created by 최규현 on 3/17/25.
//
import Foundation

struct BaseballGame {
    var isSolved = true        // 유저가 정답을 맞췄는지 여부
    
    mutating func setCorrect() -> [Int] {   // 정답을 생성하는 메서드
        var correct: [Int] = []
        
        correct.append(Int.random(in: 1...9))   // 첫 번째 숫자는 0이 될 수 없음
        
        while correct.count < 3 {               // correct에 숫자가 3개 담길 때까지
            let num = Int.random(in: 0...9)     // 0~9까지 중 랜덤한 숫자를 생성
            if !correct.contains(num) {         // correct에 해당 숫자가 없으면
                correct.append(num)             // append
            }
        }
        return correct
    }
    
    mutating func checkInput(_ num: [Int]) -> Bool {    // 중복 값을 입력했는지 확인하는 메서드
        let numSet = Set(num)                           // 받아온 배열을 Set으로 변환
        if num.count == numSet.count {                  // Set으로 변환한 배열과 원래 배열의 count를 대조
            return true                                 // count가 같으면 true를 반환
        } else {
            return false
        }
    }
    
    mutating func gameStart() {
        while isSolved {
            print("원하는 번호를 입력해주세요. \n"
            + "1. 게임 시작  2. 게임 기록  3. 게임 설명  4. 종료")
            
            let getNumber = readLine() ?? ""
            
            switch getNumber {
            case "1":
                isSolved = false
            case "2":
                print("history")
            case "3":
                print("정답은 0~9까지의 수 중 겹치지 않는 세 자리의 숫자입니다. \n"
                      + "정답은 0으로 시작할 수 없습니다. \n"
                      + "입력하신 숫자 중 맞는 숫자는 strike, \n"
                      + "정답에 포함되긴 하지만 위치가 안 맞는 경우는 ball로 표시합니다. ")
            case "4":
                return
            default:
                print("다시 입력하세요. ")
                continue
            }
        }
    }
    
    mutating func play() {
        let correct = setCorrect()  // 정답 생성
        
        var strike = 0
        var ball = 0
        
        gameStart()
        
        while !isSolved {           // 유저가 답을 맞추지 못하면(false이면) 반복
            print("게임을 시작합니다. 세 자리 숫자를 입력하세요. \n"
                  + "게임을 끝내고 싶으시면 [exit]을 입력하세요")
            print(correct)              // 테스트를 위해 정답을 알고 시작함(실제 게임에선 주석처리)
            let input = readLine() ?? ""    // 유저의 입력값
            let inputArray: [Int] = input.map { Int(String($0)) ?? 0 }  // 유저의 입력값을 Int 배열로 반환
            
            guard input != "exit" else { return }   // 유저가 직접 게임을 종료할 수 있게 함
            
            guard input.count == 3 &&           // 예외처리: 입력 값이 숫자인지, 3자리인지 체크
                    Int(input) != nil else {
                print("3자리의 숫자만 입력하세요. ")
                continue
            }
            
            guard inputArray[0] != 0 else {     // 예외처리: 입력 값 첫 번째가 0인지 체크
                print("0은 첫 번째 자리에 올 수 없습니다. ")
                continue
            }
            
            guard checkInput(inputArray) else { // 예외처리: 중복 값이 있는지 체크
                print("중복되는 값은 넣을 수 없습니다. ")
                continue
            }
            
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
                strike = 0
                ball = 0
            }
        }
        
        gameStart()
    }
}
