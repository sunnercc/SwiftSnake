//
//  MainViewController.swift
//  SwiftSnake
//
//  Created by ifuwo on 17/3/20.
//  Copyright © 2017年 ifuwo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    /// 游戏全屏view
    var gameMainScrren: GameMainScreenView? = nil
    
    /// 游戏场地
    var gameGround: GameGround? = nil
    
    /// 游戏信息view
    var gameMsg: GameMsg? = nil
    
    /// 游戏控制
    var gameControl: GameControl? = nil
    
    /// 全局控制手势
    var gesControls: GesControls? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .gray
        
        /// 添加游戏主场地
        self.addGameMainScrren()
        
        /// 添加游戏控制
        self.addGameControls()
        
        /// 添加全局控制
        self.addGestureControls()

        /// 开始游戏
        self.gameControl?.startGame()
    }
}

extension MainViewController {
    
    fileprivate func addGameMainScrren() {
        
        self.gameMainScrren = GameMainScreenView(frame: self.view.bounds)
        if let gameMainScrren = self.gameMainScrren {
            self.view.addSubview(gameMainScrren)
        }
        
        /// 添加游戏区域
        self.gameGround = GameGround(frame: (self.gameMainScrren?.gameGroundFrame)!)
        if let gameGround = self.gameGround {
            self.gameMainScrren?.addSubview(gameGround)
        }
        
        /// 添加游戏信息区域
        self.gameMsg = GameMsg(frame: (self.gameMainScrren?.gameMsgFrame)!)
        if let gameMsg = self.gameMsg {
            self.gameMainScrren?.addSubview(gameMsg)
        }
    }
    
    fileprivate func addGameGround() {
        
        self.gameGround = GameGround(frame: self.view.bounds)
        
        self.view.addSubview(self.gameGround!)
        
    }
    
    fileprivate func addGameControls() {
        
        if let gameGround = self.gameGround, let gameMsg = self.gameMsg {
            self.gameControl = GameControl(gameGround: gameGround, gameMsg: gameMsg)
        }
    }
    
    fileprivate func addGestureControls() {
        self.gesControls = GesControls(controller: self)
        
        /// 添加轻扫手势
        self.gesControls?.addSwipeGes()
        
    }
}
