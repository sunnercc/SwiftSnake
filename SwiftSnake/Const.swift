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

/// 游戏方格宽度
let boxW: CGFloat = 30

/// 游戏方格高度
let boxH: CGFloat = boxW

/// 控制按钮间距
let btnMargin: CGFloat = 10

/// 控制按钮高度
let btnH: CGFloat = 30

/// 游戏区域外间距
let gameGoundMargin: CGFloat = btnMargin

/// 游戏区域高度
let goundGameH: CGFloat = screenH - gameGoundMargin * 2 - statusBarH - btnH

/// 游戏区域宽度
let goundGameW: CGFloat = screenW - gameGoundMargin * 2

