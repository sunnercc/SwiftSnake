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
    
    /// 定时器
    var timer: Timer? = nil
    
    init(gameGround: GameGround) {
        self.gameGround = gameGround
    }
    
}

extension GameControl {
    
    @objc func timerAction() {
        
        let header = self.gameGround?.snakeBodys.first
        if let header = header , let food = self.gameGround?.food {
            if header.pos.x-1 == food.pos.x
                && header.pos.y == food.pos.y {
                self.gameGround?.snakeBodys.insert(food, at: 0)
                food.boxType = .BoxTypeSnakeHeader
                self.gameGround?.initialFoods()
            }
            
            if header.pos.x+1 == food.pos.x
                && header.pos.y == food.pos.y {
                self.gameGround?.snakeBodys.insert(food, at: 0)
                food.boxType = .BoxTypeSnakeHeader
                self.gameGround?.initialFoods()
            }
            
            if header.pos.x == food.pos.x
                && header.pos.y+1 == food.pos.y {
                self.gameGround?.snakeBodys.insert(food, at: 0)
                food.boxType = .BoxTypeSnakeHeader
                self.gameGround?.initialFoods()
            }
            
            if header.pos.x == food.pos.x
                && header.pos.y-1 == food.pos.y {
                self.gameGround?.snakeBodys.insert(food, at: 0)
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
            
            if x! < 0
                || x! >= (self.gameGround?.rowCount)!
                || y < 0
                || y >= (self.gameGround?.columnCount)!
            {
                print("gameover")
                self.timer?.invalidate()
                return
            }
            
            let needAdd = self.gameGround?.boxArrs[x!][y];
            if let needAdd = needAdd {
                needAdd.boxType = .BoxTypeSnakeHeader
                self.gameGround?.snakeBodys.insert(needAdd, at: 0)
            }
            
            let snakeFooter = self.gameGround?.snakeBodys.last
            if let snakeFooter = snakeFooter {
                snakeFooter.boxType = .BoxTypeGround
                self.gameGround?.snakeBodys.removeLast()
            }
            
        case .DirectionDown:
            let snakeHeader = self.gameGround?.snakeBodys.first
            let x = snakeHeader?.pos.x
            let y = (snakeHeader?.pos.y)! + 1
            
            if x! < 0
                || x! >= (self.gameGround?.rowCount)!
                || y < 0
                || y >= (self.gameGround?.columnCount)!
            {
                print("gameover")
                self.timer?.invalidate()
                return
            }
            
            let needAdd = self.gameGround?.boxArrs[x!][y];
            if let needAdd = needAdd {
                needAdd.boxType = .BoxTypeSnakeHeader
                self.gameGround?.snakeBodys.insert(needAdd, at: 0)
            }
            
            let snakeFooter = self.gameGround?.snakeBodys.last
            if let snakeFooter = snakeFooter {
                snakeFooter.boxType = .BoxTypeGround
                self.gameGround?.snakeBodys.removeLast()
            }
        case .DirectionLeft:
            let snakeHeader = self.gameGround?.snakeBodys.first
            let x = (snakeHeader?.pos.x)! - 1
            let y = snakeHeader?.pos.y
            
            if x < 0
                || x >= (self.gameGround?.rowCount)!
                || y! < 0
                || y! >= (self.gameGround?.columnCount)!
            {
                print("gameover")
                self.timer?.invalidate()
                return
            }
            
            let needAdd = self.gameGround?.boxArrs[x][y!];
            if let needAdd = needAdd {
                needAdd.boxType = .BoxTypeSnakeHeader
                self.gameGround?.snakeBodys.insert(needAdd, at: 0)
            }
            
            let snakeFooter = self.gameGround?.snakeBodys.last
            if let snakeFooter = snakeFooter {
                snakeFooter.boxType = .BoxTypeGround
                self.gameGround?.snakeBodys.removeLast()
            }
        case .DirectionRight:
            let snakeHeader = self.gameGround?.snakeBodys.first
            let x = (snakeHeader?.pos.x)! + 1
            let y = snakeHeader?.pos.y
            
            if x < 0
                || x >= (self.gameGround?.rowCount)!
                || y! < 0
                || y! >= (self.gameGround?.columnCount)!
            {
                print("gameover")
                self.timer?.invalidate()
                return
            }
            
            let needAdd = self.gameGround?.boxArrs[x][y!];
            if let needAdd = needAdd {
                needAdd.boxType = .BoxTypeSnakeHeader
                self.gameGround?.snakeBodys.insert(needAdd, at: 0)
            }
            
            let snakeFooter = self.gameGround?.snakeBodys.last
            if let snakeFooter = snakeFooter {
                snakeFooter.boxType = .BoxTypeGround
                self.gameGround?.snakeBodys.removeLast()
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
    }
    
    
    /// 开始游戏
    func startGame() {
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
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
