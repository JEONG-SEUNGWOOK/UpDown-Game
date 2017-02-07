//
//  UpDownGame.swift
//  UpDownGameApp
//
//  Created by Seungwook Jeong on 2017. 1. 26..
//  Copyright © 2017년 boostcamp. All rights reserved.
//

import Foundation

struct UpDownGame{
    static let right = 0
    static let over = -2
    static let up = 1
    static let down = -1
    
    private let answer : Int?
    private var limitCount : Int = 5
    private var max : UInt32 = 10
    private var count : Int = 0
    
    public var log = [String]()
    
    init(max : UInt32){
        answer = Int(arc4random_uniform(max)) + 1
        self.max = max
        
        if answer! <= 10 {
            limitCount = 5
        }
        else if answer! <= 50 {
            limitCount = 10
        }
        else {
            limitCount = 20
        }
    }
    
    mutating func isIt(_ value : Int) -> Int {
        if value == answer {
            print("Right!")
        }
        else {
            if limitCount == count {
                print("Game Over!")
                return UpDownGame.over
            }
            else if value > answer! {
                print("Down!")
                count += 1
                return UpDownGame.down
            }
            else if value < answer! {
                print("Up!")
                count += 1
                return UpDownGame.up
            }
        }
        return UpDownGame.right
    }
    
    mutating func reset(){
        self = UpDownGame(max: max)
    }
    
    func getCount() -> Int {
        return self.count
    }
    
    func getAnswer() -> Int {
        return self.answer!
    }
    
    func getMax() -> UInt32 {
        return self.max
    }
    
    func getLimitCount() -> Int {
        return self.limitCount
    }
    
    func getLogCount() -> Int {
        return self.log.count
    }
    
    func getLogData(_ index: Int) -> String {
        return log[index]
    }
    
    mutating func appendLog(_ log: String) {
        self.log.append(log)
    }
    
    mutating func setMax(_ max: UInt32) {
        self.max = max
    }
    
    mutating func setLimitCount(_ limitCount: Int) {
        self.limitCount = limitCount
    }
    
    func getValue() -> (answer : Int, limit: Int, count: Int) {
        return (self.answer!, self.limitCount, self.count)
    }
    
    
}
