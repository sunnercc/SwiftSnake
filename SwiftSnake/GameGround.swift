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
    var rowCount: Int = Int(goundGameW / boxW)
    
    /// 一列存储的box数量
    var columnCount: Int = Int(goundGameH / boxH)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        
        /// 布局boxes
        self.layoutBoxes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameGround {
    
    /// 布局boxes
    fileprivate func layoutBoxes() {
     
        let rowEdgeMargin: CGFloat = (goundGameW - boxW * CGFloat(self.rowCount)) * 0.5
        
        let columnEdgeMargin: CGFloat = (goundGameH - boxH * CGFloat(self.columnCount)) * 0.5
        
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
}
