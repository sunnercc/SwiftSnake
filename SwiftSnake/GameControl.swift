//
//  GameControl.swift
//  SwiftSnake
//
//  Created by ifuwo on 17/3/21.
//  Copyright © 2017年 ifuwo. All rights reserved.
//

import UIKit

class GameControl: NSObject {
    
    /// 游戏场地
    var gameGround: GameGround? = nil
    
    /// 游戏信息
    var gameMsg: GameMsg? = nil
    
    /// 定时器
    var timer: Timer? = nil
    
    /// 当前定时器时间
    var repeatTime: TimeInterval = TimeInterval(0.5) {
        didSet {
            self.timer?.invalidate()
            self.timer = self.createTimer(timeRepeats: repeatTime)
        }
    }
    
    /// 已经吃到的食物个数
    var foodeats: Int = 0 {
        didSet {
            self.gameMsg?.foodeats = self.foodeats
        }
    }
    
    init(gameGround: GameGround, gameMsg: GameMsg) {
        self.gameGround = gameGround
        self.gameMsg = gameMsg
    }
}

extension GameControl {
    
    @objc func timerAction() {
        
        let header = self.gameGround?.snakeBodys.first
        if let header = header , let food = self.gameGround?.food {
            if header.pos.x-1 == food.pos.x
                && header.pos.y == food.pos.y {
                self.gameGround?.snakeBodys.insert(food, at: 0)
                self.foodeats += 1
                food.boxType = .BoxTypeSnakeHeader
                self.gameGround?.initialFoods()
            }
            
            if header.pos.x+1 == food.pos.x
                && header.pos.y == food.pos.y {
                self.gameGround?.snakeBodys.insert(food, at: 0)
                self.foodeats += 1
                food.boxType = .BoxTypeSnakeHeader
                self.gameGround?.initialFoods()
            }
            
            if header.pos.x == food.pos.x
                && header.pos.y+1 == food.pos.y {
                self.gameGround?.snakeBodys.insert(food, at: 0)
                self.foodeats += 1
                food.boxType = .BoxTypeSnakeHeader
                self.gameGround?.initialFoods()
            }
            
            if header.pos.x == food.pos.x
                && header.pos.y-1 == food.pos.y {
                self.gameGround?.snakeBodys.insert(food, at: 0)
                self.foodeats += 1
                food.boxType = .BoxTypeSnakeHeader
                self.gameGround?.initialFoods()
            }
        }
        
        guard let dir = self.gameGround?.snakeMoveDir else {
            return
        }
        
        switch dir {
        case .DirectionUp:
            let snakeHeader = self.gameGround?.snakeBodys.first
            let x = snakeHeader?.pos.x
            let y = (snakeHeader?.pos.y)! - 1
            
            // 判断蛇下一步的行为
            if self.deferSnakeNextAction(x: x!, y: y) == false {
                return
            }
            
        case .DirectionDown:
            let snakeHeader = self.gameGround?.snakeBodys.first
            let x = snakeHeader?.pos.x
            let y = (snakeHeader?.pos.y)! + 1
            
            // 判断蛇下一步的行为
            if self.deferSnakeNextAction(x: x!, y: y) == false {
                return
            }
            
        case .DirectionLeft:
            let snakeHeader = self.gameGround?.snakeBodys.first
            let x = (snakeHeader?.pos.x)! - 1
            let y = snakeHeader?.pos.y
            
            // 判断蛇下一步的行为
            if self.deferSnakeNextAction(x: x, y: y!) == false {
                return
            }
            
        case .DirectionRight:
            let snakeHeader = self.gameGround?.snakeBodys.first
            let x = (snakeHeader?.pos.x)! + 1
            let y = snakeHeader?.pos.y
            
            // 判断蛇下一步的行为
            if self.deferSnakeNextAction(x: x, y: y!) == false {
                return
            }
        }
        
        // 遍历蛇身,如果发现是headerType就更改为bodyType
        guard let snakeCount = self.gameGround?.snakeBodys.count else {
            return
        }
        
        for i in 1..<snakeCount {
            if self.gameGround?.snakeBodys[i].boxType != .BoxTypeSnakeBody {
                self.gameGround?.snakeBodys[i].boxType = .BoxTypeSnakeBody
            }
        }
        
        // 更改显示界面以及时间调整
        self.udpateMsgAndTimer()
    }
    
