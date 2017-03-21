//
//  GameGround.swift
//  SwiftSnake
//
//  Created by ifuwo on 17/3/20.
//  Copyright © 2017年 ifuwo. All rights reserved.
//

import UIKit

class GameGround: UIView {
    
    /// 存储box的二维数组
    var boxArrs: [[Box]] = [[Box]]()
    
    /// 一行存储的box数量
    var rowCount: Int = 0
    
    /// 一列存储的box数量
    var columnCount: Int = 0
    
    /// 蛇的移动方向
    var snakeMoveDir: Direction = .DirectionDown
    
    /// 存放蛇的数组
    var snakeBodys:[Box] = [Box]()
    
    /// 随机生成的事物
    var food:Box? = nil
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.layer.cornerRadius = 5
        
        /// 布局boxes
        self.layoutBoxes()
        
        /// 初始化蛇数组
        self.initialSnakeBodys()
        
        /// 初始化食物
        self.initialFoods()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameGround {
    
    /// 布局boxes
    fileprivate func layoutBoxes() {
     
        /// 赋值
        self.rowCount = Int(self.bounds.size.width / boxW)
        self.columnCount = Int(self.bounds.size.height / boxH)
        
        let rowEdgeMargin: CGFloat = (self.bounds.size.width - boxW * CGFloat(self.rowCount)) * 0.5
        
        let columnEdgeMargin: CGFloat = (self.bounds.size.height - boxH * CGFloat(self.columnCount)) * 0.5
        
        for row in 0..<self.rowCount {
            
            self.boxArrs.insert([], at: row)
            
            for column in 0..<self.columnCount {
                
                let x = CGFloat(row) * boxW + rowEdgeMargin
                let y = CGFloat(column) * boxH + columnEdgeMargin
                let box = Box(frame: CGRect(x: x, y: y, width: boxW, height: boxH))
                
                box.pos.x = row
                box.pos.y = column
                
                self.boxArrs[row].insert(box, at: column)
                
                self.addSubview(box)
            }
        }
    }
    
    fileprivate func initialSnakeBodys() {
        
        self.snakeBodys.append(self.boxArrs[7][5])
        self.boxArrs[7][5].boxType = .BoxTypeSnakeHeader
        self.snakeBodys.append(self.boxArrs[6][5])
        self.boxArrs[6][5].boxType = .BoxTypeSnakeBody
        self.snakeBodys.append(self.boxArrs[5][5])
        self.boxArrs[5][5].boxType = .BoxTypeSnakeBody
        
    }
    
    func initialFoods() {
        
        let x = arc4random_uniform(UInt32(self.rowCount))
        let y = arc4random_uniform(UInt32(self.columnCount))
        
        self.food = self.boxArrs[Int(x)][Int(y)]
        self.food?.boxType = .BoxTypeFood
        
    }
}
