//
//  Message.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/6/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import Foundation

struct Message: Equatable, FirebaseType {
    private let kThread = "threadKey"
    private let kText = "text"
    private let kSender = "senderKey"
    
    let threadIdentifier: String
    let text: String
    let senderID: String
    var sender: User?
    var identifier: String?
    var endpoint: String {
        return "messages"
    }
    
    var jsonValue: [String: AnyObject] {
        return [kThread: threadIdentifier, kText:text, kSender:senderID]
    }
    
    init(threadIdentifier: String, text: String, senderID: String, identifier: String? = nil) {
        self.threadIdentifier = threadIdentifier
        self.text =  text
        self.senderID = senderID
        self.identifier = identifier
    }
    
    init?(json: [String: AnyObject], identifier: String) {
        guard let threadIdentifier = json[kThread] as? String,
                  text = json[kText] as? String,
                  senderID = json[kSender] as? String
            else { return nil }
        self.threadIdentifier = threadIdentifier
        self.text = text
        self.senderID = senderID
        self.identifier = identifier
    }
    
}
func ==(lhs: Message, rhs: Message) -> Bool {
    return lhs.threadIdentifier == rhs.threadIdentifier && lhs.identifier == rhs.identifier
}