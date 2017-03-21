//
//  MainViewController.swift
//  SwiftSnake
//
//  Created by ifuwo on 17/3/20.
//  Copyright © 2017年 ifuwo. All rights reserved.
//

import UIKit

enum Direction {
    case DirectionUp
    case DirectionDown
    case DirectionLeft
    case DirectionRight
}

class MainViewController: UIViewController {

    /// 游戏场地
    var gameGound: GameGround? = nil
    
    /// 蛇的移动方向
    var snakeMoveDir: Direction = .DirectionDown
    
    /// 存放蛇的数组
    var snakeBodys:[Box] = [Box]()
    
    /// 随机生成的事物
    var food:Box? = nil
    
    /// 定时器
    lazy var timer: Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .gray
        
        /// 添加游戏场地
        self.addGameGround()
        
        /// 添加方向按键
        self.addControls()
        
        /// 初始化蛇数组
        self.initialSnakeBodys()
        
        /// 初始化食物
        self.initialFoods()
        
        /// 开始游戏
        self.startGame()
    }

    private func addGameGround() {
        
        let y = statusBarH
        
        self.gameGound = GameGround(frame: CGRect(x: gameGoundMargin, y: y, width: goundGameW, height: goundGameH))
        
        self.view.addSubview(self.gameGound!)
        
    }
    
    private func initialSnakeBodys() {
        
        self.snakeBodys.append((self.gameGound?.boxArrs[7][5])!)
        self.gameGound?.boxArrs[7][5].boxType = .BoxTypeSnakeBody
        self.snakeBodys.append((self.gameGound?.boxArrs[6][5])!)
        self.gameGound?.boxArrs[6][5].boxType = .BoxTypeSnakeBody
        self.snakeBodys.append((self.gameGound?.boxArrs[5][5])!)
        self.gameGound?.boxArrs[5][5].boxType = .BoxTypeSnakeBody

    }
    
    fileprivate func initialFoods() {
        
        let x = arc4random_uniform(UInt32((self.gameGound?.rowCount)!))
        let y = arc4random_uniform(UInt32((self.gameGound?.columnCount)!))
        
        let food = self.gameGound?.boxArrs[Int(x)][Int(y)]
        if let food = food {
            food.boxType = .BoxTypeFood
            self.food = food
        }
    }
}

extension MainViewController {
    
