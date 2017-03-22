//
//  Box.swift
//  SwiftSnake
//
//  Created by ifuwo on 17/3/20.
//  Copyright © 2017年 ifuwo. All rights reserved.
//

import UIKit

/// box点坐标
struct Pos {
    var x: Int
    var y: Int
}

/// box类型
enum BoxType {
    case BoxTypeSnakeHeader      // 蛇头
    case BoxTypeSnakeBody        // 蛇身
    case BoxTypeFood             // 食物
    case BoxTypeGround           // 游戏区域原始box
}

class Box: UIImageView {
    
    /// box类型
    var boxType: BoxType = .BoxTypeGround {
        didSet {
            self.layoutSubviews()
        }
    }

    /// box点坐标
    var pos: Pos = Pos(x: 0, y: 0)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.boxType == .BoxTypeGround {
            self.backgroundColor = .clear
            self.layer.cornerRadius = 5
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.borderWidth = 0.5
            self.image = nil
        } else if self.boxType == .BoxTypeFood {

            self.backgroundColor = .clear
            let foodIndex = arc4random_uniform(8)
            self.image = UIImage(named: "food\(foodIndex)")
            
        } else if self.boxType == .BoxTypeSnakeHeader {

            self.backgroundColor = .clear
            self.image = #imageLiteral(resourceName: "snakeHeader")
            
        } else if self.boxType == .BoxTypeSnakeBody {

            self.backgroundColor = .clear
            self.image = #imageLiteral(resourceName: "snakeBody")
        }
    }

}
