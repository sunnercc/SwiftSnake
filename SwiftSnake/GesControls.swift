//
//  GesControls.swift
//  SwiftSnake
//
//  Created by ifuwo on 17/3/21.
//  Copyright © 2017年 ifuwo. All rights reserved.
//

import UIKit

class GesControls: NSObject {

    /// 主控制器
    var controller: MainViewController? = nil
    
    init(controller: MainViewController) {
        super.init()
        
        self.controller = controller
    }
    
    func addSwipeGes() {
        
        /// 添加轻扫手势
        let swipeGesLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesLeft(ges:)))
        swipeGesLeft.direction = .left
        self.controller?.gameMainScrren?.addGestureRecognizer(swipeGesLeft)
        
        let swipeGesRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesRight(ges:)))
        swipeGesRight.direction = .right
        self.controller?.gameMainScrren?.addGestureRecognizer(swipeGesRight)
        
        let swipeGesDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesDown(ges:)))
        swipeGesDown.direction = .down
        self.controller?.gameMainScrren?.addGestureRecognizer(swipeGesDown)
        
        let swipeGesUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesUp(ges:)))
        swipeGesUp.direction = .up
        self.controller?.gameMainScrren?.addGestureRecognizer(swipeGesUp)
        
        /// 添加点击手势
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapGes(ges:)))
        self.controller?.gameMainScrren?.addGestureRecognizer(tapGes)
        
    }
    
    @objc private func swipeGesLeft(ges: UISwipeGestureRecognizer) {
        
        self.leftAction()
        
    }
    
    @objc private func swipeGesRight(ges: UISwipeGestureRecognizer) {
        
        self.rightAction()
        
    }
    
    @objc private func swipeGesDown(ges: UISwipeGestureRecognizer) {
        
        self.downAction()
        
    }
    
    @objc private func swipeGesUp(ges: UISwipeGestureRecognizer) {
        
        self.upAction()
        
    }
    
    @objc private func tapGes(ges: UITapGestureRecognizer) {
        
        if self.controller?.gameControl?.timer?.isValid == true {
            /// 游戏暂停
            self.controller?.gameControl?.waitGame()
        } else {
            /// 游戏开始
            self.controller?.gameControl?.startGame()
        }
    }
}

extension GesControls {
    fileprivate func upAction() {
        
        if self.controller?.gameGround?.snakeMoveDir != .DirectionUp
            && self.controller?.gameGround?.snakeMoveDir != .DirectionDown
        {
            self.controller?.gameGround?.snakeMoveDir = .DirectionUp
        }
    }
    
    fileprivate func downAction() {
        
        if self.controller?.gameGround?.snakeMoveDir != .DirectionUp
            && self.controller?.gameGround?.snakeMoveDir != .DirectionDown
        {
            self.controller?.gameGround?.snakeMoveDir = .DirectionDown
        }
        
    }
    
    fileprivate func leftAction() {
        
        if self.controller?.gameGround?.snakeMoveDir != .DirectionLeft
            && self.controller?.gameGround?.snakeMoveDir != .DirectionRight
        {
            self.controller?.gameGround?.snakeMoveDir = .DirectionLeft
        }
        
    }
    
    fileprivate func rightAction() {
        
        if self.controller?.gameGround?.snakeMoveDir != .DirectionLeft
            && self.controller?.gameGround?.snakeMoveDir != .DirectionRight
        {
            self.controller?.gameGround?.snakeMoveDir = .DirectionRight
        }
        
    }
}
