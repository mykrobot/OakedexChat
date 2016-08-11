//
//  AppDelegate.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/6/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        AppearanceController.initializeAppearances()
        return true
    }

    func applicationDidEnterBackground(application: UIApplication) {
        let device = UIDevice.currentDevice()
        if !device.name.containsString("Simulator")  {
            SessionController.sendSessionTime()
        }
    }

    func applicationDidBecomeActive(application: UIApplication) {
        SessionController.startSession()
    }
}

