//
//  GameMainScreenView.swift
//  SwiftSnake
//
//  Created by ifuwo on 17/3/21.
//  Copyright © 2017年 ifuwo. All rights reserved.
//

import UIKit

class GameMainScreenView: UIView {

    /// 游戏区域frame
    var gameGroundFrame: CGRect = CGRect()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black
        
        /// 布局游戏城墙
        self.layoutGameWalls()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutGameWalls() {
        
        let row = Int(self.bounds.width / wallBoxW)
        let column = Int(self.bounds.height / wallBoxH)
        
        let rowMargin = (self.bounds.width - CGFloat(row) * wallBoxW) * 0.5
        let columnMargin = (self.bounds.height - CGFloat(column) * wallBoxH) * 0.5
        
        /// 顶部墙壁
        for i in 0..<row {
            let x = CGFloat(i) * wallBoxW + rowMargin
            let y = columnMargin
            let wallBox = WallBox(frame: CGRect(x: x, y: y, width: wallBoxW, height: wallBoxH))
            self.addSubview(wallBox)
        }
        
        /// 底部墙壁
        let y = self.bounds.height - wallBoxH - columnMargin
        for i in 0..<row {
            let x = CGFloat(i) * wallBoxW + rowMargin
            let wallBox = WallBox(frame: CGRect(x: x, y: y, width: wallBoxW, height: wallBoxH))
            self.addSubview(wallBox)
        }
        
        /// 左边墙壁
        for j in 0..<column {
            let x = rowMargin
            let y = CGFloat(j) * wallBoxH + columnMargin
            let wallBox = WallBox(frame: CGRect(x: x, y: y, width: wallBoxW, height: wallBoxH))
            self.addSubview(wallBox)
        }
        
        /// 右边墙壁
        for j in 0..<column {
            let x = self.bounds.width - wallBoxW - rowMargin
            let y = CGFloat(j) * wallBoxH + columnMargin
            let wallBox = WallBox(frame: CGRect(x: x, y: y, width: wallBoxW, height: wallBoxH))
            self.addSubview(wallBox)
        }
        
        /// 墙壁分割线
        let x = rowMargin + CGFloat(Int(row / 5 * 4)) * wallBoxH
        for j in 0..<column {
            let y = CGFloat(j) * wallBoxH + columnMargin
            let wallBox = WallBox(frame: CGRect(x: x, y: y, width: wallBoxW, height: wallBoxH))
            self.addSubview(wallBox)
        }

        /// 赋值gameGroundFrame
        self.gameGroundFrame.origin.x = rowMargin + wallBoxW
        self.gameGroundFrame.origin.y = columnMargin + wallBoxH
        self.gameGroundFrame.size.width = x - wallBoxW - rowMargin
        self.gameGroundFrame.size.height = y - wallBoxH - columnMargin
        
    }
}
