//
//  SessionController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 8/4/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import Foundation

class SessionController {
    
    static let baseURL = NSURL(string: "https://mykrobotanalytics.firebaseio.com/api")
    static let getterEndpoint = baseURL?.URLByAppendingPathExtension("json")
    static var session: Session?
    
    static func startSession() {
        session = Session(start: NSDate().timeIntervalSince1970)
    }
    
    static func endSession() {
        session?.endTime = NSDate().timeIntervalSince1970
    }
    
    static func sendSessionTime() {
        endSession()
        handleLaunchCount()
        guard let session = session, url = session.endpoint else { return }
        NetworkController.performRequestForURL(url, httpMethod: .Put, body: session.jsonData) { (data, error) in
            let responseDataString = NSString(data: data!, encoding: NSUTF8StringEncoding) ?? ""
            if error != nil {
                print("Error: \(error)")
            } else if responseDataString.containsString("error") {
                print("Error: \(responseDataString)")
            } else {
                print("Successfully saved data to endpoint. \nResponse: \(responseDataString)")
            }
        }
    }
    
    static func handleLaunchCount() {
        guard let session = session else { return }
        NSUserDefaults.standardUserDefaults().setInteger(session.launches, forKey: kLaunches)
        NSUserDefaults.standardUserDefaults().setDouble(session.startTime, forKey: kLastLaunch)
    }
}