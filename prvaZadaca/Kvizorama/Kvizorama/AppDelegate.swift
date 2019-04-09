//
//  AppDelegate.swift
//  Kvizorama
//
//  Created by Borna Kovacevic on 30/03/2019.
//  Copyright © 2019 Borna Kovacevic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = QuizViewController()
        
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }



}

