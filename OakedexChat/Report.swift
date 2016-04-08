//
//  Report.swift
//  OakedexChat
//
//  Created by Michael Mecham on 4/8/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import Foundation

struct Report: FirebaseType {
    private let kThread = "threadKey"
    
    
    let threadIdentifier: String
    var identifier: String?
    var endpoint: String {
        return "reportedContent"
    }
    var jsonValue: [String:AnyObject] {
        return [kThread:threadIdentifier]
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let threadIdentifier = json[kThread] as? String else { return nil }
        self.threadIdentifier = threadIdentifier
    }
    
    init(threadID: String, identifier: String? = nil) {
        self.threadIdentifier = threadID
    }
}