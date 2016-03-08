//
//  Thread.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/6/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import Foundation

struct Thread: Equatable, FirebaseType {
    private let kUsername = "usernameKey"
    //private let kMessage = "messageKey"
    
    let username: String
    //var messageArray: [Message]
    var identifier: String?
    var endpoint: String {
        return "threads"
    }
    
    var jsonValue: [String:AnyObject] {
        let json: [String:AnyObject] = [kUsername:username]
        return json
    }
    
    init(username: String, identifier: String? = nil) {
        self.username = username
        self.identifier = identifier
    }
    
    init?(json: [String:AnyObject], identifier: String) {
        guard let username = json[kUsername] as? String else { return nil}
        self.username = username
        self.identifier = identifier
    }
    
}

func ==(lhs: Thread, rhs: Thread) -> Bool{
    return lhs.username == rhs.username && lhs.identifier == rhs.identifier
}