//
//  ThreadController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/6/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import Foundation

class ThreadController {
    
    
    static func observeThreadsForIdentifier(identifier: String, completion: (thread: [Thread]) -> Void) {
        FirebaseController.observeDataAtEndpoint("users/\(identifier)/threadsKey") { (data) -> Void in
            if let threadIdentifierDictionary = data as? [String:AnyObject] {
                var threads: [Thread] = []
                //let group = dispatch_group_create()
                for (threadIdentifier, _) in threadIdentifierDictionary {
                 //   dispatch_group_enter(group)
                    FirebaseController.dataAtEndpoint("threads/\(threadIdentifier)", completion: { (data) -> Void in
                        if let threadDictionary = data as? [String:AnyObject] {
                            if let thread = Thread(json: threadDictionary, identifier: threadIdentifier) {
                                threads.append(thread)
                                
                                
                            }
                            //completion(thread: threads) // one value either one of them will work
                        }
                        completion(thread: threads) // one value either one of them will work
                    //    dispatch_group_leave(group)
                    })
                    //completion(thread: threads) // zero values
                }
                //completion(thread: threads) // zero values
            }
            
        }
    }
    
    
//    static func fetchThreadsForIdentifier(identifier: String, completion: (thread: Thread?) -> Void) {
//        FirebaseController.base.childByAppendingPath("users/\(identifier)/threadsKey").observeSingleEventOfType(.Value, withBlock: { (snap) -> Void in
//            if let threadDicitonary = snap.value as? [String:AnyObject] {
//                if let thread = Thread(json: threadDicitonary, identifier: identifier) {
//                    completion(thread: thread)
//                } else {
//                    completion(thread: nil)
//                }
//            } else {
//                completion(thread: nil)
//            }
//        })
//        
//    }
    
    
//    
//    static func fetchThreadsForUserID(userID: String, completion : (threads: [Thread]) -> Void) {
//        FirebaseController.dataAtEndpoint("users/\(userID)/threadsKey") { (data) -> Void in
//            if let data = data as? [String:AnyObject] {
//                let thread = data.flatMap({Thread(json: $0.1 as! [String:AnyObject], identifier: $0.0)})
//                completion(threads: thread)
//            } else {
//                completion(threads: [])
//            }
//        }
//    }
    
    static func createThread(threadName: String, users: [User], completion: (thread: Thread?) -> Void) {
        var newThread = Thread(threadName: threadName, users: users)
        newThread.save()
        if let threadID = newThread.identifier {
            for var user in users {
                user.threadIDs.append(threadID)
                user.save()
            }
        }
        completion(thread: newThread)
    }
    
    static func createMessage(text: String, sender: User, thread: Thread, completion: (message: Message?) -> Void) {
        guard let senderID = sender.identifier,
            threadID = thread.identifier else {
                completion(message: nil)
                return
        }
        var message = Message(threadIdentifier: threadID, text: text, senderID: senderID)
        message.save()
        completion(message: message)
    }
    
    
    static func deleteThread(thread: Thread) {
        thread.delete()
    }
    
    
    static func orderThreads(threads: [Thread]) -> [Thread] {
        return threads.sort({$0.0.identifier > $0.1.identifier})
    }
    
    
}