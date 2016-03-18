//
//  User.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/6/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import Foundation

struct User: Equatable, FirebaseType {
    private let kUsername = "usernameKey"
    private let kThreads = "threadsKey"
    private let kUser = "userKey"
    
    var username: String
    var threadIDs: [String] = [] {
        didSet {
            if let currentUser = UserController.sharedController.currentUser{
                if self.identifier == currentUser.identifier {
                    self.saveUserToDefaults()
                }
            }
        }
    }
    var threads: [Thread] = []
    var identifier: String?
    var endpoint: String {
        return "users"
    }
    
    var jsonValue: [String:AnyObject] {
        var json: [String:AnyObject] = [kUsername:username]
        
        var threads: [String:AnyObject] = [:]
        for threadID in threadIDs {
            threads[threadID] = true
        }
        json[kThreads] = threads
        return json
    }
    
    init(username: String, identifier: String? = nil) {
        self.username = username
        self.identifier = identifier
    }
    
    init?(json: [String:AnyObject], identifier: String) {
        guard let username = json[kUsername] as? String
            ,threadDictionary = json[kThreads] as? [String: AnyObject]
            else { return nil}
        let threads = Array(threadDictionary.keys)
        self.username = username
        self.identifier = identifier
        self.threadIDs = threads
    }
    
    func saveUserToDefaults() {
        NSUserDefaults.standardUserDefaults().setValue(self.jsonValue, forKey: kUser)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
func ==(lhs: User, rhs: User) -> Bool {
    return lhs.username == rhs.username && lhs.identifier == rhs.identifier
}