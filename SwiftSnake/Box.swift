//
//  Box.swift
//  SwiftSnake
//
//  Created by ifuwo on 17/3/20.
//  Copyright © 2017年 ifuwo. All rights reserved.
//

import UIKit

struct Pos {
    var x: Int
    var y: Int
}

enum BoxType {
    case BoxTypeSnakeBody
    case BoxTypeFood
    case BoxTypeGround
}

class Box: UIView {
    
    var boxType: BoxType = .BoxTypeGround {
        didSet {
            self.layoutSubviews()
        }
    }

    var pos: Pos = Pos(x: 0, y: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.boxType == .BoxTypeGround {
            self.backgroundColor = .red
        } else if self.boxType == .BoxTypeFood {
            self.backgroundColor = .blue
        } else if self.boxType == .BoxTypeSnakeBody {
            self.backgroundColor = .yellow
        }
    }

}