    /// 判断蛇下一步的行为
    private func deferSnakeNextAction(x: Int, y: Int) -> Bool {
        
        if x < 0
            || x >= (self.gameGround?.rowCount)!
            || y < 0
            || y >= (self.gameGround?.columnCount)!
        {
            print("gameover")
            self.timer?.invalidate()
            return false
        }
        
        /// 撞到自己会死亡
        for i in 0..<(self.gameGround?.snakeBodys.count)! {
            
            if let box = self.gameGround?.snakeBodys[i] {
                
                if box.pos.x == x
                && box.pos.y == y {
                    
                    print("gameover")
                    self.timer?.invalidate()
                    return false

                }
            }
        }
        
        
        let needAdd = self.gameGround?.boxArrs[x][y];
        if let needAdd = needAdd {
            needAdd.boxType = .BoxTypeSnakeHeader
            self.gameGround?.snakeBodys.insert(needAdd, at: 0)
        }
        
        let snakeFooter = self.gameGround?.snakeBodys.last
        if let snakeFooter = snakeFooter {
            snakeFooter.boxType = .BoxTypeGround
            self.gameGround?.snakeBodys.removeLast()
        }
        
        return true
        
    }
    
    private func udpateMsgAndTimer() {
        
        self.gameMsg?.snakeBodyCounts = (self.gameGround?.snakeBodys.count)!
        if let snakeBodyCount = self.gameMsg?.snakeBodyCounts {
            
            if snakeBodyCount == 5 {
                self.gameMsg?.snakeRepeatsTime = TimeInterval(0.4)
                if self.gameMsg?.snakeRepeatsTime != self.repeatTime {
                    self.repeatTime = (self.gameMsg?.snakeRepeatsTime)!
                }
            }
            
            if snakeBodyCount == 7 {
                self.gameMsg?.snakeRepeatsTime = TimeInterval(0.3)
                if self.gameMsg?.snakeRepeatsTime != self.repeatTime {
                    self.repeatTime = (self.gameMsg?.snakeRepeatsTime)!
                }
            }
            
            
            if snakeBodyCount == 9 {
                self.gameMsg?.snakeRepeatsTime = TimeInterval(0.2)
                if self.gameMsg?.snakeRepeatsTime != self.repeatTime {
                    self.repeatTime = (self.gameMsg?.snakeRepeatsTime)!
                }
            }
            
            if snakeBodyCount >= 11 {
                self.gameMsg?.snakeRepeatsTime = TimeInterval(0.1)
                if self.gameMsg?.snakeRepeatsTime != self.repeatTime {
                    self.repeatTime = (self.gameMsg?.snakeRepeatsTime)!
                }
            }
            
            if snakeBodyCount > 1
                && snakeBodyCount <= 10{
                self.gameMsg?.progressCounts = 1
            }

            if var currentProgressCount = self.gameMsg?.progressCounts {
                if snakeBodyCount > currentProgressCount * 10
                   && snakeBodyCount <= (currentProgressCount + 1) * 10
                {
                    currentProgressCount += 1
                    self.gameMsg?.progressCounts = currentProgressCount
                }
            }
        }
        
    }
    
    fileprivate func createTimer(timeRepeats: TimeInterval) -> Timer {
        
        return Timer.scheduledTimer(timeInterval: timeRepeats, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    /// 开始游戏
    func startGame() {
        self.timer?.invalidate()
        self.timer = self.createTimer(timeRepeats: self.repeatTime)
    }
    
    /// 暂停游戏
    func waitGame() {
        self.stopGame()
    }
    
    /// 结束游戏
    func stopGame() {
        self.timer?.invalidate()
    }
    
}
