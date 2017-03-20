//
//  AppDelegate.swift
//  SwiftSnake
//
//  Created by ifuwo on 17/3/20.
//  Copyright © 2017年 ifuwo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let mainVc = MainViewController()
        mainVc.view.frame = UIScreen.main.bounds
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = mainVc
        
        self.window?.makeKeyAndVisible()
        
        return true
    }


}

