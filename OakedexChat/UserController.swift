//
//  UserController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/6/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import Foundation

class UserController {
    private let kUser = "userKey"
    
    static let sharedController = UserController()
    
//    var currentUser: User!
    
    var currentUser: User! {
        get {
            guard let uid = FirebaseController.base.authData?.uid,
                userDictionary = NSUserDefaults.standardUserDefaults().valueForKey(kUser) as? [String:AnyObject] else { return nil }
            return User(json: userDictionary, identifier: uid)
        }
        
        set {
            if let newValue = newValue {
                NSUserDefaults.standardUserDefaults().setValue(newValue.jsonValue, forKey: kUser)
                NSUserDefaults.standardUserDefaults().synchronize()
            } else {
                NSUserDefaults.standardUserDefaults().removeObjectForKey(kUser)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }
    
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        FirebaseController.dataAtEndpoint("users/\(identifier)") { (data) -> Void in
            if let data = data as? [String:AnyObject] {
                let user = User(json: data, identifier: identifier)
                completion(user: user)
            } else {
                completion(user: nil)
            }
        }
    }
    
    static func authenticateUser(email: String, password: String, completion: (success: Bool, user: User?) -> Void) {
        FirebaseController.base.authUser(email, password: password) { (error, authData) -> Void in
            if error != nil {
                completion(success: false, user: nil)
            } else {
                UserController.userForIdentifier(authData.uid, completion: { (user) -> Void in
                    if let user = user {
                        sharedController.currentUser = user
                    }
                    completion(success: true, user: user)
                })
            }
        }
    }
    
    static func createUser(email: String, password: String, username: String, completion: (success: Bool, user: User?) -> Void) {
        FirebaseController.base.createUser(email, password: password) { (error, result) -> Void in
            if let uid = result["uid"] as? String {
                var user = User(username: username, identifier: uid)
                user.save()
                authenticateUser(email, password: password, completion: { (success, user) -> Void in
                    completion(success: success, user: user)
                })
            } else {
                completion(success: false, user: nil)
            }
        }
    }
    
    static func logOutCurrent() {
        FirebaseController.base.unauth()
        UserController.sharedController.currentUser = nil
        print("\(sharedController.currentUser)")
        
    }
}





























