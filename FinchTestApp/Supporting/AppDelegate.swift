//
//  AppDelegate.swift
//  FinchTestApp
//
//  Created by Mac on 06.07.2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var orientationLock = UIInterfaceOrientationMask.all

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let startingPointScreen = MainViewConfigurator.configureModuleNavigation()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = startingPointScreen
        
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return self.orientationLock
    }
    
}

