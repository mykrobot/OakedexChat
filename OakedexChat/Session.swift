//
//  Session.swift
//  OakedexChat
//
//  Created by Michael Mecham on 8/4/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import Foundation

let kLaunches: String = "totalLaunches"
let kLastLaunch: String = "lastLaunch"

struct Session {
    
    private let kStart = "start"
    private let kEnd = "end"
    private let kDuration = "duration"
    private let kBundleVersion = "bundleVersion"
    private let kVersionString = "versionString"
    
    let startTime: NSTimeInterval
    var endTime: NSTimeInterval?
    let identifier = NSUUID()
    
    let appName: String = NSBundle.mainBundle().infoDictionary?["CFBundleName"] as? String ?? "N/A"
    let buildNumber: String = NSBundle.mainBundle().infoDictionary?["CFBundleVersion"] as? String ?? "N/A"
    let bundleShortVersion: String = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A"
    
    var lanuches: Int = NSUserDefaults.standardUserDefaults().integerForKey(kLaunches)
    var sessionTime: NSTimeInterval {
        if let endTime = endTime {
            return endTime - startTime
        }
        return 0
    }
    var timeSinceLastLaunch: NSTimeInterval {
        let lastLaunch = NSUserDefaults.standardUserDefaults().doubleForKey(kLastLaunch)
        let time = startTime - lastLaunch
        return time == startTime ? 0 : time
    }
}

extension Session {
    
    var jsonValue: [String:AnyObject] {
        return [kStart:startTime, kEnd:endTime ?? "no end time", kDuration:sessionTime, kLaunches:lanuches, kBundleVersion: buildNumber, kVersionString: bundleShortVersion, kLastLaunch: timeSinceLastLaunch]
    }
    
    var jsonData: NSData? {
        return try? NSJSONSerialization.dataWithJSONObject(jsonValue, options: .PrettyPrinted)
    }
    
    var endpoint: NSURL? {
        return SessionController.baseURL?.URLByAppendingPathComponent("\(appName)/\(identifier.UUIDString)").URLByAppendingPathExtension("json")
    }
    
    init(start: NSTimeInterval) {
        self.startTime = start
    }
}
