//
//  GameMsg.swift
//  SwiftSnake
//
//  Created by ifuwo on 17/3/22.
//  Copyright © 2017年 ifuwo. All rights reserved.
//

import UIKit

class GameMsg: UIView {

    /// 蛇身长度
    var snakeBodyCounts: Int = 2 {
        didSet {
            self.layoutSubviews()
        }
    }
    
    /// 移动时间间隔
    var snakeRepeatsTime: TimeInterval = TimeInterval(0.5) {
        didSet {
            self.layoutSubviews()
        }
    }
    
    /// 游戏关卡
    var progressCounts: Int = 1 {
        didSet {
            self.layoutSubviews()
        }
    }
    
    /// 得分(吃到的食物)
    var foodeats: Int = 0 {
        didSet {
            self.layoutSubviews()
        }
    }
    
    
    private var snakeBodyCountsTF: UITextField = UITextField()
    
    private var snakeRepeatsTimeTF: UITextField = UITextField()
    
    private var progressCountsTF: UITextField = UITextField()
    
    private var foodeatsTF: UITextField = UITextField()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        self.addTextFileds()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addTextFileds() {
        
        /// 左右margin
        let LRmargin: CGFloat = 20
        /// 上下margin
        let DUmargin: CGFloat = 30
        
        let x: CGFloat = LRmargin
        
        let w: CGFloat = self.frame.size.width - 2 * LRmargin
        
        let h: CGFloat = 20
        
        var y: CGFloat = 50
        
        
        // 添加蛇的身体count
        self.snakeBodyCountsTF.frame = CGRect(x: x, y: y, width: w, height: h)
        self.snakeBodyCountsTF.text = "长度:\(self.snakeBodyCounts)"
        self.snakeBodyCountsTF.textColor = .yellow
        self.snakeBodyCountsTF.isUserInteractionEnabled = false
        self.addSubview(self.snakeBodyCountsTF)
        
        /// 添加时间
        y += (h + DUmargin)
        self.snakeRepeatsTimeTF.frame = CGRect(x: x, y: y, width: w, height: h)
        self.snakeRepeatsTimeTF.text = "时间:\(self.snakeRepeatsTime)"
        self.snakeRepeatsTimeTF.textColor = .yellow
        self.snakeRepeatsTimeTF.isUserInteractionEnabled = false
        self.addSubview(self.snakeRepeatsTimeTF)
        
        /// 添加游戏关卡
        y += (h + DUmargin)
        self.progressCountsTF.frame = CGRect(x: x, y: y, width: w, height: h)
        self.progressCountsTF.text = "关卡:\(self.progressCounts)"
        self.progressCountsTF.textColor = .yellow
        self.progressCountsTF.isUserInteractionEnabled = false
        self.addSubview(self.progressCountsTF)
        
        /// 添加得分
        y += (h + DUmargin)
        self.foodeatsTF.frame = CGRect(x: x, y: y, width: w, height: h)
        self.foodeatsTF.text = "得分:\(self.foodeats)"
        self.foodeatsTF.textColor = .yellow
        self.foodeatsTF.isUserInteractionEnabled = false
        self.addSubview(self.foodeatsTF)
    }
    
    override func layoutSubviews() {
        
        self.snakeBodyCountsTF.text = "长度:\(self.snakeBodyCounts)"
        
        self.snakeRepeatsTimeTF.text = "时间:\(self.snakeRepeatsTime)"
        
        self.progressCountsTF.text = "关卡:\(self.progressCounts)"
        
        self.foodeatsTF.text = "得分:\(self.foodeats)"
        
    }

}
