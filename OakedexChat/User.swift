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
    
    var username: String
    var identifier: String?
    var endpoint: String {
        return "users"
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
func ==(lhs: User, rhs: User) -> Bool {
    return lhs.username == rhs.username && lhs.identifier == rhs.identifier
}