    fileprivate func addControls() {
        
        let count: CGFloat = 4
        let width: CGFloat = (screenW - (count+1)*btnMargin) / count
        let y = screenH - btnH - btnMargin
        
        let upBtn = self.createControlBtn(frame: CGRect(x: btnMargin, y: y, width: width, height: btnH), title: "up")
        upBtn.addTarget(self, action: #selector(upAction), for: .touchUpInside)
        
        let downBtn = self.createControlBtn(frame: CGRect(x: upBtn.frame.maxX + btnMargin, y: y, width: width, height: btnH), title: "down")
        downBtn.addTarget(self, action: #selector(downAction), for: .touchUpInside)
        
        let leftBtn = self.createControlBtn(frame: CGRect(x: downBtn.frame.maxX + btnMargin, y: y, width: width, height: btnH), title: "left")
        leftBtn.addTarget(self, action: #selector(leftAction), for: .touchUpInside)
        
        let rightBtn = self.createControlBtn(frame: CGRect(x: leftBtn.frame.maxX + btnMargin, y: y, width: width, height: btnH), title: "right")
        rightBtn.addTarget(self, action: #selector(rightAction), for: .touchUpInside)
        
    }
    
    private func createControlBtn(frame: CGRect, title: String) -> UIButton {
        
        let btn = UIButton(frame: frame)
        btn.setTitle(title, for: .normal)
        btn.backgroundColor = .lightGray
        btn.layer.cornerRadius = 5
        self.view.addSubview(btn)
        
        return btn
    }
}

extension MainViewController {
    
    @objc func timerAction() {
        
        let header = self.snakeBodys.first
        if let header = header , let food = self.food {
            if header.pos.x-1 == food.pos.x
               && header.pos.y == food.pos.y {
                self.snakeBodys.insert(food, at: 0)
                food.boxType = .BoxTypeSnakeBody
                self.initialFoods()
            }
            
            if header.pos.x+1 == food.pos.x
                && header.pos.y == food.pos.y {
                self.snakeBodys.insert(food, at: 0)
                food.boxType = .BoxTypeSnakeBody
                self.initialFoods()
            }
            
            if header.pos.x == food.pos.x
                && header.pos.y+1 == food.pos.y {
                self.snakeBodys.insert(food, at: 0)
                food.boxType = .BoxTypeSnakeBody
                self.initialFoods()
            }
            
            if header.pos.x == food.pos.x
                && header.pos.y-1 == food.pos.y {
                self.snakeBodys.insert(food, at: 0)
                food.boxType = .BoxTypeSnakeBody
                self.initialFoods()
            }
        }
        
        switch self.snakeMoveDir {
        case .DirectionUp:
            let snakeHeader = self.snakeBodys.first
            let x = snakeHeader?.pos.x
            let y = (snakeHeader?.pos.y)! - 1
            
            if x! < 0
               || x! >= (self.gameGound?.rowCount)!
               || y < 0
               || y >= (self.gameGound?.columnCount)!
            {
                print("gameover")
                self.timer?.invalidate()
                return
            }
            
            let needAdd = self.gameGound?.boxArrs[x!][y];
            if let needAdd = needAdd {
                needAdd.boxType = .BoxTypeSnakeBody
                self.snakeBodys.insert(needAdd, at: 0)
            }
            
            let snakeFooter = self.snakeBodys.last
            if let snakeFooter = snakeFooter {
                snakeFooter.boxType = .BoxTypeGround
                self.snakeBodys.removeLast()
            }
            
        case .DirectionDown:
            let snakeHeader = self.snakeBodys.first
            let x = snakeHeader?.pos.x
            let y = (snakeHeader?.pos.y)! + 1
            
            if x! < 0
                || x! >= (self.gameGound?.rowCount)!
                || y < 0
                || y >= (self.gameGound?.columnCount)!
            {
                print("gameover")
                self.timer?.invalidate()
                return
            }
            
            let needAdd = self.gameGound?.boxArrs[x!][y];
            if let needAdd = needAdd {
                needAdd.boxType = .BoxTypeSnakeBody
                self.snakeBodys.insert(needAdd, at: 0)
            }
            
            let snakeFooter = self.snakeBodys.last
            if let snakeFooter = snakeFooter {
                snakeFooter.boxType = .BoxTypeGround
                self.snakeBodys.removeLast()
            }
        case .DirectionLeft:
            let snakeHeader = self.snakeBodys.first
            let x = (snakeHeader?.pos.x)! - 1
            let y = snakeHeader?.pos.y
            
            if x < 0
                || x >= (self.gameGound?.rowCount)!
                || y! < 0
                || y! >= (self.gameGound?.columnCount)!
            {
                print("gameover")
                self.timer?.invalidate()
                return
            }
            
            let needAdd = self.gameGound?.boxArrs[x][y!];
            if let needAdd = needAdd {
                needAdd.boxType = .BoxTypeSnakeBody
                self.snakeBodys.insert(needAdd, at: 0)
            }
            
            let snakeFooter = self.snakeBodys.last
            if let snakeFooter = snakeFooter {
                snakeFooter.boxType = .BoxTypeGround
                self.snakeBodys.removeLast()
            }
        case .DirectionRight:
            let snakeHeader = self.snakeBodys.first
            let x = (snakeHeader?.pos.x)! + 1
            let y = snakeHeader?.pos.y
            
            if x < 0
                || x >= (self.gameGound?.rowCount)!
                || y! < 0
                || y! >= (self.gameGound?.columnCount)!
            {
                print("gameover")
                self.timer?.invalidate()
                return
            }
            
            let needAdd = self.gameGound?.boxArrs[x][y!];
            if let needAdd = needAdd {
                needAdd.boxType = .BoxTypeSnakeBody
                self.snakeBodys.insert(needAdd, at: 0)
            }
            
            let snakeFooter = self.snakeBodys.last
            if let snakeFooter = snakeFooter {
                snakeFooter.boxType = .BoxTypeGround
                self.snakeBodys.removeLast()
            }
        }
    }

    
    func startGame()  {
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
}

extension MainViewController {
    
    @objc fileprivate func upAction() {
        
        if self.snakeMoveDir != .DirectionUp
           && self.snakeMoveDir != .DirectionDown
        {
            self.snakeMoveDir = .DirectionUp
        }
    }
    
    @objc fileprivate func downAction() {
        
        if self.snakeMoveDir != .DirectionUp
            && self.snakeMoveDir != .DirectionDown
        {
            self.snakeMoveDir = .DirectionDown
        }
        
    }
    
    @objc fileprivate func leftAction() {
        
        if self.snakeMoveDir != .DirectionLeft
            && self.snakeMoveDir != .DirectionRight
        {
            self.snakeMoveDir = .DirectionLeft
        }
        
    }
    
    @objc fileprivate func rightAction() {
        
        if self.snakeMoveDir != .DirectionLeft
            && self.snakeMoveDir != .DirectionRight
        {
            self.snakeMoveDir = .DirectionRight
        }
        
    }
}
