//
//  Baseball.swift
//  BaseballGame
//
//  Created by 최규현 on 3/17/25.
//
import Foundation

struct BaseballGame {
    mutating func setCorrect() -> [Int] {   // 정답을 생성하는 메서드
        var correct: [Int] = []
        
        while correct.count < 3 {               // correct에 숫자가 3개 담길 때까지
            let num = Int.random(in: 1...9)     // 1~9까지 중 랜덤한 숫자를 생성
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
    
    mutating func play() {
        let correct = setCorrect()  // 정답 생성
        var isSolved = false        // 유저가 정답을 맞췄는지 여부
        
        var strike = 0
        var ball = 0
        
        print("야구게임을 시작합니다. ")
        print("0을 포함하지 않은 3자리의 숫자를 입력하세요. ")
        print("strike: 정답인 숫자가 정확한 위치에 있을 경우")
        print("ball: 정답인 숫자를 포함하고 있지만 정확한 위치가 아닐 경우")
        print(correct)              // 테스트를 위해 정답을 알고 시작함(실제 게임에선 주석처리)
        
        while !isSolved {           // 유저가 답을 맞추지 못하면(false이면) 반복
            let input = readLine() ?? ""    // 유저의 입력값
            let inputArray: [Int] = input.map { Int(String($0)) ?? 0 }  // 유저의 입력값을 Int 배열로 반환
            
            guard input.count == 3 &&           // 예외처리: 입력 값이 숫자인지, 3자리인지 체크
                    Int(input) != nil else {
                print("3자리의 숫자만 입력하세요. ")
                continue
            }
            
            guard !input.contains("0") else {   // 예외처리: 입력 값에 0이 포함되는지 체크
                print("0은 입력할 수 없습니다. ")
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
    }
}
