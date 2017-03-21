//
//  Const.swift
//  SwiftSnake
//
//  Created by ifuwo on 17/3/20.
//  Copyright © 2017年 ifuwo. All rights reserved.
//

import UIKit

/// 屏幕宽度
let screenW: CGFloat = UIScreen.main.bounds.width

/// 屏幕高度
let screenH: CGFloat = UIScreen.main.bounds.height

/// iphone状态栏高度
let statusBarH: CGFloat = 20

/// 游戏城墙格子大小
let wallBoxW: CGFloat = 15

/// 游戏城墙格子大小
let wallBoxH: CGFloat = wallBoxW

/// 游戏方格宽度
let boxW: CGFloat = wallBoxW

/// 游戏方格高度
let boxH: CGFloat = boxW

/// 控制按钮间距
let btnMargin: CGFloat = 10

/// 控制按钮高度
let btnH: CGFloat = 30

/// 方向枚举
enum Direction {
    case DirectionUp
    case DirectionDown
    case DirectionLeft
    case DirectionRight
}


