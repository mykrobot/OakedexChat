//
//  Thread.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/6/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import Foundation

struct Thread: Equatable, FirebaseType {
    private let kUsers = "usersKey"
    private let kThreadName = "threadNameKey"
    
    let threadName: String
    var userIDs: [String] = []
    var users: [User] = []
    var identifier: String?
    var endpoint: String {
        return "threads"
    }
    
    var jsonValue: [String:AnyObject] {
        var json: [String:AnyObject] = [kThreadName:threadName]
        var users: [String:AnyObject] = [:] // can be a bool because it is just a placeholder value for the ID number key. We only need the key (uid)
        for userID in userIDs {
            users[userID] = true
        }
        json[kUsers] = users
        return json
    }
    
    init(threadName: String, users: [User]) {
        self.threadName = threadName
        self.users = users
        var identifiers: [String] = []
        for user in users {
            if let identifier = user.identifier {
                identifiers.append(identifier)
            }
        }
        self.userIDs = identifiers
    }
    
    init?(json: [String:AnyObject], identifier: String) {
        guard let threadName = json[kThreadName] as? String else { return nil}
        self.threadName = threadName
        self.identifier = identifier
        if let usersDictionary = json[kUsers] as? [String:AnyObject] {
            userIDs = Array(usersDictionary.keys)
        }
    }
    
}

func ==(lhs: Thread, rhs: Thread) -> Bool{
    return lhs.threadName == rhs.threadName && lhs.identifier == rhs.identifier
}