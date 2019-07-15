//
//  AppDelegate.swift
//  MovDevAPP
//
//  Created by Alejandro  Rodriguez on 7/12/19.
//  Copyright © 2019 Tech. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: DogsFactory().getDogsViewController())
        self.window?.makeKeyAndVisible()
    
   

        return true
    }
}

