//
//  ThreadController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/6/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import Foundation

class ThreadController {
    
    static func threadsForUser(user: User, completion: (threads: [Thread]?) -> Void) {
        FirebaseController.base.childByAppendingPath("threads").queryOrderedByChild("username").queryEqualToValue(user.username).observeSingleEventOfType(.Value, withBlock: { (snap) -> Void in
            if let threadDictionaries = snap.value as? [String:AnyObject] {
                let threads = threadDictionaries.flatMap({Thread(json: $0.1 as! [String:AnyObject], identifier: $0.0)})
                let orderedThreads = orderThreads(threads)
                completion(threads: orderedThreads)
            } else {
                completion(threads: nil)
            }
        })
    }
    
    static func addThread() {
        
    }
    static func deleteThread(thread: Thread) {
        thread.delete()
    }
    
    
    static func orderThreads(threads: [Thread]) -> [Thread] {
        return threads.sort({$0.0.identifier > $0.1.identifier})
    }
    
    
}