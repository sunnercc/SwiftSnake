//
//  GameMainScreenView.swift
//  SwiftSnake
//
//  Created by ifuwo on 17/3/21.
//  Copyright © 2017年 ifuwo. All rights reserved.
//

import UIKit

class GameMainScreenView: UIImageView {

    /// 游戏区域frame
    var gameGroundFrame: CGRect = CGRect()
    
    /// 游戏信息区域frame
    var gameMsgFrame: CGRect = CGRect()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = .black
        self.image = UIImage(named: "bg")
        
        self.isUserInteractionEnabled = true
        
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
        
        /// 赋值gameMsgFrame
        self.gameMsgFrame.origin.x = x + wallBoxW
        self.gameMsgFrame.origin.y = self.gameGroundFrame.origin.y
        self.gameMsgFrame.size.width = self.bounds.size.width - wallBoxW * 2 - rowMargin - x
        self.gameMsgFrame.size.height = self.gameGroundFrame.size.height
        
    }
}
